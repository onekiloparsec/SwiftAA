/*
Module : AAEclipticalElements.cpp
Purpose: Implementation for the algorithms which map the ecliptical elements from one equinox to another
Created: PJN / 29-12-2003
History: PJN / 29-11-2006 1. Fixed a bug where CAAEclipticalElements::Calculate and CAAEclipticalElements::FK4B1950ToFK5J2000
                          would return the incorrect value for the reduced inclination when the initial inclination value
                          was > 90 degrees.
         PJN / 18-08-2019 1. Fixed some further compiler warnings when using VC 2019 Preview v16.3.0 Preview 2.0
         PJN / 19-06-2022 1. Updated all the code in AAEclipticalElements.cpp to use C++ uniform initialization for all 
                          variable declarations.

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
#include "AAEclipticalElements.h"
#include "AACoordinateTransformation.h"
#include <cmath>


//////////////////// Implementation ///////////////////////////////////////////

CAAEclipticalElementDetails CAAEclipticalElements::Calculate(double i0, double w0, double omega0, double JD0, double JD) noexcept
{
  const double T{(JD0 - 2451545)/36525};
  const double Tsquared{T*T};
  const double t{(JD - JD0)/36525};
  const double tsquared{t*t};
  const double tcubed{tsquared*t};

  //Now convert to radians
  const double i0rad{CAACoordinateTransformation::DegreesToRadians(i0)};
  const double omega0rad{CAACoordinateTransformation::DegreesToRadians(omega0)};

  double eta{(47.0029 - (0.06603*T) + (0.000598*Tsquared))*t + ((-0.03302 + (0.000598*T))*tsquared) + (0.00006*tcubed)};
  eta = CAACoordinateTransformation::DegreesToRadians(CAACoordinateTransformation::DMSToDegrees(0, 0, eta));

  double pi{(174.876384*3600) + (3289.4789*T) + (0.60622*Tsquared) - ((869.8089 + (0.50491*T))*t) + (0.03536*tsquared)};
  pi = CAACoordinateTransformation::DegreesToRadians(CAACoordinateTransformation::DMSToDegrees(0, 0, pi));

  double p{((5029.0966 + (2.22226*T) - (0.000042*Tsquared))*t) + ((1.11113 - (0.000042*T))*tsquared) - (0.000006*tcubed)};
  p = CAACoordinateTransformation::DegreesToRadians(CAACoordinateTransformation::DMSToDegrees(0, 0, p));

  const double sini0rad{sin(i0rad)};
  const double cosi0rad{cos(i0rad)};
  const double sinomega0rad_pi{sin(omega0rad - pi)};
  const double cosomega0rad_pi{cos(omega0rad - pi)};
  const double sineta{sin(eta)};
  const double coseta{cos(eta)};
  double A{sini0rad*sinomega0rad_pi};
  double B{(-sineta*cosi0rad) + (coseta*sini0rad*cosomega0rad_pi)};
  const double irad{asin(sqrt((A*A) + (B*B)))};

  CAAEclipticalElementDetails details;
  details.i = CAACoordinateTransformation::RadiansToDegrees(irad);
  const double cosi{(cosi0rad*coseta) + (sini0rad*sineta*cosomega0rad_pi)};
  if (cosi < 0)
    details.i = 180 - details.i;

  const double phi{pi + p};
  details.omega = CAACoordinateTransformation::MapTo0To360Range(CAACoordinateTransformation::RadiansToDegrees(atan2(A, B) + phi));

  A = -sineta*sinomega0rad_pi;
  B = (sini0rad*coseta) - (cosi0rad*sineta*cosomega0rad_pi);
  const double deltaw{CAACoordinateTransformation::RadiansToDegrees(atan2(A, B))};
  details.w = CAACoordinateTransformation::MapTo0To360Range(w0 + deltaw);

  return details;
}

CAAEclipticalElementDetails CAAEclipticalElements::FK4B1950ToFK5J2000(double i0, double w0, double omega0) noexcept
{
  //convert to radians
  constexpr double L{CAACoordinateTransformation::DegreesToRadians(5.19856209)};
  constexpr double J{CAACoordinateTransformation::DegreesToRadians(0.00651966)};
  const double i0rad{CAACoordinateTransformation::DegreesToRadians(i0)};
  const double omega0rad{CAACoordinateTransformation::DegreesToRadians(omega0)};
  const double sini0rad{sin(i0rad)};
  const double cosi0rad{cos(i0rad)};

  //Calculate some values used later
  const double cosJ{cos(J)};
  const double sinJ{sin(J)};
  const double W{L + omega0rad};
  const double cosW{cos(W)};
  const double sinW{sin(W)};
  const double A{sinJ*sinW};
  const double B{(sini0rad*cosJ) + (cosi0rad*sinJ*cosW)};

  //Calculate the values 
  CAAEclipticalElementDetails details;
  details.i = CAACoordinateTransformation::RadiansToDegrees(asin(sqrt((A*A) + (B*B))));
  const double cosi{(cosi0rad*cosJ) - (sini0rad*sinJ*cosW)};
  if (cosi < 0)
    details.i = 180 - details.i;

  details.w = CAACoordinateTransformation::MapTo0To360Range(w0 + CAACoordinateTransformation::RadiansToDegrees(atan2(A, B)));
  details.omega = CAACoordinateTransformation::MapTo0To360Range(CAACoordinateTransformation::RadiansToDegrees(atan2(sini0rad*sinW, (cosi0rad*sinJ) + (sini0rad*cosJ*cosW))) - 4.50001688);

  return details;
}
