/*
Module : AANutation.cpp
Purpose: Implementation for the algorithms for Nutation
Created: PJN / 29-12-2003
History: PJN / 10-05-2010 1. Removed the unused Delta parameter from the CAANutation::NutationInDeclination method.
                          Thanks to Thomas Meyer for reporting this issue.
         PJN / 18-03-2012 1. All global "g_*" tables are now const. Thanks to Roger Dahl for reporting this 
                          issue when compiling AA+ on ARM.
         PJN / 18-08-2019 1. Fixed some further compiler warnings when using VC 2019 Preview v16.3.0 Preview 2.0
         PJN / 15-04-2020 1. Reworked C arrays to use std::array
         PJN / 01-07-2022 1. Updated all the code in AANutation.cpp to use C++ uniform initialization for all
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
#include "AANutation.h"
#include "AACoordinateTransformation.h"
#include <cmath>
#include <array>


//////////////////// Macros / Defines /////////////////////////////////////////

#ifdef _MSC_VER
#pragma warning(disable : 26446 26482)
#endif //#ifdef _MSC_VER

struct NutationCoefficient
{
  int D;
  int M;
  int Mprime;
  int F;
  int omega;
  int sincoeff1;
  double sincoeff2;
  int coscoeff1;
  double coscoeff2;
};

constexpr std::array<NutationCoefficient, 63> g_NutationCoefficients
{ {
  {  0,  0,  0,  0,  1, -171996,  -174.2,  92025,     8.9    },
  { -2,  0,  0,  2,  2,  -13187,    -1.6,   5736,    -3.1    },
  {  0,  0,  0,  2,  2,   -2274,    -0.2,    977,    -0.5    },
  {  0,  0,  0,  0,  2,    2062,     0.2,   -895,     0.5    },
  {  0,  1,  0,  0,  0,    1426,    -3.4,     54,    -0.1    },
  {  0,  0,  1,  0,  0,     712,     0.1,     -7,       0    },
  { -2,  1,  0,  2,  2,    -517,     1.2,    224,    -0.6    },
  {  0,  0,  0,  2,  1,    -386,    -0.4,    200,       0    },
  {  0,  0,  1,  2,  2,    -301,       0,    129,    -0.1    },
  { -2, -1,  0,  2,  2,     217,    -0.5,    -95,     0.3    },
  { -2,  0,  1,  0,  0,    -158,       0,      0,       0    },
  { -2,  0,  0,  2,  1,     129,     0.1,    -70,       0    },
  {  0,  0, -1,  2,  2,     123,       0,    -53,       0    },
  {  2,  0,  0,  0,  0,      63,       0,      0,       0    },
  {  0,  0,  1,  0,  1,      63,     0.1,    -33,       0    },
  {  2,  0, -1,  2,  2,     -59,       0,     26,       0    },
  {  0,  0, -1,  0,  1,     -58,    -0.1,     32,       0    },
  {  0,  0,  1,  2,  1,     -51,       0,     27,       0    },
  { -2,  0,  2,  0,  0,      48,       0,      0,       0    },
  {  0,  0, -2,  2,  1,      46,       0,    -24,       0    },
  {  2,  0,  0,  2,  2,     -38,       0,     16,       0    },
  {  0,  0,  2,  2,  2,     -31,       0,     13,       0    },
  {  0,  0,  2,  0,  0,      29,       0,      0,       0    },
  { -2,  0,  1,  2,  2,      29,       0,    -12,       0    },
  {  0,  0,  0,  2,  0,      26,       0,      0,       0    },
  { -2,  0,  0,  2,  0,     -22,       0,      0,       0    },
  {  0,  0, -1,  2,  1,      21,       0,    -10,       0    },
  {  0,  2,  0,  0,  0,      17,    -0.1,      0,       0    },
  {  2,  0, -1,  0,  1,      16,       0,     -8,       0    },
  { -2,  2,  0,  2,  2,     -16,     0.1,      7,       0    },
  {  0,  1,  0,  0,  1,     -15,       0,      9,       0    },
  { -2,  0,  1,  0,  1,     -13,       0,      7,       0    },
  {  0, -1,  0,  0,  1,     -12,       0,      6,       0    },
  {  0,  0,  2, -2,  0,      11,       0,      0,       0    },
  {  2,  0, -1,  2,  1,     -10,       0,      5,       0    },
  {  2,  0,  1,  2,  2,     -8,        0,      3,       0    },
  {  0,  1,  0,  2,  2,      7,        0,     -3,       0    },
  { -2,  1,  1,  0,  0,     -7,        0,      0,       0    },
  {  0, -1,  0,  2,  2,     -7,        0,      3,       0    },
  {  2,  0,  0,  2,  1,     -7,        0,      3,       0    },
  {  2,  0,  1,  0,  0,      6,        0,      0,       0    },
  { -2,  0,  2,  2,  2,      6,        0,     -3,       0    },
  { -2,  0,  1,  2,  1,      6,        0,     -3,       0    },
  {  2,  0, -2,  0,  1,     -6,        0,      3,       0    },
  {  2,  0,  0,  0,  1,     -6,        0,      3,       0    },
  {  0, -1,  1,  0,  0,      5,        0,      0,       0    },
  { -2, -1,  0,  2,  1,     -5,        0,      3,       0    },
  { -2,  0,  0,  0,  1,     -5,        0,      3,       0    },
  {  0,  0,  2,  2,  1,     -5,        0,      3,       0    },
  { -2,  0,  2,  0,  1,      4,        0,      0,       0    },
  { -2,  1,  0,  2,  1,      4,        0,      0,       0    },
  {  0,  0,  1, -2,  0,      4,        0,      0,       0    },
  { -1,  0,  1,  0,  0,     -4,        0,      0,       0    },
  { -2,  1,  0,  0,  0,     -4,        0,      0,       0    },
  {  1,  0,  0,  0,  0,     -4,        0,      0,       0    },
  {  0,  0,  1,  2,  0,      3,        0,      0,       0    },
  {  0,  0, -2,  2,  2,     -3,        0,      0,       0    },
  { -1, -1,  1,  0,  0,     -3,        0,      0,       0    },
  {  0,  1,  1,  0,  0,     -3,        0,      0,       0    },
  {  0, -1,  1,  2,  2,     -3,        0,      0,       0    },
  {  2, -1, -1,  2,  2,     -3,        0,      0,       0    },
  {  0,  0,  3,  2,  2,     -3,        0,      0,       0    },
  {  2, -1,  0,  2,  2,     -3,        0,      0,       0    }
} };


///////////////////////////// Implementation //////////////////////////////////

double CAANutation::NutationInLongitude(double JD) noexcept
{
  const double T{(JD - 2451545)/36525};
  const double Tsquared{T*T};
  const double Tcubed{Tsquared*T};

  double D{297.85036 + (445267.111480*T) - (0.0019142*Tsquared) + (Tcubed/189474)};
  D = CAACoordinateTransformation::MapTo0To360Range(D);

  double M{357.52772 + (35999.050340*T) - (0.0001603*Tsquared) - (Tcubed/300000)};
  M = CAACoordinateTransformation::MapTo0To360Range(M);

  double Mprime{134.96298 + (477198.867398*T) + (0.0086972*Tsquared) + (Tcubed/56250)};
  Mprime = CAACoordinateTransformation::MapTo0To360Range(Mprime);

  double F{93.27191 + (483202.017538*T) - (0.0036825*Tsquared) + (Tcubed/327270)};
  F = CAACoordinateTransformation::MapTo0To360Range(F);

  double omega{125.04452 - (1934.136261*T) + (0.0020708*Tsquared) + (Tcubed/450000)};
  omega = CAACoordinateTransformation::MapTo0To360Range(omega);

  double value{0};
  for (const auto& coeff : g_NutationCoefficients)
  {
    double argument{(coeff.D*D) + (coeff.M*M) + (coeff.Mprime*Mprime) + (coeff.F*F) + (coeff.omega*omega)};
    argument = CAACoordinateTransformation::DegreesToRadians(argument);
    value += (coeff.sincoeff1 + (coeff.sincoeff2*T))*sin(argument)*0.0001;
  }

  return value;
}

double CAANutation::NutationInObliquity(double JD) noexcept
{
  const double T{(JD - 2451545)/36525};
  const double Tsquared{T*T};
  const double Tcubed{Tsquared*T};

  double D{297.85036 + (445267.111480*T) - (0.0019142*Tsquared) + (Tcubed/189474)};
  D = CAACoordinateTransformation::MapTo0To360Range(D);

  double M{357.52772 + (35999.050340*T) - (0.0001603*Tsquared) - (Tcubed/300000)};
  M = CAACoordinateTransformation::MapTo0To360Range(M);

  double Mprime{134.96298 + (477198.867398*T) + (0.0086972*Tsquared) + (Tcubed/56250)};
  Mprime = CAACoordinateTransformation::MapTo0To360Range(Mprime);

  double F{93.27191 + (483202.017538*T) - (0.0036825*Tsquared) + (Tcubed/327270)};
  F = CAACoordinateTransformation::MapTo0To360Range(F);

  double omega{125.04452 - (1934.136261*T) + (0.0020708*Tsquared) + (Tcubed / 450000)};
  omega = CAACoordinateTransformation::MapTo0To360Range(omega);

  double value{0};
  for (const auto& coeff : g_NutationCoefficients)
  {
    double argument{(coeff.D*D) + (coeff.M*M) + (coeff.Mprime*Mprime) + (coeff.F*F) + (coeff.omega*omega)};
    argument = CAACoordinateTransformation::DegreesToRadians(argument);
    value += (coeff.coscoeff1 + (coeff.coscoeff2*T))*cos(argument)*0.0001;
  }

  return value;
}

double CAANutation::MeanObliquityOfEcliptic(double JD) noexcept
{
  const double U{(JD - 2451545)/3652500};
  const double Usquared{U*U};
  const double Ucubed{Usquared*U};
  const double U4{Ucubed*U};
  const double U5{U4*U};
  const double U6{U5*U};
  const double U7{U6*U};
  const double U8{U7*U};
  const double U9{U8*U};
  const double U10{U9*U};

  return CAACoordinateTransformation::DMSToDegrees(23, 26, 21.448) - (CAACoordinateTransformation::DMSToDegrees(0, 0, 4680.93)*U)
                                                                   - (CAACoordinateTransformation::DMSToDegrees(0, 0, 1.55)*Usquared)
                                                                   + (CAACoordinateTransformation::DMSToDegrees(0, 0, 1999.25)*Ucubed)
                                                                   - (CAACoordinateTransformation::DMSToDegrees(0, 0, 51.38)*U4)
                                                                   - (CAACoordinateTransformation::DMSToDegrees(0, 0, 249.67)*U5)
                                                                   - (CAACoordinateTransformation::DMSToDegrees(0, 0, 39.05)*U6)
                                                                   + (CAACoordinateTransformation::DMSToDegrees(0, 0, 7.12)*U7)
                                                                   + (CAACoordinateTransformation::DMSToDegrees(0, 0, 27.87)*U8)
                                                                   + (CAACoordinateTransformation::DMSToDegrees(0, 0, 5.79)*U9)
                                                                   + (CAACoordinateTransformation::DMSToDegrees(0, 0, 2.45)*U10);
}

double CAANutation::TrueObliquityOfEcliptic(double JD) noexcept
{
  return MeanObliquityOfEcliptic(JD) + CAACoordinateTransformation::DMSToDegrees(0, 0, NutationInObliquity(JD));
}

double CAANutation::NutationInRightAscension(double Alpha, double Delta, double Obliquity, double NutationInLongitude, double NutationInObliquity) noexcept
{
  //Convert to radians
  Alpha = CAACoordinateTransformation::HoursToRadians(Alpha);
  Delta = CAACoordinateTransformation::DegreesToRadians(Delta);
  Obliquity = CAACoordinateTransformation::DegreesToRadians(Obliquity);

  return ((cos(Obliquity) + (sin(Obliquity)*sin(Alpha)*tan(Delta)))*NutationInLongitude) - (cos(Alpha)*tan(Delta)*NutationInObliquity);
}

double CAANutation::NutationInDeclination(double Alpha, double Obliquity, double NutationInLongitude, double NutationInObliquity) noexcept
{
  //Convert to radians
  Alpha = CAACoordinateTransformation::HoursToRadians(Alpha);
  Obliquity = CAACoordinateTransformation::DegreesToRadians(Obliquity);

  return (sin(Obliquity)*cos(Alpha)*NutationInLongitude) + (sin(Alpha)*NutationInObliquity);
}
