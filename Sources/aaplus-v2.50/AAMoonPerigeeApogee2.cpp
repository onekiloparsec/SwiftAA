/*
Module : AAMoonMaxDeclinations2.cpp
Purpose: Implementation for the algorithms to calculate the dates and values for Lunar Apogee and Perigee (revised version)
Created: PJN / 02-11-2009
History: PJN / 02-11-2019 1. Initial implementation
         PJN / 28-06-2022 1. Updated all the code in AAMoonPerigeeApogee2.cpp to use C++ uniform initialization for all
                          variable declarations.

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
#include "AAMoonPerigeeApogee2.h"
#include "AAMoon.h"
#ifndef AAPLUS_NO_ELP2000
#include "AAELP2000.h"
#endif //#ifndef AAPLUS_NO_ELP2000
#ifndef AAPLUS_NO_ELPMPP02
#include "AAELPMPP02.h"
#endif //#ifndef AAPLUS_NO_ELPMPP02
#include "AAInterpolate.h"
#include <cassert>


//////////////////// Implementation ///////////////////////////////////////////

std::vector<CAAMoonPerigeeApogeeDetails2> CAAMoonPerigeeApogee2::Calculate(double StartJD, double EndJD, double StepInterval, Algorithm algorithm)
{
  //What will be the return value
  std::vector<CAAMoonPerigeeApogeeDetails2> events;

  double JD{StartJD};
  double LastDistance0{0};
  double LastDistance1{0};
  while (JD < EndJD)
  {
    double MoonDistance{0};
    switch (algorithm)
    {
      case Algorithm::MeeusTruncated:
      {
        MoonDistance = CAAMoon::RadiusVector(JD);
        break;
      }
#ifndef AAPLUS_NO_ELP2000
      case Algorithm::ELP2000:
      {
        MoonDistance = CAAELP2000::RadiusVector(JD);
        break;
      }
#endif //#ifndef AAPLUS_NO_ELP2000
#ifndef AAPLUS_NO_ELPMPP02
      case Algorithm::ELPMPP02Nominal:
      {
        MoonDistance = CAAELPMPP02::RadiusVector(JD, CAAELPMPP02::Correction::Nominal);
        break;
      }
      case Algorithm::ELPMPP02LLR:
      {
        MoonDistance = CAAELPMPP02::RadiusVector(JD, CAAELPMPP02::Correction::LLR);
        break;
      }
      case Algorithm::ELPMPP02DE405:
      {
        MoonDistance = CAAELPMPP02::RadiusVector(JD, CAAELPMPP02::Correction::DE405);
        break;
      }
      case Algorithm::ELPMPP02DE406:
      {
        MoonDistance = CAAELPMPP02::RadiusVector(JD, CAAELPMPP02::Correction::DE406);
        break;
      }
#endif //#ifndef AAPLUS_NO_ELPMPP02
      default:
      {
        assert(false);
        break;
      }
    }

    if ((LastDistance0 != 0) && (LastDistance1 != 0))
    {
      if ((LastDistance0 > MoonDistance) && (LastDistance0 > LastDistance1))
      {
        CAAMoonPerigeeApogeeDetails2 event;
        event.type = CAAMoonPerigeeApogeeDetails2::Type::Apogee;
        double fraction{0};
        event.Value = CAAInterpolate::Extremum(LastDistance1, LastDistance0, MoonDistance, fraction);
        event.JD = JD - StepInterval + (fraction*StepInterval);
        events.push_back(event);
      }
      else if ((LastDistance0 < MoonDistance) && (LastDistance0 < LastDistance1))
      {
        CAAMoonPerigeeApogeeDetails2 event;
        event.type = CAAMoonPerigeeApogeeDetails2::Type::Perigee;
        double fraction{0};
        event.Value = CAAInterpolate::Extremum(LastDistance1, LastDistance0, MoonDistance, fraction);
        event.JD = JD - StepInterval + (fraction*StepInterval);
        events.push_back(event);
      }
    }

    //Prepare for the next loop
    LastDistance1 = LastDistance0;
    LastDistance0 = MoonDistance;
    JD += StepInterval;
  }

  return events;
}
