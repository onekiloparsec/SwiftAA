/*
Module : AAParabolic.h
Purpose: Implementation for the algorithms for a parabolic orbit
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

#ifndef __AAPARABOLIC_H__
#define __AAPARABOLIC_H__

#ifndef AAPLUS_EXT_CLASS
#define AAPLUS_EXT_CLASS
#endif //#ifndef AAPLUS_EXT_CLASS


//////////////////// Includes /////////////////////////////////////////////////

#include "AA3DCoordinate.h"


//////////////////// Classes //////////////////////////////////////////////////

class AAPLUS_EXT_CLASS CAAParabolicObjectElements
{
public:
//Member variables
  double q{0};
  double i{0};
  double w{0};
  double omega{0};
  double JDEquinox{0};
  double T{0};
};

class AAPLUS_EXT_CLASS CAAParabolicObjectDetails
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
  double AstrometricGeocenticRA{0};
  double AstrometricGeocentricDeclination{0};
  double AstrometricGeocentricDistance{0};
  double AstrometricGeocentricLightTime{0};
  double Elongation{0};
  double PhaseAngle{0};
};

class AAPLUS_EXT_CLASS CAAParabolic
{
public:
//Static methods
  static double CalculateBarkers(double W, double epsilon = 0.000001) noexcept;
  static CAAParabolicObjectDetails Calculate(double JD, const CAAParabolicObjectElements& elements, bool bHighPrecision, double epsilon = 0.000001) noexcept;
};


#endif //#ifndef __AAPARABOLIC_H__
