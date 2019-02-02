/*
Module : AAPlanetPerihelionAphelion.cpp
Purpose: Implementation for the algorithms which obtain the dates of Perihelion and Aphelion of the planets
Created: PJN / 29-12-2003
History: None

Copyright (c) 2003 - 2019 by PJ Naughter (Web: www.naughter.com, Email: pjna@naughter.com)

All rights reserved.

Copyright / Usage Details:

You are allowed to include the source code in any product (commercial, shareware, freeware or otherwise) 
when your product is released in binary form. You are allowed to modify the source code in any way you want 
except you cannot modify the copyright details at the top of each module. If you want to distribute source 
code with your application, then you are only allowed to distribute versions released by the author. This is 
to maintain a single distribution point for the source code. 

*/


///////////////////////////////// Includes ////////////////////////////////////

#include "stdafx.h"
#include "AAPlanetPerihelionAphelion.h"
#include "AACoordinateTransformation.h"
#include <cmath>
using namespace std;


///////////////////////////////// Implementation //////////////////////////////

double CAAPlanetPerihelionAphelion::EarthPerihelion(long k, bool bBarycentric)
{
  const double kdash = k;
  const double ksquared = kdash * kdash;
  double JD = 2451547.507 + 365.2596358*kdash + 0.0000000156*ksquared;

  if (!bBarycentric)
  {
    //Apply the corrections
    double A1 = CAACoordinateTransformation::MapTo0To360Range(328.41 + 132.788585*k);
    A1 = CAACoordinateTransformation::DegreesToRadians(A1);
    double A2 = CAACoordinateTransformation::MapTo0To360Range(316.13 + 584.903153*k);
    A2 = CAACoordinateTransformation::DegreesToRadians(A2);
    double A3 = CAACoordinateTransformation::MapTo0To360Range(346.20 + 450.380738*k);
    A3 = CAACoordinateTransformation::DegreesToRadians(A3);
    double A4 = CAACoordinateTransformation::MapTo0To360Range(136.95 + 659.306737*k);
    A4 = CAACoordinateTransformation::DegreesToRadians(A4);
    double A5 = CAACoordinateTransformation::MapTo0To360Range(249.52 + 329.653368*k);
    A5 = CAACoordinateTransformation::DegreesToRadians(A5);

    JD += 1.278*sin(A1);
    JD -= 0.055*sin(A2);
    JD -= 0.091*sin(A3);
    JD -= 0.056*sin(A4);
    JD -= 0.045*sin(A5);
  }

  return JD;
}

double CAAPlanetPerihelionAphelion::EarthAphelion(long k, bool bBarycentric)
{
  const double kdash = k + 0.5;
  const double ksquared = kdash * kdash;
  double JD = 2451547.507 + 365.2596358*kdash + 0.0000000156*ksquared;

  if (!bBarycentric)
  {
    //Apply the corrections
    double A1 = CAACoordinateTransformation::MapTo0To360Range(328.41 + 132.788585*k);
    A1 = CAACoordinateTransformation::DegreesToRadians(A1);
    double A2 = CAACoordinateTransformation::MapTo0To360Range(316.13 + 584.903153*k);
    A2 = CAACoordinateTransformation::DegreesToRadians(A2);
    double A3 = CAACoordinateTransformation::MapTo0To360Range(346.20 + 450.380738*k);
    A3 = CAACoordinateTransformation::DegreesToRadians(A3);
    double A4 = CAACoordinateTransformation::MapTo0To360Range(136.95 + 659.306737*k);
    A4 = CAACoordinateTransformation::DegreesToRadians(A4);
    double A5 = CAACoordinateTransformation::MapTo0To360Range(249.52 + 329.653368*k);
    A5 = CAACoordinateTransformation::DegreesToRadians(A5);

    JD -= 1.352*sin(A1);
    JD += 0.061*sin(A2);
    JD += 0.062*sin(A3);
    JD += 0.029*sin(A4);
    JD += 0.031*sin(A5);
  }

  return JD;
}
