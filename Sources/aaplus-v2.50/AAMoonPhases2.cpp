/*
Module : AAMoonNodes2.cpp
Purpose: Implementation for the algorithms which obtain the dates for the phases of the Moon (revised version)
Created: PJN / 01-01-2020
History: PJN / 01-01-2020 1. Initial implementation
         PJN / 29-06-2022 1. Updated all the code in AAMoonPhases.cpp to use C++ uniform initialization for all
                          variable declarations.

Copyright (c) 2020 - 2023 by PJ Naughter (Web: www.naughter.com, Email: pjna@naughter.com)

All rights reserved.

Copyright / Usage Details:

You are allowed to include the source code in any product (commercial, shareware, freeware or otherwise) 
when your product is released in binary form. You are allowed to modify the source code in any way you want 
except you cannot modify the copyright details at the top of each module. If you want to distribute source 
code with your application, then you are only allowed to distribute versions released by the author. This is 
to maintain a single distribution point for the source code.

*/


//////////////////// Includes /////////////////////////////////////////////////

#include "stdafx.h"
#include "AAMoonPhases2.h"
#include "AAMoon.h"
#include "AASun.h"
#include "AAPrecession.h"
#ifndef AAPLUS_NO_ELP2000
#include "AAELP2000.h"
#endif //#ifndef AAPLUS_NO_ELP2000
#ifndef AAPLUS_NO_ELPMPP02
#include "AAELPMPP02.h"
#endif //#ifndef AAPLUS_NO_ELPMPP02
#include "AACoordinateTransformation.h"
#include <cassert>


//////////////////// Implementation ///////////////////////////////////////////

