/*
Module : AAMoonMaxDeclinations2.cpp
Purpose: Implementation for the algorithms to calculate the dates and values for maximum declination of the Moon (revised version)
Created: PJN / 22-10-2009
History: PJN / 22-10-2019 1. Initial implementation
         PJN / 27-06-2022 1. Updated all the code in AAMoonMaxDeclinations2.cpp to use C++ uniform initialization
                          for all variable declarations.

Copyright (c) 2019 - 2023 by PJ Naughter (Web: www.naughter.com, Email: pjna@naughter.com)

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
#include "AAMoonMaxDeclinations2.h"
#include "AAMoon.h"
#ifndef AAPLUS_NO_ELP2000
#include "AAELP2000.h"
#endif //#ifndef AAPLUS_NO_ELP2000
#ifndef AAPLUS_NO_ELPMPP02
#include "AAELPMPP02.h"
#endif //#ifndef AAPLUS_NO_ELPMPP02
#include "AANutation.h"
#include "AACoordinateTransformation.h"
#include "AAInterpolate.h"
#include "AAPrecession.h"
#include "AARiseTransitSet.h"
#include <cassert>


//////////////////// Implementation ///////////////////////////////////////////

std::vector<CAAMoonMaxDeclinationsDetails2> CAAMoonMaxDeclinations2::Calculate(double StartJD, double EndJD, double StepInterval, Algorithm algorithm)
{
  //What will be the return value
  std::vector<CAAMoonMaxDeclinationsDetails2> events;

  double JD{StartJD};
  double LastLatitude0{-90};
  double LastLatitude1{-90};
  double LastRA0{0};
  double LastRA1{0};
  while (JD < EndJD)
  {
    double MoonLong{0};
    double MoonLat{0};
    switch (algorithm)
    {
      case Algorithm::MeeusTruncated:
      {
        MoonLong = CAAMoon::EclipticLongitude(JD);
        MoonLat = CAAMoon::EclipticLatitude(JD);
        break;
      }
#ifndef AAPLUS_NO_ELP2000
      case Algorithm::ELP2000:
      {
        MoonLong = CAAELP2000::EclipticLongitude(JD);
        MoonLat = CAAELP2000::EclipticLatitude(JD);
        break;
      }
#endif //#ifndef AAPLUS_NO_ELP2000
#ifndef AAPLUS_NO_ELPMPP02
      case Algorithm::ELPMPP02Nominal:
      {
        MoonLong = CAAELPMPP02::EclipticLongitude(JD, CAAELPMPP02::Correction::Nominal);
        MoonLat = CAAELPMPP02::EclipticLatitude(JD, CAAELPMPP02::Correction::Nominal);
        break;
      }
      case Algorithm::ELPMPP02LLR:
      {
        MoonLong = CAAELPMPP02::EclipticLongitude(JD, CAAELPMPP02::Correction::LLR);
        MoonLat = CAAELPMPP02::EclipticLatitude(JD, CAAELPMPP02::Correction::LLR);
        break;
      }
      case Algorithm::ELPMPP02DE405:
      {
        MoonLong = CAAELPMPP02::EclipticLongitude(JD, CAAELPMPP02::Correction::DE405);
        MoonLat = CAAELPMPP02::EclipticLatitude(JD, CAAELPMPP02::Correction::DE405);
        break;
      }
      case Algorithm::ELPMPP02DE406:
      {
        MoonLong = CAAELPMPP02::EclipticLongitude(JD, CAAELPMPP02::Correction::DE406);
        MoonLat = CAAELPMPP02::EclipticLatitude(JD, CAAELPMPP02::Correction::DE406);
        break;
      }
#endif //#ifndef AAPLUS_NO_ELPMPP02
      default:
      {
        assert(false);
        break;
      }
    }
    CAA2DCoordinate Equatorial{CAACoordinateTransformation::Ecliptic2Equatorial(MoonLong, MoonLat, CAANutation::TrueObliquityOfEcliptic(JD))};

    //Precess the coordinates if required
    if (algorithm != Algorithm::MeeusTruncated)
      Equatorial = CAAPrecession::PrecessEquatorial(Equatorial.X, Equatorial.Y, 2451545, JD);

    if ((LastLatitude0 != -90) && (LastLatitude1 != -90))
    {
      double tempRA{Equatorial.X};
      double tempLastRA1{LastRA1};
      double tempLastRA0{LastRA0};
      CAARiseTransitSet::CorrectRAValuesForInterpolation(tempLastRA1, tempLastRA0, tempRA);
      if ((LastLatitude0 > Equatorial.Y) && (LastLatitude0 > LastLatitude1))
      {
        CAAMoonMaxDeclinationsDetails2 event;
        event.type = CAAMoonMaxDeclinationsDetails2::Type::MaxNorthernDeclination;
        double fraction{0};
        event.Declination = CAAInterpolate::Extremum(LastLatitude1, LastLatitude0, Equatorial.Y, fraction);
        event.RA = CAACoordinateTransformation::MapTo0To24Range(CAAInterpolate::Interpolate(fraction, tempLastRA1, tempLastRA0, tempRA));
        event.JD = JD - StepInterval + (fraction*StepInterval);
        events.push_back(event);
      }
      else if ((LastLatitude0 < Equatorial.Y) && (LastLatitude0 < LastLatitude1))
      {
        CAAMoonMaxDeclinationsDetails2 event;
        event.type = CAAMoonMaxDeclinationsDetails2::Type::MaxSouthernDeclination;
        double fraction{0};
        event.Declination = CAAInterpolate::Extremum(LastLatitude1, LastLatitude0, Equatorial.Y, fraction);
        event.RA = CAACoordinateTransformation::MapTo0To24Range(CAAInterpolate::Interpolate(fraction, tempLastRA1, tempLastRA0, tempRA));
        event.JD = JD - StepInterval + (fraction*StepInterval);
        events.push_back(event);
      }
    }

    //Prepare for the next loop
    LastLatitude1 = LastLatitude0;
    LastLatitude0 = Equatorial.Y;
    LastRA1 = LastRA0;
    LastRA0 = Equatorial.X;
    JD += StepInterval;
  }

  return events;
}
