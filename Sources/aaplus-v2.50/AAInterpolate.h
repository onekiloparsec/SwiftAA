/*
Module : AAInterpolate.h
Purpose: Implementation for the algorithms for Interpolation
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

#ifndef __AAINTERPOLATE_H__
#define __AAINTERPOLATE_H__

#ifndef AAPLUS_EXT_CLASS
#define AAPLUS_EXT_CLASS
#endif //#ifndef AAPLUS_EXT_CLASS


//////////////////// Classes //////////////////////////////////////////////////

class AAPLUS_EXT_CLASS CAAInterpolate
{
public:
//Static methods

#ifdef _MSC_VER
  #pragma warning(suppress : 26497)
#endif //#ifdef _MSC_VER
  static double Interpolate(double n, double Y1, double Y2, double Y3) noexcept
  {
    const double a{Y2 - Y1};
    const double b{Y3 - Y2};
    const double c{Y1 + Y3 - (2*Y2)};

    return Y2 + (n/2*(a + b + (n*c)));
  }

#ifdef _MSC_VER
  #pragma warning(suppress : 26497)
#endif //#ifdef _MSC_VER
  static double Interpolate(double n, double Y1, double Y2, double Y3, double Y4, double Y5) noexcept
  {
    const double A{Y2 - Y1};
    const double B{Y3 - Y2};
    const double C{Y4 - Y3};
    const double D{Y5 - Y4};
    const double E{B - A};
    const double F{C - B};
    const double G{D - C};
    const double H{F - E};
    const double J{G - F};
    const double K{J - H};
    const double N2{n*n};
    const double N3{N2*n};
    const double N4{N3*n};

    return Y3 + (n*(((B + C)/2) - ((H + J)/12))) + (N2*((F/2) - (K/24))) + (N3*((H + J)/12)) + (N4*(K/24));
  }

  constexpr static double InterpolateToHalves(double Y1, double Y2, double Y3, double Y4)
  {
    return ((9*(Y2 + Y3)) - Y1 - Y4)/16;
  }

  static double LagrangeInterpolate(double X, int n, const double* pX, const double* pY) noexcept;
  static double Extremum(double Y1, double Y2, double Y3, double& nm) noexcept;
  static double Extremum(double Y1, double Y2, double Y3, double Y4, double Y5, double& nm, double epsilon = 1e-12) noexcept;
  static double Zero(double Y1, double Y2, double Y3, double epsilon = 1e-12) noexcept;
  static double Zero(double Y1, double Y2, double Y3, double Y4, double Y5, double epsilon = 1e-12) noexcept;
  static double Zero2(double Y1, double Y2, double Y3, double epsilon = 1e-12) noexcept;
  static double Zero2(double Y1, double Y2, double Y3, double Y4, double Y5, double epsilon = 1e-12) noexcept;
};


#endif //#ifndef __AAINTERPOLATE_H__
