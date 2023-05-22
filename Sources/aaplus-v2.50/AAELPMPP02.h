/*
Module : AAELPMPP02.h
Purpose: Implementation for the algorithms for ELP/MPP02
Created: PJN / 30-07-2017

Copyright (c) 2017 - 2023 by PJ Naughter (Web: www.naughter.com, Email: pjna@naughter.com)

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
#endif

#ifndef __AAELPMPP02_H__
#define __AAELPMPP02_H__

#ifndef AAPLUS_EXT_CLASS
#define AAPLUS_EXT_CLASS
#endif


//////////////////// Includes /////////////////////////////////////////////////

#include "AA2DCoordinate.h"
#include "AA3DCoordinate.h"


//////////////////// Classes //////////////////////////////////////////////////

class AAPLUS_EXT_CLASS CAAELPMPP02
{
public:
//Enums
  enum class Correction
  {
    Nominal = 0,
    LLR,
    DE405,
    DE406
  };

//Static methods
  static double EclipticLongitude(double JD, Correction correction = Correction::LLR, double* pDerivative = nullptr) noexcept;
  static double EclipticLongitude(const double* pT, int nTSize, Correction correction = Correction::LLR, double* pDerivative = nullptr) noexcept;
  static double EclipticLatitude(double JD, Correction correction = Correction::LLR, double* pDerivative = nullptr) noexcept;
  static double EclipticLatitude(const double* pT, int nTSize, Correction correction = Correction::LLR, double* pDerivative = nullptr) noexcept;
  static double RadiusVector(double JD, Correction correction = Correction::LLR, double* pDerivative = nullptr) noexcept;
  static double RadiusVector(const double* pT, int nTSize, Correction correction = Correction::LLR, double* pDerivative = nullptr) noexcept;
  static CAA3DCoordinate EclipticRectangularCoordinates(double JD, Correction correction = Correction::LLR, CAA3DCoordinate* pDerivative = nullptr) noexcept;
  static CAA3DCoordinate EclipticRectangularCoordinates(const double* pT, int nTSize, Correction correction = Correction::LLR, CAA3DCoordinate* pDerivative = nullptr) noexcept;
  static CAA3DCoordinate EclipticRectangularCoordinatesJ2000(double JD, Correction correction = Correction::LLR, CAA3DCoordinate* pDerivative = nullptr) noexcept;
  static CAA3DCoordinate EclipticRectangularCoordinatesJ2000(const double* pT, int nTSize, Correction correction = Correction::LLR, CAA3DCoordinate* pDerivative = nullptr) noexcept;
};


#endif //#ifndef __AAELPMPP02_H__
