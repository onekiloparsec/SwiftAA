/*
Module : AAElliptical.h
Purpose: Implementation for the algorithms for an elliptical orbit
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

#ifndef __AAELLIPTICAL_H__
#define __AAELLIPTICAL_H__

#ifndef AAPLUS_EXT_CLASS
#define AAPLUS_EXT_CLASS
#endif //#ifndef AAPLUS_EXT_CLASS


//////////////////// Includes /////////////////////////////////////////////////

#include "AA3DCoordinate.h"


//////////////////// Classes //////////////////////////////////////////////////

class AAPLUS_EXT_CLASS CAAEllipticalObjectElements
{
public:
//Member variables
  double a{0};
  double e{0};
  double i{0};
  double w{0};
  double omega{0};
  double JDEquinox{0};
  double T{0};
};

class AAPLUS_EXT_CLASS CAAEllipticalPlanetaryDetails
{
public:
//Member variables
  double ApparentGeocentricEclipticalLongitude{0};
  double ApparentGeocentricEclipticalLatitude{0};
  double ApparentGeocentricDistance{0};
  double ApparentLightTime{0};
  double ApparentGeocentricRA{0};
  double ApparentGeocentricDeclination{0};
  CAA3DCoordinate TrueGeocentricRectangularEcliptical;
  double TrueHeliocentricEclipticalLongitude{0};
  double TrueHeliocentricEclipticalLatitude{0};
  double TrueHeliocentricDistance{0};
  double TrueGeocentricEclipticalLongitude{0};
  double TrueGeocentricEclipticalLatitude{0};
  double TrueGeocentricDistance{0};
  double TrueLightTime{0};
  double TrueGeocentricRA{0};
  double TrueGeocentricDeclination{0};
};

class AAPLUS_EXT_CLASS CAAEllipticalObjectDetails
{
public:
//Member variables
  CAA3DCoordinate HeliocentricRectangularEquatorial;
  CAA3DCoordinate HeliocentricRectangularEcliptical;
  double HeliocentricEclipticLongitude{0};
  double HeliocentricEclipticLatitude{0};
  double TrueGeocentricRA{0};
  double TrueGeocentricDeclination{0};
  double TrueGeocentricDistance{0};
  double TrueGeocentricLightTime{0};
  double AstrometricGeocentricRA{0};
  double AstrometricGeocentricDeclination{0};
  double AstrometricGeocentricDistance{0};
  double AstrometricGeocentricLightTime{0};
  double Elongation{0};
  double PhaseAngle{0};
};

class AAPLUS_EXT_CLASS CAAElliptical
{
public:
//Enums
  enum class Object
  {
    SUN,
    MERCURY,
    VENUS,
    MARS,
    JUPITER,
    SATURN,
    URANUS,
    NEPTUNE
  };

//Static methods

  constexpr static double DistanceToLightTime(double Distance)
  {
    return Distance*0.0057755183;
  }

  static CAAEllipticalPlanetaryDetails Calculate(double JD, Object object, bool bHighPrecision) noexcept;

  constexpr static double SemiMajorAxisFromPerihelionDistance(double q, double e)
  {
    return q/(1 - e);
  }

  static double MeanMotionFromSemiMajorAxis(double a) noexcept;
  static CAAEllipticalObjectDetails Calculate(double JD, const CAAEllipticalObjectElements& elements, bool bHighPrecision) noexcept;
  static double InstantaneousVelocity(double r, double a) noexcept;
  static double VelocityAtPerihelion(double e, double a) noexcept;
  static double VelocityAtAphelion(double e, double a) noexcept;
  static double LengthOfEllipse(double e, double a) noexcept;
  static double CometMagnitude(double g, double delta, double k, double r) noexcept;
  static double MinorPlanetMagnitude(double H, double delta, double G, double r, double PhaseAngle) noexcept;
};


#endif //#ifndef __AAELLIPTICAL_H__
