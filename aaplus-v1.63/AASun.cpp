/*
Module : AASUN.CPP
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

Copyright (c) 2003 - 2015 by PJ Naughter (Web: www.naughter.com, Email: pjna@naughter.com)

All rights reserved.

Copyright / Usage Details:

You are allowed to include the source code in any product (commercial, shareware, freeware or otherwise) 
when your product is released in binary form. You are allowed to modify the source code in any way you want 
except you cannot modify the copyright details at the top of each module. If you want to distribute source 
code with your application, then you are only allowed to distribute versions released by the author. This is 
to maintain a single distribution point for the source code. 

*/


//////////////////////////// Includes /////////////////////////////////////////

#include "stdafx.h"
#include "AASun.h"
#include "AACoordinateTransformation.h"
#include "AAEarth.h"
#include "AAFK5.h"
#include "AANutation.h"
#include <cmath>
using namespace std;


//////////////////////////// Implementation ///////////////////////////////////

double CAASun::GeometricEclipticLongitude(double JD, bool bHighPrecision)
{
  return CAACoordinateTransformation::MapTo0To360Range(CAAEarth::EclipticLongitude(JD, bHighPrecision) + 180);
}

double CAASun::GeometricEclipticLatitude(double JD, bool bHighPrecision)
{
  return -CAAEarth::EclipticLatitude(JD, bHighPrecision);
}

double CAASun::GeometricEclipticLongitudeJ2000(double JD, bool bHighPrecision)
{
  return CAACoordinateTransformation::MapTo0To360Range(CAAEarth::EclipticLongitudeJ2000(JD, bHighPrecision) + 180);
}

double CAASun::GeometricEclipticLatitudeJ2000(double JD, bool bHighPrecision)
{
  return -CAAEarth::EclipticLatitudeJ2000(JD, bHighPrecision);
}

double CAASun::GeometricFK5EclipticLongitude(double JD, bool bHighPrecision)
{
  //Convert to the FK5 stystem
  double Longitude = GeometricEclipticLongitude(JD, bHighPrecision);
  double Latitude = GeometricEclipticLatitude(JD, bHighPrecision);
  Longitude += CAAFK5::CorrectionInLongitude(Longitude, Latitude, JD);

  return Longitude;
}

double CAASun::GeometricFK5EclipticLatitude(double JD, bool bHighPrecision)
{
  //Convert to the FK5 stystem
  double Longitude = GeometricEclipticLongitude(JD, bHighPrecision);
  double Latitude = GeometricEclipticLatitude(JD, bHighPrecision);
  double SunLatCorrection = CAAFK5::CorrectionInLatitude(Longitude, JD);
  Latitude += SunLatCorrection;

  return Latitude;
}

double CAASun::ApparentEclipticLongitude(double JD, bool bHighPrecision)
{
  double Longitude = GeometricFK5EclipticLongitude(JD, bHighPrecision);

  //Apply the correction in longitude due to nutation
  Longitude += CAACoordinateTransformation::DMSToDegrees(0, 0, CAANutation::NutationInLongitude(JD));

  //Apply the correction in longitude due to aberration
  double R = CAAEarth::RadiusVector(JD, bHighPrecision);
  Longitude -= CAACoordinateTransformation::DMSToDegrees(0, 0, 20.4898 / R);

  return Longitude;
}

double CAASun::ApparentEclipticLatitude(double JD, bool bHighPrecision)
{
  return GeometricFK5EclipticLatitude(JD, bHighPrecision);
}

CAA3DCoordinate CAASun::EquatorialRectangularCoordinatesMeanEquinox(double JD, bool bHighPrecision)
{
  double Longitude = CAACoordinateTransformation::DegreesToRadians(GeometricFK5EclipticLongitude(JD, bHighPrecision));
  double Latitude = CAACoordinateTransformation::DegreesToRadians(GeometricFK5EclipticLatitude(JD, bHighPrecision));
  double R = CAAEarth::RadiusVector(JD, bHighPrecision);
  double epsilon = CAACoordinateTransformation::DegreesToRadians(CAANutation::MeanObliquityOfEcliptic(JD));

  CAA3DCoordinate value;
  value.X = R * cos(Latitude) * cos(Longitude);
  value.Y = R * (cos(Latitude) * sin(Longitude) * cos(epsilon) - sin(Latitude) * sin(epsilon));
  value.Z = R * (cos(Latitude) * sin(Longitude) * sin(epsilon) + sin(Latitude) * cos(epsilon));

  return value;
}

CAA3DCoordinate CAASun::EclipticRectangularCoordinatesJ2000(double JD, bool bHighPrecision)
{
  double Longitude = GeometricEclipticLongitudeJ2000(JD, bHighPrecision);
  Longitude = CAACoordinateTransformation::DegreesToRadians(Longitude);
  double Latitude = GeometricEclipticLatitudeJ2000(JD, bHighPrecision);
  Latitude = CAACoordinateTransformation::DegreesToRadians(Latitude);
  double R = CAAEarth::RadiusVector(JD, bHighPrecision);

  CAA3DCoordinate value;
  double coslatitude = cos(Latitude);
  value.X = R * coslatitude * cos(Longitude);
  value.Y = R * coslatitude * sin(Longitude);
  value.Z = R * sin(Latitude);

  return value;
}

CAA3DCoordinate CAASun::EquatorialRectangularCoordinatesJ2000(double JD, bool bHighPrecision)
{
  CAA3DCoordinate value = EclipticRectangularCoordinatesJ2000(JD, bHighPrecision);
  value = CAAFK5::ConvertVSOPToFK5J2000(value);

  return value;
}

CAA3DCoordinate CAASun::EquatorialRectangularCoordinatesB1950(double JD, bool bHighPrecision)
{
  CAA3DCoordinate value = EclipticRectangularCoordinatesJ2000(JD, bHighPrecision);
  value = CAAFK5::ConvertVSOPToFK5B1950(value);

  return value;
}

CAA3DCoordinate CAASun::EquatorialRectangularCoordinatesAnyEquinox(double JD, double JDEquinox, bool bHighPrecision)
{
  CAA3DCoordinate value = EquatorialRectangularCoordinatesJ2000(JD, bHighPrecision);
  value = CAAFK5::ConvertVSOPToFK5AnyEquinox(value, JDEquinox);

  return value;
}
