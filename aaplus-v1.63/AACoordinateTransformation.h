/*
Module : AACOORDINATETRANSFORMATION.H
Purpose: Implementation for the algorithms which convert between the various celestial coordinate systems
Created: PJN / 29-12-2003

Copyright (c) 2003 - 2015 by PJ Naughter (Web: www.naughter.com, Email: pjna@naughter.com)

All rights reserved.

Copyright / Usage Details:

You are allowed to include the source code in any product (commercial, shareware, freeware or otherwise) 
when your product is released in binary form. You are allowed to modify the source code in any way you want 
except you cannot modify the copyright details at the top of each module. If you want to distribute source 
code with your application, then you are only allowed to distribute versions released by the author. This is 
to maintain a single distribution point for the source code. 

*/


/////////////////////// Macros / Defines //////////////////////////////////////

#if _MSC_VER > 1000
#pragma once
#endif //#if _MSC_VER > 1000

#ifndef __AACOORDINATETRANSFORMATION_H__
#define __AACOORDINATETRANSFORMATION_H__

#ifndef AAPLUS_EXT_CLASS
#define AAPLUS_EXT_CLASS
#endif //#ifndef AAPLUS_EXT_CLASS


/////////////////////// Includes //////////////////////////////////////////////

#include "AA2DCoordinate.h"
#include <cmath>


/////////////////////// Classes ///////////////////////////////////////////////

class AAPLUS_EXT_CLASS CAACoordinateTransformation
{
public:
//Conversion functions
  static CAA2DCoordinate Equatorial2Ecliptic(double Alpha, double Delta, double Epsilon);
  static CAA2DCoordinate Ecliptic2Equatorial(double Lambda, double Beta, double Epsilon);
  static CAA2DCoordinate Equatorial2Horizontal(double LocalHourAngle, double Delta, double Latitude);
  static CAA2DCoordinate Horizontal2Equatorial(double A, double h, double Latitude);
  static CAA2DCoordinate Equatorial2Galactic(double Alpha, double Delta);
  static CAA2DCoordinate Galactic2Equatorial(double l, double b);

//Inlined functions
  static inline double DegreesToRadians(double Degrees)
  {
    return Degrees * 0.017453292519943295769236907684886;
  }

  static inline double RadiansToDegrees(double Radians)
  {
    return Radians * 57.295779513082320876798154814105;
  }

  static inline double RadiansToHours(double Radians)
  {
    return Radians * 3.8197186342054880584532103209403;
  }

  static inline double HoursToRadians(double Hours)
  {
    return Hours * 0.26179938779914943653855361527329;
  }

  static inline double HoursToDegrees(double Hours)
  {
    return Hours * 15;
  }

  static inline double DegreesToHours(double Degrees)
  {
    return Degrees / 15;
  }

  static inline double PI()
  {
    return 3.1415926535897932384626433832795;
  }

  static inline double MapTo0To360Range(double Degrees)
  {
    double fResult = fmod(Degrees, 360);
    if (fResult < 0)
      fResult += 360;
    return fResult;
  }

  static inline double MapToMinus90To90Range(double Degrees)
  {
    double fResult = MapTo0To360Range(Degrees);

    if (fResult > 270)
      fResult = fResult - 360;
    else if (fResult > 180)
      fResult = 180 - fResult;
    else if (fResult > 90)
      fResult = 180 - fResult;

    return fResult;
  }

  static inline double MapTo0To24Range(double HourAngle)
  {
    double fResult = fmod(HourAngle, 24);
    if (fResult < 0)
      fResult += 24;
    return fResult;
  }

  static inline double MapTo0To2PIRange(double Angle)
  {
    double fResult = fmod(Angle, 2 * PI());
    if (fResult < 0)
      fResult += (2 * PI());
    return fResult;
  }

  static double DMSToDegrees(double Degrees, double Minutes, double Seconds, bool bPositive = true);
};


#endif //#ifndef __AACOORDINATETRANSFORMATION_H__
