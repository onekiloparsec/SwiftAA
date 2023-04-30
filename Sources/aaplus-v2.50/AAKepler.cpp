/*
Module : AAKepler.cpp
Purpose: Implementation for the algorithms which solve Kepler's equation
Created: PJN / 29-12-2003
History: PJN / 22-11-2021 1. Made some minor optimizations to the CAAKepler::Calculate method.
         PJN / 26-06-2022 1. Updated all the code in AAKepler.cpp to use C++ uniform initialization for all
                          variable declarations.

Copyright (c) 2003 - 2023 by PJ Naughter (Web: www.naughter.com, Email: pjna@naughter.com)

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
#include "AAKepler.h"
#include "AACoordinateTransformation.h"
#include <cmath>


//////////////////// Implementation ///////////////////////////////////////////

double CAAKepler::Calculate(double M, double e, int nIterations) noexcept
{
  //Convert from degrees to radians
  M = CAACoordinateTransformation::DegreesToRadians(M);
  constexpr double PI{CAACoordinateTransformation::PI()};

  double F{1};
  if (M < 0)
    F = -1;
  M = fabs(M)/(2*PI);
  M = (M - static_cast<int>(M))*2*PI*F;
  if (M < 0)
    M += (2*PI);
  F = 1;
  if (M > PI)
  {
    M = (2*PI) - M;
    F = -1;
  }

  double E{PI/2};
  double D{PI/4};
  for (int i{0}; i<nIterations; i++)
  {
    const double M1{E - (e*sin(E))};
    if (M > M1)
      E += D;
    else
      E -= D;
    D /= 2;
  }

  //Convert the result back to degrees
  return CAACoordinateTransformation::RadiansToDegrees(E)*F;
}
