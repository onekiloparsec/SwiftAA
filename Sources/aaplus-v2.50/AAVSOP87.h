/*
Module : AAVSOP87.h
Purpose: Implementation for the algorithms for VSOP87
Created: PJN / 29-08-2015

Copyright (c) 2015 - 2023 by PJ Naughter (Web: www.naughter.com, Email: pjna@naughter.com)

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

#ifndef __AAVSOP87_H__
#define __AAVSOP87_H__

#ifndef AAPLUS_EXT_CLASS
#define AAPLUS_EXT_CLASS
#endif //#ifndef AAPLUS_EXT_CLASS


//////////////////// Includes /////////////////////////////////////////////////

#include <cstddef>


//////////////////// Classes //////////////////////////////////////////////////

struct VSOP87Coefficient
{
  double A;
  double B;
  double C;
};

struct VSOP87Coefficient2
{
  const VSOP87Coefficient* pCoefficients;
  size_t nCoefficientsSize;
};

class AAPLUS_EXT_CLASS CAAVSOP87
{
public:
//Static methods
  static double Calculate(double JD, const VSOP87Coefficient2* pTable, size_t nTableSize, bool bAngle) noexcept;
  static double Calculate_Dash(double JD, const VSOP87Coefficient2* pTable, size_t nTableSize) noexcept;
};


#endif //#ifndef __AAVSOP87_H__
