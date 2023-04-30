/*
Module : AAPlanetPerihelionAphelion.h
Purpose: Implementation for the algorithms which obtain the dates of Perihelion and Aphelion of the planets
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

#ifndef __AAPLANETPERIHELIONAPHELION_H__
#define __AAPLANETPERIHELIONAPHELION_H__

#ifndef AAPLUS_EXT_CLASS
#define AAPLUS_EXT_CLASS
#endif //#ifndef AAPLUS_EXT_CLASS


//////////////////// Classes //////////////////////////////////////////////////

class AAPLUS_EXT_CLASS CAAPlanetPerihelionAphelion
{
public:
//Static methods
  constexpr static double MercuryK(double Year) noexcept
  {
    return 4.15201*(Year - 2000.12);
  }

  constexpr static double Mercury(double k) noexcept
  {
    return 2451590.257 + (87.96934963*k);
  }

  constexpr static double VenusK(double Year) noexcept
  {
    return 1.62549*(Year - 2000.53);
  }

#ifdef _MSC_VER
  #pragma warning(suppress : 26497)
#endif //#ifdef _MSC_VER
  constexpr static double Venus(double k) noexcept
  {
    const double kdash{k};
    const double ksquared{kdash*kdash};
    return 2451738.233 + (224.7008188*kdash) - (0.0000000327*ksquared);
  }

  constexpr static double EarthK(double Year) noexcept
  {
    return 0.99997*(Year - 2000.01);
  }

  static double EarthPerihelion(double k, bool bBarycentric = false) noexcept;
  static double EarthAphelion(double k, bool bBarycentric = false) noexcept;

  constexpr static double MarsK(double Year) noexcept
  {
    return 0.53166*(Year - 2001.78);
  }

#ifdef _MSC_VER
  #pragma warning(suppress : 26497)
#endif //#ifdef _MSC_VER
  constexpr static double Mars(double k) noexcept
  {
    const double kdash{k};
    const double ksquared{kdash*kdash};
    return 2452195.026 + (686.9957857*kdash) - (0.0000001187*ksquared);
  }

  constexpr static double JupiterK(double Year) noexcept
  {
    return 0.08430*(Year - 2011.20);
  }

#ifdef _MSC_VER
  #pragma warning(suppress : 26497)
#endif //#ifdef _MSC_VER
  constexpr static double Jupiter(double k) noexcept
  {
    const double kdash{k};
    const double ksquared{kdash*kdash};
    return 2455636.936 + (4332.897065*kdash) + (0.0001367*ksquared);
  }

  constexpr static double SaturnK(double Year) noexcept
  {
    return 0.03393*(Year - 2003.52);
  }

#ifdef _MSC_VER
  #pragma warning(suppress : 26497)
#endif //#ifdef _MSC_VER
  constexpr static double Saturn(double k) noexcept
  {
    const double kdash{k};
    const double ksquared{kdash*kdash};
    return 2452830.12 + (10764.21676*kdash) + (0.000827*ksquared);
  }

  constexpr static double UranusK(double Year) noexcept
  {
    return 0.01190*(Year - 2051.1);
  }

#ifdef _MSC_VER
  #pragma warning(suppress : 26497)
#endif //#ifdef _MSC_VER
  constexpr static double Uranus(double k) noexcept
  {
    const double kdash{k};
    const double ksquared{kdash*kdash};
    return 2470213.5 + (30694.8767*kdash) - (0.00541*ksquared);
  }

  constexpr static double NeptuneK(double Year) noexcept
  {
    return 0.00607*(Year - 2047.5);
  }

#ifdef _MSC_VER
  #pragma warning(suppress : 26497)
#endif //#ifdef _MSC_VER
  constexpr static double Neptune(double k) noexcept
  {
    const double kdash{k};
    const double ksquared{kdash*kdash};
    return 2468895.1 + (60190.33*kdash) + (0.03429*ksquared);
  }
};


#endif //#ifndef __AAPLANETPERIHELIONAPHELION_H__
