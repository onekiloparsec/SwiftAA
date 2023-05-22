/*
Module : AAEquinoxesAndSolstices2.cpp
Purpose: Implementation for the algorithms to calculate the dates of the Equinoxes and Solstices (revised version)
Created: PJN / 28-09-2019
History: PJN / 28-09-2019 1. Initial implementation
         PJN / 22-06-2022 1. Updated all the code in AAEquinoxesAndSolstices2.cpp to use C++ uniform initialization for
                          all variable declarations.

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
#include "AAEquinoxesAndSolstices2.h"
#include "AASun.h"
#include "AANutation.h"
#include "AACoordinateTransformation.h"
#include "AAInterpolate.h"
#include <cmath>


//////////////////// Implementation ///////////////////////////////////////////

std::vector<CAAEquinoxSolsticeDetails2> CAAEquinoxesAndSolstices2::Calculate(double StartJD, double EndJD, double StepInterval, bool bHighPrecision)
{
  //What will be the return value
  std::vector<CAAEquinoxSolsticeDetails2> events;

  double JD{StartJD};
  double LastJD0{0};
  double LastLatitude0{-90};
  double LastLatitude1{-90};
  while (JD < EndJD)
  {
    const double lambda{CAASun::ApparentEclipticLongitude(JD, bHighPrecision)};
    const double beta{CAASun::ApparentEclipticLatitude(JD, bHighPrecision)};
    const double epsilon{CAANutation::TrueObliquityOfEcliptic(JD)};
    const CAA2DCoordinate Solarcoord{CAACoordinateTransformation::Ecliptic2Equatorial(lambda, beta, epsilon)};
    if (LastLatitude0 != -90)
    {
      if ((LastLatitude0 < 0) && (Solarcoord.Y >= 0))
      {
        CAAEquinoxSolsticeDetails2 event;
        event.type = CAAEquinoxSolsticeDetails2::Type::NorthwardEquinox;
        const double fraction{(0 - LastLatitude0) / (Solarcoord.Y - LastLatitude0)};
        event.JD = LastJD0 + (fraction*StepInterval);
        events.push_back(event);
      }
      else if ((LastLatitude0 > 0) && (Solarcoord.Y <= 0))
      {
        CAAEquinoxSolsticeDetails2 event;
        event.type = CAAEquinoxSolsticeDetails2::Type::SouthwardEquinox;
        const double fraction{(0 - LastLatitude0) / (Solarcoord.Y - LastLatitude0)};
        event.JD = LastJD0 + (fraction*StepInterval);
        events.push_back(event);
      }
    }
    if ((LastLatitude0 != -90) && (LastLatitude1 != -90))
    {
      if ((LastLatitude0 > Solarcoord.Y) && (LastLatitude0 > LastLatitude1))
      {
        CAAEquinoxSolsticeDetails2 event;
        event.type = CAAEquinoxSolsticeDetails2::Type::NorthernSolstice;
        double fraction{0};
        event.Declination = CAAInterpolate::Extremum(LastLatitude1, LastLatitude0, Solarcoord.Y, fraction);
        event.JD = JD - StepInterval + (fraction*StepInterval);
        events.push_back(event);
      }
      else if ((LastLatitude0 < Solarcoord.Y) && (LastLatitude0 < LastLatitude1))
      {
        CAAEquinoxSolsticeDetails2 event;
        event.type = CAAEquinoxSolsticeDetails2::Type::SouthernSolstice;
        double fraction{0};
        event.Declination = CAAInterpolate::Extremum(LastLatitude1, LastLatitude0, Solarcoord.Y, fraction);
        event.JD = JD - StepInterval + (fraction*StepInterval);
        events.push_back(event);
      }
    }

    //Prepare for the next loop
    LastLatitude1 = LastLatitude0;
    LastLatitude0 = Solarcoord.Y;
    LastJD0 = JD;
    JD += StepInterval;
  }

  return events;
}
