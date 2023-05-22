/*
Module : AAPhysicalSun.cpp
Purpose: Implementation for the algorithms which obtain the physical parameters of the Sun
Created: PJN / 29-12-2003
History: PJN / 16-06-2004 1. Fixed a typo in the calculation of SunLongDash in CAAPhysicalSun::Calculate.
                          Thanks to Brian Orme for spotting this problem.
         PJN / 16-09-2015 1. CAAPhysicalSun::Calculate now includes a "bool bHighPrecision" parameter
                          which if set to true means the code uses the full VSOP87 theory rather than the
                          truncated theory as presented in Meeus's book.
         PJN / 15-05-2017 1. Fixed an issue in CAAPhysicalSun::Calculate where the value "eta" would 
                          sometimes not be returned in the correct quadrant. Thanks to Alexandru 
                          Garofide for reporting this issue.
         PJN / 18-08-2019 1. Fixed some further compiler warnings when using VC 2019 Preview v16.3.0 Preview 2.0
         PJN / 03-07-2022 1. Updated all the code in AAPhysicalSun.cpp to use C++ uniform initialization for
                          all variable declarations.

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
#include "AAPhysicalSun.h"
#include "AASun.h"
#include "AAEarth.h"
#include "AANutation.h"
#include "AACoordinateTransformation.h"
#include <cmath>


//////////////////// Implementation ///////////////////////////////////////////

CAAPhysicalSunDetails CAAPhysicalSun::Calculate(double JD, bool bHighPrecision) noexcept
{
  double theta{CAACoordinateTransformation::MapTo0To360Range((JD - 2398220) * 360 / 25.38)};
  double I{7.25};
  double K{73.6667 + (1.3958333*(JD - 2396758)/36525)};

  //Calculate the apparent longitude of the sun (excluding the effect of nutation)
  const double L{CAAEarth::EclipticLongitude(JD, bHighPrecision)};
  const double R{CAAEarth::RadiusVector(JD, bHighPrecision)};
  double SunLong{L + 180 - CAACoordinateTransformation::DMSToDegrees(0, 0, 20.4898/R)};

  double epsilon{CAANutation::TrueObliquityOfEcliptic(JD)};

  //Convert to radians
  epsilon = CAACoordinateTransformation::DegreesToRadians(epsilon);
  SunLong = CAACoordinateTransformation::DegreesToRadians(SunLong);
  K = CAACoordinateTransformation::DegreesToRadians(K);
  I = CAACoordinateTransformation::DegreesToRadians(I);
  theta = CAACoordinateTransformation::DegreesToRadians(theta);

  const double x{atan(-cos(SunLong)*tan(epsilon))};
  const double y{atan(-cos(SunLong - K) * tan(I))};

  CAAPhysicalSunDetails details;
  details.P = CAACoordinateTransformation::RadiansToDegrees(x + y);
  details.B0 = CAACoordinateTransformation::RadiansToDegrees(asin(sin(SunLong - K)*sin(I)));
  const double SunLongMinusK{SunLong - K};
  const double eta{atan2(-sin(SunLongMinusK)*cos(I), -cos(SunLongMinusK))};
  details.L0 = CAACoordinateTransformation::MapTo0To360Range(CAACoordinateTransformation::RadiansToDegrees(eta - theta));

  return details;
}

double CAAPhysicalSun::TimeOfStartOfRotation(long C) noexcept
{
  double JED{2398140.2270 + (27.2752316*C)};
  double M{CAACoordinateTransformation::MapTo0To360Range(281.96 + (26.882476*C))};
  M = CAACoordinateTransformation::DegreesToRadians(M);
  const double twoM{2*M};
  JED += ((0.1454*sin(M)) - (0.0085*sin(twoM)) - (0.0141*cos(twoM)));
  return JED;
}
