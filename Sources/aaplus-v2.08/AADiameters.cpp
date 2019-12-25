/*
Module : AADiameters.cpp
Purpose: Implementation for the algorithms for the semi diameters of the Sun, Moon, Planets and Asteroids
Created: PJN / 15-01-2004
History: None

Copyright (c) 2004 - 2019 by PJ Naughter (Web: www.naughter.com, Email: pjna@naughter.com)

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
#include "AADiameters.h"
#include "AAGlobe.h"
#include <cmath>
using namespace std;


//////////////////// Implementation ///////////////////////////////////////////

double CAADiameters::ApparentSaturnPolarSemidiameterA(double Delta, double B) noexcept
{
  const double cosB = cos(CAACoordinateTransformation::DegreesToRadians(B));
  return SaturnPolarSemidiameterA(Delta)*sqrt(1 - 0.199197*cosB*cosB);
}

double CAADiameters::ApparentSaturnPolarSemidiameterB(double Delta, double B) noexcept
{
  const double cosB = cos(CAACoordinateTransformation::DegreesToRadians(B));
  return SaturnPolarSemidiameterB(Delta)*sqrt(1 - 0.203800*cosB*cosB);
}

double CAADiameters::TopocentricMoonSemidiameter(double DistanceDelta, double Delta, double H, double Latitude, double Height) noexcept
{
  //Convert to radians
  H = CAACoordinateTransformation::HoursToRadians(H);
  Delta = CAACoordinateTransformation::DegreesToRadians(Delta);

  const double pi = asin(6378.14/DistanceDelta);
  const double A = cos(Delta)*sin(H);
  const double B = cos(Delta)*cos(H) - CAAGlobe::RhoCosThetaPrime(Latitude, Height)*sin(pi);
  const double C = sin(Delta) - CAAGlobe::RhoSinThetaPrime(Latitude, Height)*sin(pi);
  const double q = sqrt(A*A + B*B + C*C);

  const double s = CAACoordinateTransformation::DegreesToRadians(GeocentricMoonSemidiameter(DistanceDelta)/3600);
  return CAACoordinateTransformation::RadiansToDegrees(asin(sin(s)/q))*3600;
}

double CAADiameters::AsteroidDiameter(double H, double A) noexcept
{
  const double x = 3.12 - H/5 - 0.217147*log(A);
  return pow(10.0, x);
}
