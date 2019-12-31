/*
Module : AARiseTransitSet2.h
Purpose: Implementation for the algorithms which obtain the Rise, Transit and Set times (revised version)
Created: PJN / 29-12-2003

Copyright (c) 2019 by PJ Naughter (Web: www.naughter.com, Email: pjna@naughter.com)

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

#ifndef __AARISETRANSITSET2_H__
#define __AARISETRANSITSET2_H__

#ifndef AAPLUS_EXT_CLASS
#define AAPLUS_EXT_CLASS
#endif //#ifndef AAPLUS_EXT_CLASS


/////////////////////// Includes //////////////////////////////////////////////

#include "AA2DCoordinate.h"
#include <vector>


/////////////////////// Classes ///////////////////////////////////////////////

class AAPLUS_EXT_CLASS CAARiseTransitSetDetails2
{
public:
//Enums
  enum class Type
  {
    NotDefined = 0,
    Rise = 1,
    Set = 2,
    SouthernTransit = 3,
    NorthernTransit = 4,
    EndCivilTwilight = 5,
    EndNauticalTwilight = 6,
    EndAstronomicalTwilight = 7,
    StartAstronomicalTwilight = 8,
    StartNauticalTwilight = 9,
    StartCivilTwilight = 10
  };

//Constructors / Destructors
  CAARiseTransitSetDetails2() noexcept : type(Type::NotDefined),
                                         JD(0),
                                         Bearing(0),
                                         GeometricAltitude(false),
                                         bAboveHorizon(false)
  {
  };
  CAARiseTransitSetDetails2(const CAARiseTransitSetDetails2&) = default;
  CAARiseTransitSetDetails2(CAARiseTransitSetDetails2&&) = default;
  ~CAARiseTransitSetDetails2() = default;

//Methods
  CAARiseTransitSetDetails2& operator=(const CAARiseTransitSetDetails2&) = default;
  CAARiseTransitSetDetails2& operator=(CAARiseTransitSetDetails2&&) = default;

//Member variables
  Type type; //The type of the event which has occurred
  double JD; //When the event occurred in TT
  double Bearing; //Applicable for rise or sets only, this will be the bearing (degrees west of south) of the event
  double GeometricAltitude; //For transits only, this will contain the geometric altitude in degrees of the center of the object not including correction for refraction
  bool bAboveHorizon; //For transits only, this will be true if the transit is visible
};

class AAPLUS_EXT_CLASS CAARiseTransitSet2
{
public:
//Enums
  enum class Object
  {
    SUN,
    MOON,
    MERCURY,
    VENUS,
    MARS,
    JUPITER,
    SATURN,
    URANUS,
    NEPTUNE,
    PLUTO,
    STAR
  };

//Static methods
  static std::vector<CAARiseTransitSetDetails2> Calculate(double StartJD, double EndJD, Object object, double Longitude, double Latitude, double h0, double Height = 0, double StepInterval = 0.007, bool bHighPrecision = false);
  static std::vector<CAARiseTransitSetDetails2> CalculateMoon(double StartJD, double EndJD, double Longitude, double Latitude, double Height = 0, double StepInterval = 0.007);
  static std::vector<CAARiseTransitSetDetails2> CalculateStationary(double StartJD, double EndJD, double Alpha, double Delta, double Longitude, double Latitude, double h0 = -0.5667, double StepInterval = 0.007);

protected:
  static void AddEvents(std::vector<CAARiseTransitSetDetails2>& events, double LastAltitudeForDetectingRiseSet, double AltitudeForDetectingRiseSet,
                        double LastAltitudeForInterpolation, double h0, const CAA2DCoordinate& Horizontal, double LastJD, double StepInterval, double LastBearing,
                        Object object, double LastAltitudeForDetectingTwilight, double AltitudeForTwilight);
};


#endif //#ifndef __AARISETRANSITSET2_H__