std::vector<CAAMoonPhasesDetails2> CAAMoonPhases2::Calculate(double StartJD, double EndJD, double StepInterval, Algorithm algorithm)
{
  //What will be the return value
  std::vector<CAAMoonPhasesDetails2> events;

  double JD{StartJD};
  double LastJD0{0};
  double LastExcessApparentGeocentricLongitude{-360};
  while (JD < EndJD)
  {
    double ExcessApparentGeocentricLongitude{0};
    switch (algorithm)
    {
      case Algorithm::MeeusTruncated:
      {
        ExcessApparentGeocentricLongitude = CAACoordinateTransformation::MapTo0To360Range(CAAMoon::EclipticLongitude(JD) - CAASun::ApparentEclipticLongitude(JD, false));
        break;
      }
#ifndef AAPLUS_NO_ELP2000
      case Algorithm::ELP2000:
      {
        const CAA2DCoordinate MoonPos = CAAPrecession::PrecessEcliptic(CAAELP2000::EclipticLongitude(JD), CAAELP2000::EclipticLatitude(JD), 2451545.0, JD);
        ExcessApparentGeocentricLongitude = CAACoordinateTransformation::MapTo0To360Range(MoonPos.X - CAASun::ApparentEclipticLongitude(JD, true));
        break;
      }
#endif //#ifndef AAPLUS_NO_ELP2000
#ifndef AAPLUS_NO_ELPMPP02
      case Algorithm::ELPMPP02Nominal:
      {
        const CAA2DCoordinate MoonPos = CAAPrecession::PrecessEcliptic(CAAELPMPP02::EclipticLongitude(JD, CAAELPMPP02::Correction::Nominal), CAAELPMPP02::EclipticLatitude(JD, CAAELPMPP02::Correction::Nominal), 2451545.0, JD);
        ExcessApparentGeocentricLongitude = CAACoordinateTransformation::MapTo0To360Range(MoonPos.X - CAASun::ApparentEclipticLongitude(JD, true));
        break;
      }
      case Algorithm::ELPMPP02LLR:
      {
        const CAA2DCoordinate MoonPos = CAAPrecession::PrecessEcliptic(CAAELPMPP02::EclipticLongitude(JD, CAAELPMPP02::Correction::LLR), CAAELPMPP02::EclipticLatitude(JD, CAAELPMPP02::Correction::LLR), 2451545.0, JD);
        ExcessApparentGeocentricLongitude = CAACoordinateTransformation::MapTo0To360Range(MoonPos.X - CAASun::ApparentEclipticLongitude(JD, true));
        break;
      }
      case Algorithm::ELPMPP02DE405:
      {
        const CAA2DCoordinate MoonPos = CAAPrecession::PrecessEcliptic(CAAELPMPP02::EclipticLongitude(JD, CAAELPMPP02::Correction::DE405), CAAELPMPP02::EclipticLatitude(JD, CAAELPMPP02::Correction::DE405), 2451545.0, JD);
        ExcessApparentGeocentricLongitude = CAACoordinateTransformation::MapTo0To360Range(MoonPos.X - CAASun::ApparentEclipticLongitude(JD, true));
        break;
      }
      case Algorithm::ELPMPP02DE406:
      {
        const CAA2DCoordinate MoonPos = CAAPrecession::PrecessEcliptic(CAAELPMPP02::EclipticLongitude(JD, CAAELPMPP02::Correction::DE406), CAAELPMPP02::EclipticLatitude(JD, CAAELPMPP02::Correction::DE406), 2451545.0, JD);
        ExcessApparentGeocentricLongitude = CAACoordinateTransformation::MapTo0To360Range(MoonPos.X - CAASun::ApparentEclipticLongitude(JD, true));
        break;
      }
#endif //#ifndef AAPLUS_NO_ELPMPP02
      default:
      {
        assert(false);
        break;
      }
    }

    if (LastExcessApparentGeocentricLongitude != -360)
    {
      if ((LastExcessApparentGeocentricLongitude > 270) && (ExcessApparentGeocentricLongitude >= 0) && (ExcessApparentGeocentricLongitude < 90))
      {
        CAAMoonPhasesDetails2 event;
        event.type = CAAMoonPhasesDetails2::Type::NewMoon;
        const double fraction{(360 - LastExcessApparentGeocentricLongitude)/(ExcessApparentGeocentricLongitude + (360 - LastExcessApparentGeocentricLongitude))};
        event.JD = LastJD0 + (fraction*StepInterval);
        events.push_back(event);
      }
      if ((LastExcessApparentGeocentricLongitude < 90) && (ExcessApparentGeocentricLongitude >= 90))
      {
        CAAMoonPhasesDetails2 event;
        event.type = CAAMoonPhasesDetails2::Type::FirstQuarter;
        const double fraction{(90 - LastExcessApparentGeocentricLongitude)/(ExcessApparentGeocentricLongitude - LastExcessApparentGeocentricLongitude)};
        event.JD = LastJD0 + (fraction*StepInterval);
        events.push_back(event);
      }
      else if ((LastExcessApparentGeocentricLongitude < 180) && (ExcessApparentGeocentricLongitude >= 180))
      {
        CAAMoonPhasesDetails2 event;
        event.type = CAAMoonPhasesDetails2::Type::FullMoon;
        const double fraction{(180 - LastExcessApparentGeocentricLongitude)/(ExcessApparentGeocentricLongitude - LastExcessApparentGeocentricLongitude)};
        event.JD = LastJD0 + (fraction*StepInterval);
        events.push_back(event);
      }
      else if ((LastExcessApparentGeocentricLongitude < 270) && (ExcessApparentGeocentricLongitude >= 270))
      {
        CAAMoonPhasesDetails2 event;
        event.type = CAAMoonPhasesDetails2::Type::LastQuarter;
        const double fraction{(270 - LastExcessApparentGeocentricLongitude)/(ExcessApparentGeocentricLongitude - LastExcessApparentGeocentricLongitude)};
        event.JD = LastJD0 + (fraction*StepInterval);
        events.push_back(event);
      }
    }

    //Prepare for the next loop
    LastExcessApparentGeocentricLongitude = ExcessApparentGeocentricLongitude;
    LastJD0 = JD;
    JD += StepInterval;
  }

  return events;
}
