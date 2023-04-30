/*
Module : AACoordinateTransformation.cpp
Purpose: Implementation for the algorithms which convert between the various celestial coordinate systems
Created: PJN / 29-12-2003
History: PJN / 14-02-2004 1. Fixed a "minus zero" bug in the function CAACoordinateTransformation::DMSToDegrees.
                          The sign of the value is now taken explicitly from the new bPositive boolean
                          parameter. Thanks to Patrick Wallace for reporting this problem.
         PJN / 02-06-2005 1. Most of the angular conversion functions have now been reimplemented as simply
                          numeric constants. All of the AA+ code has also been updated to use these new constants.
         PJN / 25-01-2007 1. Fixed a minor compliance issue with GCC in the AACoordinateTransformation.h to do
                          with the declaration of various methods. Thanks to Mathieu Peyréga for reporting this
                          issue.
         PJN / 30-08-2015 1. Updated the MapTo0To360Range to use the fmod C runtime function.
                          2. Updated the MapTo0To24Range to use the fmod C runtime function.
                          3. Added new MapTo0To2PIRange & MapToMinus180To180Range methods.
         PJN / 18-08-2019 1. Fixed some further compiler warnings when using VC 2019 Preview v16.3.0 Preview 2.0
         PJN / 14-06-2022 1. Updated all the code in AACoordinateTransformation.cpp to use C++ uniform
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


//////////////////////// Includes /////////////////////////////////////////////

#include "stdafx.h"
#include "AACoordinateTransformation.h"
#include <cmath>
#include <cassert>


//////////////////// Implementation ///////////////////////////////////////////

CAA2DCoordinate CAACoordinateTransformation::Equatorial2Ecliptic(double Alpha, double Delta, double Epsilon) noexcept
{
  Alpha = HoursToRadians(Alpha);
  Delta = DegreesToRadians(Delta);
  Epsilon = DegreesToRadians(Epsilon);

  CAA2DCoordinate Ecliptic;
  const double cosEpsilon = cos(Epsilon);
  const double sinEpsilon = sin(Epsilon);
  const double sinAlpha = sin(Alpha);
  Ecliptic.X = RadiansToDegrees(atan2((sinAlpha*cosEpsilon) + (tan(Delta)*sinEpsilon), cos(Alpha)));
  if (Ecliptic.X < 0)
    Ecliptic.X += 360;
  Ecliptic.Y = RadiansToDegrees(asin((sin(Delta)*cosEpsilon) - (cos(Delta)*sinEpsilon*sinAlpha)));

  return Ecliptic;
}

CAA2DCoordinate CAACoordinateTransformation::Ecliptic2Equatorial(double Lambda, double Beta, double Epsilon) noexcept
{
  Lambda = DegreesToRadians(Lambda);
  Beta = DegreesToRadians(Beta);
  Epsilon = DegreesToRadians(Epsilon);

  CAA2DCoordinate Equatorial;
  const double cosEpsilon = cos(Epsilon);
  const double sinEpsilon = sin(Epsilon);
  const double sinLambda = sin(Lambda);
  Equatorial.X = RadiansToHours(atan2((sinLambda*cosEpsilon) - (tan(Beta)*sinEpsilon), cos(Lambda)));
  if (Equatorial.X < 0)
    Equatorial.X += 24;
  Equatorial.Y = RadiansToDegrees(asin((sin(Beta)*cosEpsilon) + (cos(Beta)*sinEpsilon*sinLambda)));

  return Equatorial;
}

CAA2DCoordinate CAACoordinateTransformation::Equatorial2Horizontal(double LocalHourAngle, double Delta, double Latitude) noexcept
{
  LocalHourAngle = HoursToRadians(LocalHourAngle);
  Delta = DegreesToRadians(Delta);
  Latitude = DegreesToRadians(Latitude);

  CAA2DCoordinate Horizontal;
  const double cosLatitude = cos(Latitude);
  const double cosLocalHourAngle = cos(LocalHourAngle);
  const double sinLatitude = sin(Latitude);
  Horizontal.X = RadiansToDegrees(atan2(sin(LocalHourAngle), (cosLocalHourAngle*sinLatitude) - (tan(Delta)*cosLatitude)));
  if (Horizontal.X < 0)
    Horizontal.X += 360;
  Horizontal.Y = RadiansToDegrees(asin((sinLatitude*sin(Delta)) + (cosLatitude*cos(Delta)*cosLocalHourAngle)));

  return Horizontal;
}

CAA2DCoordinate CAACoordinateTransformation::Horizontal2Equatorial(double Azimuth, double Altitude, double Latitude) noexcept
{
  //Convert from degrees to radians
  Azimuth = DegreesToRadians(Azimuth);
  Altitude = DegreesToRadians(Altitude);
  Latitude = DegreesToRadians(Latitude);

  CAA2DCoordinate Equatorial;
  const double cosAzimuth = cos(Azimuth);
  const double sinLatitude = sin(Latitude);
  const double cosLatitude = cos(Latitude);
  Equatorial.X = RadiansToHours(atan2(sin(Azimuth), (cosAzimuth*sinLatitude) + (tan(Altitude)*cosLatitude)));
  if (Equatorial.X < 0)
    Equatorial.X += 24;
  Equatorial.Y = RadiansToDegrees(asin((sinLatitude*sin(Altitude)) - (cosLatitude*cos(Altitude)*cosAzimuth)));

  return Equatorial;
}

CAA2DCoordinate CAACoordinateTransformation::Equatorial2Galactic(double Alpha, double Delta) noexcept
{
  Alpha = 192.25 - HoursToDegrees(Alpha);
  Alpha = DegreesToRadians(Alpha);
  Delta = DegreesToRadians(Delta);

  CAA2DCoordinate Galactic;
  const double cosAlpha = cos(Alpha);
  const double sin274 = sin(DegreesToRadians(27.4));
  const double cos274 = cos(DegreesToRadians(27.4));
  Galactic.X = RadiansToDegrees(atan2(sin(Alpha), (cosAlpha*sin274) - (tan(Delta)*cos274)));
  Galactic.X = 303 - Galactic.X;
  if (Galactic.X >= 360)
    Galactic.X -= 360;
  Galactic.Y = RadiansToDegrees(asin((sin(Delta)*sin274) + (cos(Delta)*cos274*cosAlpha)));

  return Galactic;
}

CAA2DCoordinate CAACoordinateTransformation::Galactic2Equatorial(double l, double b) noexcept
{
  l -= 123;
  l = DegreesToRadians(l);
  b = DegreesToRadians(b);

  CAA2DCoordinate Equatorial;
  const double cosl = cos(l);
  const double sin274 = sin(DegreesToRadians(27.4));
  const double cos274 = cos(DegreesToRadians(27.4));
  Equatorial.X = RadiansToDegrees(atan2(sin(l), (cosl*sin274) - (tan(b)*cos274)));
  Equatorial.X += 12.25;
  if (Equatorial.X < 0)
    Equatorial.X += 360;
  Equatorial.X = DegreesToHours(Equatorial.X);
  Equatorial.Y = RadiansToDegrees(asin((sin(b)*sin274) + (cos(b)*cos274*cosl)));

  return Equatorial;
}

double CAACoordinateTransformation::DMSToDegrees(double Degrees, double Minutes, double Seconds, bool bPositive) noexcept
{
  //validate our parameters
  if (!bPositive)
  {
    assert(Degrees >= 0);  //All parameters should be non negative if the "bPositive" parameter is false
    assert(Minutes >= 0);
    assert(Seconds >= 0);
  }

  if (bPositive)
    return Degrees + (Minutes/60) + (Seconds/3600);
  else
    return -Degrees - (Minutes/60) - (Seconds/3600);
}
