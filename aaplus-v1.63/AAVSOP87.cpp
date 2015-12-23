/*
Module : AAVSOP87.cpp
Purpose: Implementation for the algorithms for VSOP87
Created: PJN / 26-08-2015
History: PJN / 28-08-2015 1. Initial public release.

Copyright (c) 2015 by PJ Naughter (Web: www.naughter.com, Email: pjna@naughter.com)

All rights reserved.

Copyright / Usage Details:

You are allowed to include the source code in any product (commercial, shareware, freeware or otherwise)
when your product is released in binary form. You are allowed to modify the source code in any way you want
except you cannot modify the copyright details at the top of each module. If you want to distribute source
code with your application, then you are only allowed to distribute versions released by the author. This is
to maintain a single distribution point for the source code.

*/


/////////////////////////////// Includes //////////////////////////////////////

#include "stdafx.h"
#include "AAVSOP87.h"
#include "AACoordinateTransformation.h"
#include <cmath>
using namespace std;


////////////////////////////// Implementation ///////////////////////////////

double CVSOP87::Calculate(double JD, const VSOP87Coefficient2* pTable, int nTableSize, bool bAngle)
{
  double T = (JD - 2451545) / 365250;
  double TTerm = T;
  double Result = 0;
  for (int i = 0; i<nTableSize; i++)
  {
    double TempResult = 0;
    for (int j = 0; j < pTable[i].nCoefficientsSize; j++)
      TempResult += pTable[i].pCoefficients[j].A * cos(pTable[i].pCoefficients[j].B + pTable[i].pCoefficients[j].C*T);
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

double CVSOP87::Calculate_Dash(double JD, const VSOP87Coefficient2* pTable, int nTableSize)
{
  double T = (JD - 2451545) / 365250;
  double TTerm1 = 1;
  double TTerm2 = T;
  double Result = 0;
  for (int i = 0; i<nTableSize; i++)
  {
    double tempPart1 = 0;
    double tempPart2 = 0;
    for (int j = 0; j < pTable[i].nCoefficientsSize; j++)
    {
      double B_CT = pTable[i].pCoefficients[j].B + pTable[i].pCoefficients[j].C*T;
      tempPart1 += i * pTable[i].pCoefficients[j].A                                * cos(B_CT);
      tempPart2 +=     pTable[i].pCoefficients[j].A * pTable[i].pCoefficients[j].C * sin(B_CT);
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
  return Result / 365250;
}



