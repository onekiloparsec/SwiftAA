/*
Module : AAPlanetPerihelionAphelion2.cpp
Purpose: Implementation for the algorithms which obtain the dates of Perihelion and Aphelion of the planets (revised version)
Created: PJN / 02-06-2020
History: PJN / 02-06-2020 1. Initial implementation
         PJN / 04-07-2022 1. Updated all the code in AAPlanetPerihelionAphelion2.cpp to use C++ uniform initialization for 
                          all variable declarations.

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
#include "AAPlanetPerihelionAphelion2.h"
#include "AAMercury.h"
#include "AAVenus.h"
#include "AAEarth.h"
#include "AAMars.h"
#include "AAJupiter.h"
#include "AASaturn.h"
#include "AAUranus.h"
#include "AANeptune.h"
#include "AAPluto.h"
#include "AAInterpolate.h"
#include <cassert>


//////////////////// Implementation ///////////////////////////////////////////

std::vector<CAAPlanetPerihelionAphelionDetails2> CAAPlanetPerihelionAphelion2::Calculate(double StartJD, double EndJD, Object object, double StepInterval, bool bHighPrecision)
{
  //What will be the return value
  std::vector<CAAPlanetPerihelionAphelionDetails2> events;

  double JD{StartJD};
  double LastDistance0{0};
  double LastDistance1{0};
  while (JD < EndJD)
  {
    double Distance{0};
    switch (object)
    {
      case Object::MERCURY:
      {
        Distance = CAAMercury::RadiusVector(JD, bHighPrecision);
        break;
      }
      case Object::VENUS:
      {
        Distance = CAAVenus::RadiusVector(JD, bHighPrecision);
        break;
      }
      case Object::EARTH:
      {
        Distance = CAAEarth::RadiusVector(JD, bHighPrecision);
        break;
      }
      case Object::MARS:
      {
        Distance = CAAMars::RadiusVector(JD, bHighPrecision);
        break;
      }
      case Object::JUPITER:
      {
        Distance = CAAJupiter::RadiusVector(JD, bHighPrecision);
        break;
      }
      case Object::SATURN:
      {
        Distance = CAASaturn::RadiusVector(JD, bHighPrecision);
        break;
      }
      case Object::URANUS:
      {
        Distance = CAAUranus::RadiusVector(JD, bHighPrecision);
        break;
      }
      case Object::NEPTUNE:
      {
        Distance = CAANeptune::RadiusVector(JD, bHighPrecision);
        break;
      }
      case Object::PLUTO:
      {
        Distance = CAAPluto::RadiusVector(JD); //No high precision algorithm for Pluto!
        break;
      }
      default:
      {
        assert(false);
        break;
      }
    }

    if ((LastDistance0 != 0) && (LastDistance1 != 0))
    {
      if ((LastDistance0 > Distance) && (LastDistance0 > LastDistance1))
      {
        CAAPlanetPerihelionAphelionDetails2 event;
        event.type = CAAPlanetPerihelionAphelionDetails2::Type::Aphelion;
        double fraction{0};
        event.Value = CAAInterpolate::Extremum(LastDistance1, LastDistance0, Distance, fraction);
        event.JD = JD - StepInterval + (fraction*StepInterval);
        events.push_back(event);
      }
      else if ((LastDistance0 < Distance) && (LastDistance0 < LastDistance1))
      {
        CAAPlanetPerihelionAphelionDetails2 event;
        event.type = CAAPlanetPerihelionAphelionDetails2::Type::Perihelion;
        double fraction{0};
        event.Value = CAAInterpolate::Extremum(LastDistance1, LastDistance0, Distance, fraction);
        event.JD = JD - StepInterval + (fraction*StepInterval);
        events.push_back(event);
      }
    }

    //Prepare for the next loop
    LastDistance1 = LastDistance0;
    LastDistance0 = Distance;
    JD += StepInterval;
  }

  return events;
}
