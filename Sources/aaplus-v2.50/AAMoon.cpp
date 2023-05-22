/*
Module : AAMoon.cpp
Purpose: Implementation for the algorithms which obtain the position of the Moon
Created: PJN / 29-12-2003
History: PJN / 07-02-2009 1. Optimized the layout of the MoonCoefficient1 structure by making all elements
                          integers instead of doubles.
         PJN / 12-02-2009 1. Fixed a seemingly copy and paste bug in CAAMoon::EclipticLongitude. The layout of the code 
                          to calculate the "ThisSigma" value was incorrect. The terms involving any value of M was being 
                          multiplied by E. This was incorrect as documented at the bottom of page 338 from the second 
                          edition of Meeus's book. The correct logic is to multiple only terms which involve +1M or -1M 
                          by E and to multiple any terms which involved 2M or -2M by E*E. With the bug fixed the worked 
                          example 47.a from the book now gives: 133.16726428105474 degrees. This is a much closer result 
                          to the value as reported in the book which is 133.167265. The previous buggy code was giving 
                          the value of 133.16726382897039 degrees for the Moons apparent Longitude. The error in this 
                          example is 0.001627 arc seconds of a degree. This error value is well within the actual 
                          reported accuracy of 10 arc seconds for the code, but you would expect this error to increase
                          as the eccentricity of earths orbit increases. Thanks to Neoklis Kyriazis for reporting this bug.
         PJN / 08-05-2011 1. Fixed a compilation issue on GCC where size_t was undefined in various methods. Thanks to 
                          Carsten A. Arnholm and Andrew Hammond for reporting this bug.
         PJN / 18-03-2012 1. All global "g_*" tables are now const. Thanks to Roger Dahl for reporting this 
                          issue when compiling AA+ on ARM.
         PJN / 11-02-2017 1. Applied a bug fix to CAAMoon::EclipticLatitude and CAAMoon::RadiusVector along the same lines 
                          as the fix to CAAMoon::EclipticLongitude on February 2009. The bug fix should in fact have been 
                          applied to the later two methods. Thanks to Jeffrey Roe for reporting this issue.
         PJN / 01-08-2017 1. Fixed up alignment of lookup tables in AAMoon.cpp module
         PJN / 18-08-2019 1. Fixed some further compiler warnings when using VC 2019 Preview v16.3.0 Preview 2.0
         PJN / 18-04-2020 1. Reworked C arrays to use std::array
         PJN / 06-11-2021 1. Fix a minor layout problem in the g_MoonCoefficients3 lookup table. Thanks to Jud McCranie
                          for reporting this issue.
         PJN / 27-06-2022 1. Updated all the code in AAMoon.cpp to use C++ uniform initialization for all
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
#include "AAMoon.h"
#include "AACoordinateTransformation.h"
#include "AAEarth.h"
#include "AANutation.h"
#include <cmath>
#include <cassert>
#include <cstddef>
#include <array>


//////////////////// Macros / Defines /////////////////////////////////////////

#ifdef _MSC_VER
#pragma warning(disable : 26446 26482 26485)
#endif //#ifdef _MSC_VER

struct MoonCoefficient1
{
  int D;
  int M;
  int Mdash;
  int F;
};

struct MoonCoefficient2
{
  double A;
  double B;
};

constexpr std::array<MoonCoefficient1, 60> g_MoonCoefficients1
{ {
  { 0,  0,  1,  0 },
  { 2,  0, -1,  0 },
  { 2,  0,  0,  0 },
  { 0,  0,  2,  0 },
  { 0,  1,  0,  0 },
  { 0,  0,  0,  2 },
  { 2,  0, -2,  0 },
  { 2, -1, -1,  0 },
  { 2,  0,  1,  0 },
  { 2, -1,  0,  0 },
  { 0,  1, -1,  0 },
  { 1,  0,  0,  0 },
  { 0,  1,  1,  0 },
  { 2,  0,  0, -2 },
  { 0,  0,  1,  2 },
  { 0,  0,  1, -2 },
  { 4,  0, -1,  0 },
  { 0,  0,  3,  0 },
  { 4,  0, -2,  0 },
  { 2,  1, -1,  0 },
  { 2,  1,  0,  0 },
  { 1,  0, -1,  0 },
  { 1,  1,  0,  0 },
  { 2, -1,  1,  0 },
  { 2,  0,  2,  0 },
  { 4,  0,  0,  0 },
  { 2,  0, -3,  0 },
  { 0,  1, -2,  0 },
  { 2,  0, -1,  2 },
  { 2, -1, -2,  0 },
  { 1,  0,  1,  0 },
  { 2, -2,  0,  0 },
  { 0,  1,  2,  0 },
  { 0,  2,  0,  0 },
  { 2, -2, -1,  0 },
  { 2,  0,  1, -2 },
  { 2,  0,  0,  2 },
  { 4, -1, -1,  0 },
  { 0,  0,  2,  2 },
  { 3,  0, -1,  0 },
  { 2,  1,  1,  0 },
  { 4, -1, -2,  0 },
  { 0,  2, -1,  0 },
  { 2,  2, -1,  0 },
  { 2,  1, -2,  0 },
  { 2, -1,  0, -2 },
  { 4,  0,  1,  0 },
  { 0,  0,  4,  0 },
  { 4, -1,  0,  0 },
  { 1,  0, -2,  0 },
  { 2,  1,  0, -2 },
  { 0,  0,  2, -2 },
  { 1,  1,  1,  0 },
  { 3,  0, -2,  0 },
  { 4,  0, -3,  0 },
  { 2, -1,  2,  0 },
  { 0,  2,  1,  0 },
  { 1,  1, -1,  0 },
  { 2,  0,  3,  0 },
  { 2,  0, -1, -2 }
} };

constexpr std::array<MoonCoefficient2, 60> g_MoonCoefficients2
{ {
  {  6288774, -20905355 },
  {  1274027, -3699111  },
  {  658314,  -2955968  },
  {  213618,  -569925   },
  { -185116,   48888    },
  { -114332,  -3149     },
  {  58793,    246158   },
  {  57066,   -152138   },
  {  53322,   -170733   },
  {  45758,   -204586   },
  { -40923,   -129620   },
  { -34720,    108743   },
  { -30383,    104755   },
  {  15327,    10321    },
  { -12528,    0        },
  {  10980,    79661    },
  {  10675,   -34782    },
  {  10034,   -23210    },
  {  8548,    -21636    },
  { -7888,     24208    },
  { -6766,     30824    },
  { -5163,    -8379     },
  {  4987,    -16675    },
  {  4036,    -12831    },
  {  3994,    -10445    },
  {  3861,    -11650    },
  {  3665,     14403    },
  { -2689,    -7003     },
  { -2602,     0        },
  {  2390,     10056    },
  { -2348,     6322     },
  {  2236,    -9884     },
  { -2120,     5751     },
  { -2069,     0        },
  {  2048,    -4950     },
  { -1773,     4130     },
  { -1595,     0        },
  {  1215,    -3958     },
  { -1110,     0        },
  { -892,      3258     },
  { -810,      2616     },
  {  759,     -1897     },
  { -713,     -2117     },
  { -700,      2354     },
  {  691,      0        },
  {  596,      0        },
  {  549,     -1423     },
  {  537,     -1117     },
  {  520,     -1571     },
  { -487,     -1739     },
  { -399,      0        },
  { -381,     -4421     },
  {  351,      0        },
  { -340,      0        },
  {  330,      0        },
  {  327,      0        },
  { -323,      1165     },
  {  299,      0        },
  {  294,      0        },
  {  0,        8752     }
} };

constexpr std::array<MoonCoefficient1, 60> g_MoonCoefficients3
{ {
  { 0,  0,  0,  1 },
  { 0,  0,  1,  1 },
  { 0,  0,  1, -1 },
  { 2,  0,  0, -1 },
  { 2,  0, -1,  1 },
  { 2,  0, -1, -1 },
  { 2,  0,  0,  1 },
  { 0,  0,  2,  1 },
  { 2,  0,  1, -1 },
  { 0,  0,  2, -1 },
  { 2, -1,  0, -1 },
  { 2,  0, -2, -1 },
  { 2,  0,  1,  1 },
  { 2,  1,  0, -1 },
  { 2, -1, -1,  1 },
  { 2, -1,  0,  1 },
  { 2, -1, -1, -1 },
  { 0,  1, -1, -1 },
  { 4,  0, -1, -1 },
  { 0,  1,  0,  1 },
  { 0,  0,  0,  3 },
  { 0,  1, -1,  1 },
  { 1,  0,  0,  1 },
  { 0,  1,  1,  1 },
  { 0,  1,  1, -1 },
  { 0,  1,  0, -1 },
  { 1,  0,  0, -1 },
  { 0,  0,  3,  1 },
  { 4,  0,  0, -1 },
  { 4,  0, -1,  1 },
  { 0,  0,  1, -3 },
  { 4,  0, -2,  1 },
  { 2,  0,  0, -3 },
  { 2,  0,  2, -1 },
  { 2, -1,  1, -1 },
  { 2,  0, -2,  1 },
  { 0,  0,  3, -1 },
  { 2,  0,  2,  1 },
  { 2,  0, -3, -1 },
  { 2,  1, -1,  1 },
  { 2,  1,  0,  1 },
  { 4,  0,  0,  1 },
  { 2, -1,  1,  1 },
  { 2, -2,  0, -1 },
  { 0,  0,  1,  3 },
  { 2,  1,  1, -1 },
  { 1,  1,  0, -1 },
  { 1,  1,  0,  1 },
  { 0,  1, -2, -1 },
  { 2,  1, -1, -1 },
  { 1,  0,  1,  1 },
  { 2, -1, -2, -1 },
  { 0,  1,  2,  1 },
  { 4,  0, -2, -1 },
  { 4, -1, -1, -1 },
  { 1,  0,  1, -1 },
  { 4,  0,  1, -1 },
  { 1,  0, -1, -1 },
  { 4, -1,  0, -1 },
  { 2, -2,  0,  1 }
} };

constexpr std::array<double, 60> g_MoonCoefficients4
{ {
  5128122,
  280602,
  277693,
  173237,
  55413,
  46271,
  32573,
  17198,
  9266,
  8822,
  8216,
  4324,
  4200,
 -3359,
  2463,
  2211,
  2065,
 -1870,
  1828,
 -1794,
 -1749,
 -1565,
 -1491,
 -1475,
 -1410,
 -1344,
 -1335,
  1107,
  1021,
  833,
  777,
  671,
  607,
  596,
  491,
 -451,
  439,
  422,
  421,
 -366,
 -351,
  331,
  315,
  302,
 -283,
 -229,
  223,
  223,
 -220,
 -220,
 -185,
  181,
 -177,
  176,
  166,
 -164,
  132,
 -119,
  115,
  107,
} };


//////////////////// Implementation ///////////////////////////////////////////

double CAAMoon::MeanLongitude(double JD) noexcept
{
  const double T{(JD - 2451545)/36525};
  const double Tsquared{T*T};
  const double Tcubed{Tsquared*T};
  const double T4{Tcubed*T};
  return CAACoordinateTransformation::MapTo0To360Range(218.3164477 + (481267.88123421*T) - (0.0015786*Tsquared) + (Tcubed/538841) - (T4/65194000));
}

double CAAMoon::MeanElongation(double JD) noexcept
{
  const double T{(JD - 2451545)/36525};
  const double Tsquared{T*T};
  const double Tcubed{Tsquared*T};
  const double T4{Tcubed*T};
  return CAACoordinateTransformation::MapTo0To360Range(297.8501921 + (445267.1114034*T) - (0.0018819*Tsquared) + (Tcubed/545868) - (T4/113065000));
}

double CAAMoon::MeanAnomaly(double JD) noexcept
{
  const double T{(JD - 2451545)/36525};
  const double Tsquared{T*T};
  const double Tcubed{Tsquared*T};
  const double T4{Tcubed*T};
  return CAACoordinateTransformation::MapTo0To360Range(134.9633964 + (477198.8675055*T) + (0.0087414*Tsquared) + (Tcubed/69699) - (T4/14712000));
}

double CAAMoon::ArgumentOfLatitude(double JD) noexcept
{
  const double T{(JD - 2451545)/36525};
  const double Tsquared{T*T};
  const double Tcubed{Tsquared*T};
  const double T4{Tcubed*T};
  return CAACoordinateTransformation::MapTo0To360Range(93.2720950 + (483202.0175233*T) - (0.0036539*Tsquared) - (Tcubed/3526000) + (T4/863310000));
}

double CAAMoon::EclipticLongitude(double JD) noexcept
{
  double Ldash{MeanLongitude(JD)};
  const double LdashDegrees{Ldash};
  Ldash = CAACoordinateTransformation::DegreesToRadians(Ldash);
  double D{MeanElongation(JD)};
  D = CAACoordinateTransformation::DegreesToRadians(D);
  double M{CAAEarth::SunMeanAnomaly(JD)};
  M = CAACoordinateTransformation::DegreesToRadians(M);
  double Mdash{MeanAnomaly(JD)};
  Mdash = CAACoordinateTransformation::DegreesToRadians(Mdash);
  double F{ArgumentOfLatitude(JD)};
  F = CAACoordinateTransformation::DegreesToRadians(F);

  const double E{CAAEarth::Eccentricity(JD)};
  const double Esquared{E*E};
  const double T{(JD - 2451545)/36525};

  double A1{CAACoordinateTransformation::MapTo0To360Range(119.75 + (131.849*T))};
  A1 = CAACoordinateTransformation::DegreesToRadians(A1);
  double A2{CAACoordinateTransformation::MapTo0To360Range(53.09 + (479264.290*T))};
  A2 = CAACoordinateTransformation::DegreesToRadians(A2);

  constexpr size_t nLCoefficients{g_MoonCoefficients1.size()};
  assert(nLCoefficients == g_MoonCoefficients2.size());
  double SigmaL{0};
  for (size_t i{0}; i<nLCoefficients; i++)
  {
    double ThisSigma{g_MoonCoefficients2[i].A*sin((g_MoonCoefficients1[i].D*D) + (g_MoonCoefficients1[i].M*M) +
                                                  (g_MoonCoefficients1[i].Mdash*Mdash) + (g_MoonCoefficients1[i].F*F))};

    if ((g_MoonCoefficients1[i].M == 1) || (g_MoonCoefficients1[i].M == -1))
      ThisSigma *= E;
    else if ((g_MoonCoefficients1[i].M == 2) || (g_MoonCoefficients1[i].M == -2))
      ThisSigma *= Esquared;

    SigmaL += ThisSigma;
  }

  //Finally the additive terms
  SigmaL += 3958*sin(A1);
  SigmaL += 1962*sin(Ldash - F);
  SigmaL += 318*sin(A2);

  //And finally apply the nutation in longitude
  const double NutationInLong{CAANutation::NutationInLongitude(JD)};

  return CAACoordinateTransformation::MapTo0To360Range(LdashDegrees + (SigmaL/1000000) + (NutationInLong/3600));
}

double CAAMoon::RadiusVector(double JD) noexcept
{
  double D{MeanElongation(JD)};
  D = CAACoordinateTransformation::DegreesToRadians(D);
  double M{CAAEarth::SunMeanAnomaly(JD)};
  M = CAACoordinateTransformation::DegreesToRadians(M);
  double Mdash{MeanAnomaly(JD)};
  Mdash = CAACoordinateTransformation::DegreesToRadians(Mdash);
  double F{ArgumentOfLatitude(JD)};
  F = CAACoordinateTransformation::DegreesToRadians(F);
  const double E{CAAEarth::Eccentricity(JD)};
  const double Esquared{E*E};

  constexpr size_t nRCoefficients{g_MoonCoefficients1.size()};
  assert(nRCoefficients == g_MoonCoefficients2.size());
  double SigmaR{0};
  for (size_t i{0}; i<nRCoefficients; i++)
  {
    double ThisSigma{g_MoonCoefficients2[i].B*cos((g_MoonCoefficients1[i].D*D) + (g_MoonCoefficients1[i].M*M) +
                                                  (g_MoonCoefficients1[i].Mdash*Mdash) + (g_MoonCoefficients1[i].F*F))};
    if ((g_MoonCoefficients1[i].M == 1) || (g_MoonCoefficients1[i].M == -1))
      ThisSigma *= E;
    else if ((g_MoonCoefficients1[i].M == 2) || (g_MoonCoefficients1[i].M == -2))
      ThisSigma *= Esquared;

    SigmaR += ThisSigma;
  }

  return 385000.56 + (SigmaR/1000);
}

double CAAMoon::EclipticLatitude(double JD) noexcept
{
  double Ldash{MeanLongitude(JD)};
  Ldash = CAACoordinateTransformation::DegreesToRadians(Ldash);
  double D{MeanElongation(JD)};
  D = CAACoordinateTransformation::DegreesToRadians(D);
  double M{CAAEarth::SunMeanAnomaly(JD)};
  M = CAACoordinateTransformation::DegreesToRadians(M);
  double Mdash{MeanAnomaly(JD)};
  Mdash = CAACoordinateTransformation::DegreesToRadians(Mdash);
  double F{ArgumentOfLatitude(JD)};
  F = CAACoordinateTransformation::DegreesToRadians(F);

  const double E{CAAEarth::Eccentricity(JD)};
  const double Esquared{E*E};
  const double T{(JD - 2451545)/36525};

  double A1{CAACoordinateTransformation::MapTo0To360Range(119.75 + (131.849*T))};
  A1 = CAACoordinateTransformation::DegreesToRadians(A1);
  double A3{CAACoordinateTransformation::MapTo0To360Range(313.45 + (481266.484*T))};
  A3 = CAACoordinateTransformation::DegreesToRadians(A3);

  constexpr size_t nBCoefficients{g_MoonCoefficients3.size()};
  assert(nBCoefficients == g_MoonCoefficients4.size());
  double SigmaB{0};
  for (size_t i{0}; i<nBCoefficients; i++)
  {
    double ThisSigma{g_MoonCoefficients4[i]*sin((g_MoonCoefficients3[i].D*D) + (g_MoonCoefficients3[i].M*M) + 
                                                (g_MoonCoefficients3[i].Mdash*Mdash) + (g_MoonCoefficients3[i].F*F))};

    if ((g_MoonCoefficients3[i].M == 1) || (g_MoonCoefficients3[i].M == -1))
      ThisSigma *= E;
    else if ((g_MoonCoefficients3[i].M == 2) || (g_MoonCoefficients3[i].M == -2))
      ThisSigma *= Esquared;

    SigmaB += ThisSigma;
  }

  //Finally the additive terms
  SigmaB -= 2235*sin(Ldash);
  SigmaB += 382*sin(A3);
  SigmaB += 175*sin(A1 - F);
  SigmaB += 175*sin(A1 + F);
  SigmaB += 127*sin(Ldash - Mdash);
  SigmaB -= 115*sin(Ldash + Mdash);

  return SigmaB/1000000;
}

double CAAMoon::RadiusVectorToHorizontalParallax(double RadiusVector) noexcept
{
  return CAACoordinateTransformation::RadiansToDegrees(asin(6378.14/RadiusVector));
}

double CAAMoon::HorizontalParallaxToRadiusVector(double Parallax) noexcept
{
  return 6378.14/sin(CAACoordinateTransformation::DegreesToRadians(Parallax));
}

double CAAMoon::MeanLongitudeAscendingNode(double JD) noexcept
{
  const double T{(JD - 2451545)/36525};
  const double Tsquared{T*T};
  const double Tcubed{Tsquared*T};
  const double T4{Tcubed*T};
  return CAACoordinateTransformation::MapTo0To360Range(125.0445479 - (1934.1362891*T) + (0.0020754*Tsquared) + (Tcubed/467441) - (T4/60616000));
}

double CAAMoon::MeanLongitudePerigee(double JD) noexcept
{
  const double T{(JD - 2451545)/36525};
  const double Tsquared{T*T};
  const double Tcubed{Tsquared*T};
  const double T4{Tcubed*T};
  return CAACoordinateTransformation::MapTo0To360Range(83.3532465 + (4069.0137287*T) - (0.0103200*Tsquared) - (Tcubed/80053) + (T4/18999000));
}

double CAAMoon::TrueLongitudeAscendingNode(double JD) noexcept
{
  double TrueAscendingNode{MeanLongitudeAscendingNode(JD)};

  double D{MeanElongation(JD)};
  D = CAACoordinateTransformation::DegreesToRadians(D);
  double M{CAAEarth::SunMeanAnomaly(JD)};
  M = CAACoordinateTransformation::DegreesToRadians(M);
  double Mdash{MeanAnomaly(JD)};
  Mdash = CAACoordinateTransformation::DegreesToRadians(Mdash);
  double F{ArgumentOfLatitude(JD)};
  F = CAACoordinateTransformation::DegreesToRadians(F);

  //Add the principal additive terms
  TrueAscendingNode -= 1.4979*sin(2*(D - F));
  TrueAscendingNode -= 0.1500*sin(M);
  TrueAscendingNode -= 0.1226*sin(2*D);
  TrueAscendingNode += 0.1176*sin(2*F);
  TrueAscendingNode -= 0.0801*sin(2*(Mdash-F));

  return CAACoordinateTransformation::MapTo0To360Range(TrueAscendingNode);
}
