/*
Module : AAPlanetPerihelionAphelion.cpp
Purpose: Implementation for the algorithms which obtain the dates of Perihelion and Aphelion of the planets
Created: PJN / 29-12-2003
History: PJN / 18-08-2019 1. Fixed some further compiler warnings when using VC 2019 Preview v16.3.0 Preview 2.0
         PJN / 12-03-2021 1. Changed the behavior of the CAAPlanetPerihelionAphelion::*K methods to now return 
                          the K value before it is rounded. This new behaviour is now consistent with all the 
                          other methods in the AA+ framework which return so called "K" values. This means that 
                          client code must round this value before calling other methods in this class with 
                          this K value.
                          2. Merged the separate perihelion and aphelion methods for all the planets except Earth
                          in CAAPlanetPerihelionAphelion into one method per planet. This new behaviour is now 
                          consistent with all the other methods in the AA+ framework which work with so called 
                          "K" values
                          3. Fixed a bug in CAAPlanetPerihelionAphelion::EarthAphelion where the kdash and 
                          ksquared values were not being calculated correctly.
         PJN / 04-07-2022 1. Updated all the code in AAPlanetPerihelionAphelion.cpp to use C++ uniform 
                          initialization for all variable declarations.

Copyright (c) 2003 - 2023 by PJ Naughter (Web: www.naughter.com, Email: pjna@naughter.com)

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
#include "AAPlanetPerihelionAphelion.h"
#include "AACoordinateTransformation.h"
#include <cmath>


//////////////////// Implementation ///////////////////////////////////////////

double CAAPlanetPerihelionAphelion::EarthPerihelion(double k, bool bBarycentric) noexcept
{
  const double ksquared{k*k};
  double JD{2451547.507 + (365.2596358*k) + (0.0000000156*ksquared)};

  if (!bBarycentric)
  {
    //Apply the corrections
    double A1{CAACoordinateTransformation::MapTo0To360Range(328.41 + (132.788585*k))};
    A1 = CAACoordinateTransformation::DegreesToRadians(A1);
    double A2{CAACoordinateTransformation::MapTo0To360Range(316.13 + (584.903153*k))};
    A2 = CAACoordinateTransformation::DegreesToRadians(A2);
    double A3{CAACoordinateTransformation::MapTo0To360Range(346.20 + (450.380738*k))};
    A3 = CAACoordinateTransformation::DegreesToRadians(A3);
    double A4{CAACoordinateTransformation::MapTo0To360Range(136.95 + (659.306737*k))};
    A4 = CAACoordinateTransformation::DegreesToRadians(A4);
    double A5{CAACoordinateTransformation::MapTo0To360Range(249.52 + (329.653368*k))};
    A5 = CAACoordinateTransformation::DegreesToRadians(A5);

    JD += (1.278*sin(A1));
    JD -= (0.055*sin(A2));
    JD -= (0.091*sin(A3));
    JD -= (0.056*sin(A4));
    JD -= (0.045*sin(A5));
  }

  return JD;
}

double CAAPlanetPerihelionAphelion::EarthAphelion(double k, bool bBarycentric) noexcept
{
  const double ksquared{k*k};
  double JD{2451547.507 + (365.2596358*k) + (0.0000000156*ksquared)};

  if (!bBarycentric)
  {
    //Apply the corrections
    double A1{CAACoordinateTransformation::MapTo0To360Range(328.41 + (132.788585*k))};
    A1 = CAACoordinateTransformation::DegreesToRadians(A1);
    double A2{CAACoordinateTransformation::MapTo0To360Range(316.13 + (584.903153*k))};
    A2 = CAACoordinateTransformation::DegreesToRadians(A2);
    double A3{CAACoordinateTransformation::MapTo0To360Range(346.20 + (450.380738*k))};
    A3 = CAACoordinateTransformation::DegreesToRadians(A3);
    double A4{CAACoordinateTransformation::MapTo0To360Range(136.95 + (659.306737*k))};
    A4 = CAACoordinateTransformation::DegreesToRadians(A4);
    double A5{CAACoordinateTransformation::MapTo0To360Range(249.52 + (329.653368*k))};
    A5 = CAACoordinateTransformation::DegreesToRadians(A5);

    JD -= (1.352*sin(A1));
    JD += (0.061*sin(A2));
    JD += (0.062*sin(A3));
    JD += (0.029*sin(A4));
    JD += (0.031*sin(A5));
  }

  return JD;
}
