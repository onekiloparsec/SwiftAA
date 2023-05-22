/*
Module : AAVSOP87.cpp
Purpose: Implementation for the algorithms for VSOP87
Created: PJN / 26-08-2015
History: PJN / 28-08-2015 1. Initial public release.
         PJN / 08-06-2019 1. Updated the code to clean compile on VC 2019
         PJN / 29-04-2020 1. Fixed a compilation issue on GCC where size_t was undefined in various modules.
                          Thanks to Bert Devlieghe for reporting this bug.
         PJN / 12-07-2022 1. Updated all the code in AAVSOP87.cpp to use C++ uniform initialization for all
                          variable declarations.

Copyright (c) 2015 - 2023 by PJ Naughter (Web: www.naughter.com, Email: pjna@naughter.com)

All rights reserved.

Copyright / Usage Details:

You are allowed to include the source code in any product (commercial, shareware, freeware or otherwise)
when your product is released in binary form. You are allowed to modify the source code in any way you want
except you cannot modify the copyright details at the top of each module. If you want to distribute source
code with your application, then you are only allowed to distribute versions released by the author. This is
to maintain a single distribution point for the source code.

*/


//////////////////// Includes /////////////////////////////////////////////////

#include "stdafx.h"
#include "AAVSOP87.h"
#include "AACoordinateTransformation.h"
#include <cmath>
#include <cassert>


//////////////////// Macros / Defines /////////////////////////////////////////

#ifdef _MSC_VER
#pragma warning(disable : 26481)
#endif //#ifdef _MSC_VER


//////////////////// Implementation ///////////////////////////////////////////

#ifdef _MSC_VER
#pragma warning(suppress : 26429)
#endif //#ifdef _MSC_VER
double CAAVSOP87::Calculate(double JD, const VSOP87Coefficient2* pTable, size_t nTableSize, bool bAngle) noexcept
{
  //Validate our parameters
  assert(pTable);

  const double T{(JD - 2451545)/365250};
  double TTerm{T};
  double Result{0};
  for (size_t i{0}; i<nTableSize; i++)
  {
    double TempResult{0};
    for (size_t j{0}; j<pTable[i].nCoefficientsSize; j++)
#ifdef _MSC_VER
#pragma warning(suppress : 26489)
#endif //#ifdef _MSC_VER
      TempResult += (pTable[i].pCoefficients[j].A*cos(pTable[i].pCoefficients[j].B + (pTable[i].pCoefficients[j].C*T)));
    if (i)
    {
      TempResult *= TTerm;
      TTerm *= T;
    }
    Result += TempResult;
  }

  if (bAngle)
    Result = CAACoordinateTransformation::MapTo0To2PIRange(Result);

  return Result;
}

#ifdef _MSC_VER
#pragma warning(suppress : 26429)
#endif //#ifdef _MSC_VER
double CAAVSOP87::Calculate_Dash(double JD, const VSOP87Coefficient2* pTable, size_t nTableSize) noexcept
{
//Validate our parameters
  assert(pTable);

  const double T{(JD - 2451545)/365250};
  double TTerm1{1};
  double TTerm2{T};
  double Result{0};
  for (size_t i{0}; i<nTableSize; i++)
  {
    double tempPart1{0};
    double tempPart2{0};
    for (size_t j{0}; j<pTable[i].nCoefficientsSize; j++)
    {
#ifdef _MSC_VER
#pragma warning(suppress : 26489)
#endif //#ifdef _MSC_VER
      const double B_CT{pTable[i].pCoefficients[j].B + (pTable[i].pCoefficients[j].C*T)};
#ifdef _MSC_VER
#pragma warning(suppress : 26489)
#endif //#ifdef _MSC_VER
      tempPart1 += (i*pTable[i].pCoefficients[j].A*cos(B_CT));
#ifdef _MSC_VER
#pragma warning(suppress : 26489)
#endif //#ifdef _MSC_VER
      tempPart2 += (pTable[i].pCoefficients[j].A*pTable[i].pCoefficients[j].C*sin(B_CT));
    }
    if (i)
    {
      tempPart1 *= TTerm1;
      tempPart2 *= TTerm2;
      TTerm1 *= T;
      TTerm2 *= T;
    }
    Result += (tempPart1 - tempPart2);
  }

  //The value returned is in per days
  return Result/365250;
}
