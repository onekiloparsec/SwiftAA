/*
Module : AASun.cpp
Purpose: Implementation for the algorithms which obtain the position of the Sun
Created: PJN / 29-12-2003
History: PJN / 17-01-2007 1. Changed name of CAASun::ApparentEclipticLongtitude to 
                          CAASun::ApparentEclipticLongitude. Thanks to Mathieu Peyréga for reporting this
                          typo!.
         PJN / 26-07-2008 1. Changed name of CAASun::EclipticRectangularCoordinatesMeanEquinox to
                          CAASun::EquatorialRectangularCoordinatesMeanEquinox to refer to the fact that it 
                          returns equatorial coordinates instead of ecliptic coordinates. Thanks to Frank 
                          Trautmann for reporting this issue
                          2. Updated copyright details.
                          3. zip file now ships with a VC 2005 solution instead of a VC 6 solution file.
                          4. Code now compiles cleanly using Code Analysis (/analyze)
         PJN / 16-09-2015 1. All the methods in CAASun now include a "bool bHighPrecision" parameter
                          which if set to true means the code uses the full VSOP87 theory rather than the
                          truncated theory as presented in Meeus's book.
         PJN / 16-10-2016 1. Improved the accuracy of CAASun::ApparentEclipticLongitude when the bHighPrecision
                          parameter is true. The code now uses a new VariationGeometricEclipticLongitude method
                          which provides a new higher precision method to calculate the effect of aberration.
                          This takes into account that Earth's orbit around the Sun is not a purely unperturbed
                          elliptical orbit. This improves the accuracy of the sample 25.a/b from the book by
                          a couple of hundreds of arc seconds. The results now are exactly in sync with the 
                          results as reported in the book. Thanks to "Pavel" for reporting this issue.
         PJN / 18-08-2019 1. Fixed some further compiler warnings when using VC 2019 Preview v16.3.0 Preview 2.0
         PJN / 12-07-2022 1. Updated all the code in AASun.cpp to use C++ uniform initialization for all
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
#include "AASun.h"
#include "AACoordinateTransformation.h"
#include "AAEarth.h"
#include "AAFK5.h"
#include "AANutation.h"
#include <cmath>


//////////////////// Implementation ///////////////////////////////////////////

double CAASun::GeometricEclipticLongitude(double JD, bool bHighPrecision) noexcept
{
  return CAACoordinateTransformation::MapTo0To360Range(CAAEarth::EclipticLongitude(JD, bHighPrecision) + 180);
}

double CAASun::GeometricEclipticLatitude(double JD, bool bHighPrecision) noexcept
{
  return -CAAEarth::EclipticLatitude(JD, bHighPrecision);
}

double CAASun::GeometricEclipticLongitudeJ2000(double JD, bool bHighPrecision) noexcept
{
  return CAACoordinateTransformation::MapTo0To360Range(CAAEarth::EclipticLongitudeJ2000(JD, bHighPrecision) + 180);
}

double CAASun::GeometricEclipticLatitudeJ2000(double JD, bool bHighPrecision) noexcept
{
  return -CAAEarth::EclipticLatitudeJ2000(JD, bHighPrecision);
}

double CAASun::GeometricFK5EclipticLongitude(double JD, bool bHighPrecision) noexcept
{
  //Convert to the FK5 system
  double Longitude{GeometricEclipticLongitude(JD, bHighPrecision)};
  const double Latitude{GeometricEclipticLatitude(JD, bHighPrecision)};
  Longitude += CAAFK5::CorrectionInLongitude(Longitude, Latitude, JD);

  return Longitude;
}

double CAASun::GeometricFK5EclipticLatitude(double JD, bool bHighPrecision) noexcept
{
  //Convert to the FK5 system
  const double Longitude{GeometricEclipticLongitude(JD, bHighPrecision)};
  double Latitude{GeometricEclipticLatitude(JD, bHighPrecision)};
  const double SunLatCorrection{CAAFK5::CorrectionInLatitude(Longitude, JD)};
  Latitude += SunLatCorrection;

  return Latitude;
}

double CAASun::ApparentEclipticLongitude(double JD, bool bHighPrecision) noexcept
{
  double Longitude{GeometricFK5EclipticLongitude(JD, bHighPrecision)};

  //Apply the correction in longitude due to nutation
  Longitude += CAACoordinateTransformation::DMSToDegrees(0, 0, CAANutation::NutationInLongitude(JD));

  //Apply the correction in longitude due to aberration
  const double R{CAAEarth::RadiusVector(JD, bHighPrecision)};
  if (bHighPrecision)
    Longitude -= (0.005775518*R*CAACoordinateTransformation::DMSToDegrees(0, 0, VariationGeometricEclipticLongitude(JD)));
  else
    Longitude -= CAACoordinateTransformation::DMSToDegrees(0, 0, 20.4898/R);

  return Longitude;
}

double CAASun::ApparentEclipticLatitude(double JD, bool bHighPrecision) noexcept
{
  return GeometricFK5EclipticLatitude(JD, bHighPrecision);
}

CAA3DCoordinate CAASun::EquatorialRectangularCoordinatesMeanEquinox(double JD, bool bHighPrecision) noexcept
{
  const double Longitude{CAACoordinateTransformation::DegreesToRadians(GeometricFK5EclipticLongitude(JD, bHighPrecision))};
  const double sinLongitude{sin(Longitude)};
  const double Latitude{CAACoordinateTransformation::DegreesToRadians(GeometricFK5EclipticLatitude(JD, bHighPrecision))};
  const double cosLatitude{cos(Latitude)};
  const double sinLatitude{sin(Latitude)};
  const double R{CAAEarth::RadiusVector(JD, bHighPrecision)};
  const double epsilon{CAACoordinateTransformation::DegreesToRadians(CAANutation::MeanObliquityOfEcliptic(JD))};
  const double cosepsilon{cos(epsilon)};
  const double sinepsilon{sin(epsilon)};

  CAA3DCoordinate value;
  value.X = R*cosLatitude*cos(Longitude);
  value.Y = R*((cosLatitude*sinLongitude*cosepsilon) - (sinLatitude*sinepsilon));
  value.Z = R*((cosLatitude*sinLongitude*sinepsilon) + (sinLatitude*cosepsilon));
  return value;
}

CAA3DCoordinate CAASun::EclipticRectangularCoordinatesJ2000(double JD, bool bHighPrecision) noexcept
{
  double Longitude{GeometricEclipticLongitudeJ2000(JD, bHighPrecision)};
  Longitude = CAACoordinateTransformation::DegreesToRadians(Longitude);
  double Latitude{GeometricEclipticLatitudeJ2000(JD, bHighPrecision)};
  Latitude = CAACoordinateTransformation::DegreesToRadians(Latitude);
  const double coslatitude{cos(Latitude)};
  const double R{CAAEarth::RadiusVector(JD, bHighPrecision)};

  CAA3DCoordinate value;
  value.X = R*coslatitude*cos(Longitude);
  value.Y = R*coslatitude*sin(Longitude);
  value.Z = R*sin(Latitude);
  return value;
}

CAA3DCoordinate CAASun::EquatorialRectangularCoordinatesJ2000(double JD, bool bHighPrecision) noexcept
{
  CAA3DCoordinate value{EclipticRectangularCoordinatesJ2000(JD, bHighPrecision)};
  value = CAAFK5::ConvertVSOPToFK5J2000(value);
  return value;
}

CAA3DCoordinate CAASun::EquatorialRectangularCoordinatesB1950(double JD, bool bHighPrecision) noexcept
{
  CAA3DCoordinate value{EclipticRectangularCoordinatesJ2000(JD, bHighPrecision)};
  value = CAAFK5::ConvertVSOPToFK5B1950(value);
  return value;
}

CAA3DCoordinate CAASun::EquatorialRectangularCoordinatesAnyEquinox(double JD, double JDEquinox, bool bHighPrecision) noexcept
{
  CAA3DCoordinate value{EquatorialRectangularCoordinatesJ2000(JD, bHighPrecision)};
  value = CAAFK5::ConvertVSOPToFK5AnyEquinox(value, JDEquinox);
  return value;
}

double CAASun::VariationGeometricEclipticLongitude(double JD) noexcept
{
  //D is the number of days since the epoch
  const double D{JD - 2451545};
  const double tau{D/365250};
  const double tau2{tau*tau};
  const double tau3{tau2*tau};

  const double deltaLambda{3548.193 + 
                           (118.568*sin(CAACoordinateTransformation::DegreesToRadians(87.5287 + (359993.7286*tau)))) +
                           (2.476*sin(CAACoordinateTransformation::DegreesToRadians(85.0561 + (719987.4571*tau)))) +
                           (1.376*sin(CAACoordinateTransformation::DegreesToRadians(27.8502 + (4452671.1152*tau)))) +
                           (0.119*sin(CAACoordinateTransformation::DegreesToRadians(73.1375 + (450368.8564*tau)))) +
                           (0.114*sin(CAACoordinateTransformation::DegreesToRadians(337.2264 + (329644.6718*tau)))) +
                           (0.086*sin(CAACoordinateTransformation::DegreesToRadians(222.5400 + (659289.3436*tau)))) +
                           (0.078*sin(CAACoordinateTransformation::DegreesToRadians(162.8136 + (9224659.7915*tau)))) +
                           (0.054*sin(CAACoordinateTransformation::DegreesToRadians(82.5823 + (1079981.1857*tau)))) +
                           (0.052*sin(CAACoordinateTransformation::DegreesToRadians(171.5189 + (225184.4282*tau)))) +
                           (0.034*sin(CAACoordinateTransformation::DegreesToRadians(30.3214 + (4092677.3866*tau)))) +
                           (0.033*sin(CAACoordinateTransformation::DegreesToRadians(119.8105 + (337181.4711*tau)))) +
                           (0.023*sin(CAACoordinateTransformation::DegreesToRadians(247.5418 + (299295.6151*tau)))) +
                           (0.023*sin(CAACoordinateTransformation::DegreesToRadians(325.1526 + (315559.5560*tau)))) +
                           (0.021*sin(CAACoordinateTransformation::DegreesToRadians(155.1241 + (675553.2846*tau)))) +
                           (7.311*tau*sin(CAACoordinateTransformation::DegreesToRadians(333.4515 + (359993.7286*tau)))) +
                           (0.305*tau*sin(CAACoordinateTransformation::DegreesToRadians(330.9814 + (719987.4571*tau)))) +
                           (0.010*tau*sin(CAACoordinateTransformation::DegreesToRadians(328.5170 + (1079981.1857*tau)))) +
                           (0.309*tau2*sin(CAACoordinateTransformation::DegreesToRadians(241.4518 + (359993.7286*tau)))) +
                           (0.021*tau2*sin(CAACoordinateTransformation::DegreesToRadians(205.0482 + (719987.4571*tau)))) +
                           (0.004*tau2*sin(CAACoordinateTransformation::DegreesToRadians(297.8610 + (4452671.1152*tau)))) +
                           (0.010*tau3*sin(CAACoordinateTransformation::DegreesToRadians(154.7066 + (359993.7286*tau))))};
  return deltaLambda;
}
