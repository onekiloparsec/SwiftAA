/*
Module : AASun.h
Purpose: Implementation for the algorithms which obtain the position of the Sun
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

#ifndef __AASUN_H__
#define __AASUN_H__

#ifndef AAPLUS_EXT_CLASS
#define AAPLUS_EXT_CLASS
#endif //#ifndef AAPLUS_EXT_CLASS


//////////////////// Includes /////////////////////////////////////////////////

#include "AA3DCoordinate.h"


//////////////////// Classes //////////////////////////////////////////////////

class AAPLUS_EXT_CLASS CAASun
{
public:
//Static methods
  static double GeometricEclipticLongitude(double JD, bool bHighPrecision) noexcept;
  static double GeometricEclipticLatitude(double JD, bool bHighPrecision) noexcept;
  static double GeometricEclipticLongitudeJ2000(double JD, bool bHighPrecision) noexcept;
  static double GeometricEclipticLatitudeJ2000(double JD, bool bHighPrecision) noexcept;
  static double GeometricFK5EclipticLongitude(double JD, bool bHighPrecision) noexcept;
  static double GeometricFK5EclipticLatitude(double JD, bool bHighPrecision) noexcept;
  static double ApparentEclipticLongitude(double JD, bool bHighPrecision) noexcept;
  static double ApparentEclipticLatitude(double JD, bool bHighPrecision) noexcept;
  static double VariationGeometricEclipticLongitude(double JD) noexcept;
  static CAA3DCoordinate EquatorialRectangularCoordinatesMeanEquinox(double JD, bool bHighPrecision) noexcept;
  static CAA3DCoordinate EclipticRectangularCoordinatesJ2000(double JD, bool bHighPrecision) noexcept;
  static CAA3DCoordinate EquatorialRectangularCoordinatesJ2000(double JD, bool bHighPrecision) noexcept;
  static CAA3DCoordinate EquatorialRectangularCoordinatesB1950(double JD, bool bHighPrecision) noexcept;
  static CAA3DCoordinate EquatorialRectangularCoordinatesAnyEquinox(double JD, double JDEquinox, bool bHighPrecision) noexcept;
};


#endif //#ifndef __AASUN_H__
