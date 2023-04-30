/*
Module : AAStellarMagnitudes.cpp
Purpose: Implementation for the algorithms which operate on the stellar magnitude system
Created: PJN / 29-12-2003
History: PJN / 12-02-2004 1. Fixed a number of level 4 warnings when the code is compiled in VC.Net 2003
         PJN / 11-07-2022 1. Updated all the code in AAStellarMagnitudes.cpp to use C++ uniform
                          initialization for all variable declarations.

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
#include "AAStellarMagnitudes.h"
#include <cmath>
#include <cassert>


//////////////////// Implementation ///////////////////////////////////////////

double CAAStellarMagnitudes::CombinedMagnitude(double m1, double m2) noexcept
{
  const double x{0.4*(m2 - m1)};
  return m2 - (2.5*log10(pow(10.0, x) + 1));
}

#ifdef _MSC_VER
#pragma warning(suppress : 26429)
#endif //#ifdef _MSC_VER
double CAAStellarMagnitudes::CombinedMagnitude(int Magnitudes, const double* pMagnitudes) noexcept
{
//Validate our parameters
  assert(pMagnitudes != nullptr);

  double value{0};
  for (int i{0}; i<Magnitudes; i++)
  {
  #ifdef _MSC_VER
    #pragma warning(suppress : 26481)
  #endif //#ifdef _MSC_VER
    value += pow(10.0, -0.4*pMagnitudes[i]);
  }

  return -2.5*log10(value);
}

double CAAStellarMagnitudes::BrightnessRatio(double m1, double m2) noexcept
{
  const double x{0.4*(m2 - m1)};
  return pow(10.0, x);
}

double CAAStellarMagnitudes::MagnitudeDifference(double brightnessRatio) noexcept
{
  return 2.5*log10(brightnessRatio);
}
