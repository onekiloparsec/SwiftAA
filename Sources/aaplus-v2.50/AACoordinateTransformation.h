/*
Module : AACoordinateTransformation.h
Purpose: Implementation for the algorithms which convert between the various celestial coordinate systems
Created: PJN / 29-12-2003

Copyright (c) 2003 - 2023 by PJ Naughter (Web: www.naughter.com, Email: pjna@naughter.com)

All rights reserved.

Copyright / Usage Details:

You are allowed to include the source code in any product (commercial, shareware, freeware or otherwise) 
when your product is released in binary form. You are allowed to modify the source code in any way you want 
except you cannot modify the copyright details at the top of each module. If you want to distribute source 
code with your application, then you are only allowed to distribute versions released by the author. This is 
to maintain a single distribution point for the source code.

*/


//////////////////// Macros / Defines /////////////////////////////////////////

#if _MSC_VER > 1000
#pragma once
#endif //#if _MSC_VER > 1000

#ifndef __AACOORDINATETRANSFORMATION_H__
#define __AACOORDINATETRANSFORMATION_H__

#ifndef AAPLUS_EXT_CLASS
#define AAPLUS_EXT_CLASS
#endif //#ifndef AAPLUS_EXT_CLASS


//////////////////// Includes /////////////////////////////////////////////////

#include "AA2DCoordinate.h"
#include <cmath>


//////////////////// Classes //////////////////////////////////////////////////

class AAPLUS_EXT_CLASS CAACoordinateTransformation
{
public:
//Conversion functions
  static CAA2DCoordinate Equatorial2Ecliptic(double Alpha, double Delta, double Epsilon) noexcept;
  static CAA2DCoordinate Ecliptic2Equatorial(double Lambda, double Beta, double Epsilon) noexcept;
  static CAA2DCoordinate Equatorial2Horizontal(double LocalHourAngle, double Delta, double Latitude) noexcept;
  static CAA2DCoordinate Horizontal2Equatorial(double A, double h, double Latitude) noexcept;
  static CAA2DCoordinate Equatorial2Galactic(double Alpha, double Delta) noexcept;
  static CAA2DCoordinate Galactic2Equatorial(double l, double b) noexcept;

//Inlined functions
  constexpr static inline double DegreesToRadians(double Degrees) noexcept
  {
    return Degrees * 0.017453292519943295769236907684886;
  }

  constexpr static inline double RadiansToDegrees(double Radians) noexcept
  {
    return Radians * 57.295779513082320876798154814105;
  }

  constexpr static inline double RadiansToHours(double Radians) noexcept
  {
    return Radians * 3.8197186342054880584532103209403;
  }

  constexpr static inline double HoursToRadians(double Hours) noexcept
  {
    return Hours * 0.26179938779914943653855361527329;
  }

  constexpr static inline double HoursToDegrees(double Hours) noexcept
  {
    return Hours * 15;
  }

  constexpr static inline double DegreesToHours(double Degrees) noexcept
  {
    return Degrees / 15;
  }

  constexpr static inline double PI() noexcept
  {
    return 3.1415926535897932384626433832795;
  }

  static inline double MapTo0To360Range(double Degrees) noexcept
  {
#ifdef _MSC_VER
    #pragma warning(suppress : 26447)
#endif //#ifdef _MSC_VER
    double fResult{fmod(Degrees, 360)};
    if (fResult < 0)
      fResult += 360;
    return fResult;
  }

  static inline double MapToMinus90To90Range(double Degrees) noexcept
  {
    double fResult{MapTo0To360Range(Degrees)};

    if (fResult > 270)
      fResult = fResult - 360;
    else if (fResult > 180)
      fResult = 180 - fResult;
    else if (fResult > 90)
      fResult = 180 - fResult;

    return fResult;
  }

  static inline double MapTo0To24Range(double HourAngle) noexcept
  {
#ifdef _MSC_VER
    #pragma warning(suppress : 26447)
#endif //#ifdef _MSC_VER
    double fResult{fmod(HourAngle, 24)};
    if (fResult < 0)
      fResult += 24;
    return fResult;
  }

  static inline double MapTo0To2PIRange(double Angle) noexcept
  {
    double fResult{fmod(Angle, 2 * PI())};
    if (fResult < 0)
      fResult += (2 * PI());
    return fResult;
  }

  static double DMSToDegrees(double Degrees, double Minutes, double Seconds, bool bPositive = true) noexcept;
};


#endif //#ifndef __AACOORDINATETRANSFORMATION_H__
