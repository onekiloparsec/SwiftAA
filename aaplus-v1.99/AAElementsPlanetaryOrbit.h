/*
Module : AAElementsPlanetaryOrbit.h
Purpose: Implementation for the algorithms to calculate the elements of the planetary orbits
Created: PJN / 29-12-2003

Copyright (c) 2003 - 2019 by PJ Naughter (Web: www.naughter.com, Email: pjna@naughter.com)

All rights reserved.

Copyright / Usage Details:

You are allowed to include the source code in any product (commercial, shareware, freeware or otherwise)
when your product is released in binary form. You are allowed to modify the source code in any way you want
except you cannot modify the copyright details at the top of each module. If you want to distribute source
code with your application, then you are only allowed to distribute versions released by the author. This is
to maintain a single distribution point for the source code.

*/


/////////////////////// Macros / Defines //////////////////////////////////////

#if _MSC_VER > 1000
#pragma once
#endif

#ifndef __AAELEMENTSPLANETARYORBIT_H__
#define __AAELEMENTSPLANETARYORBIT_H__

#ifndef AAPLUS_EXT_CLASS
#define AAPLUS_EXT_CLASS
#endif


/////////////////////// Classes ///////////////////////////////////////////////

class AAPLUS_EXT_CLASS CAAElementsPlanetaryOrbit
{
public:
//Static methods
  static double MercuryMeanLongitude(double JD);

  constexpr static double MercurySemimajorAxis(double /*JD*/) noexcept
  {
    return 0.387098310;
  }

#ifdef _MSC_VER
  #pragma warning(suppress : 26497)
#endif //#ifdef _MSC_VER
  static double MercuryEccentricity(double JD) noexcept
  {
    const double T = (JD - 2451545.0) / 36525;
    const double Tsquared = T * T;
    const double Tcubed = Tsquared * T;

    return 0.20563175 + 0.000020407*T - 0.0000000283*Tsquared - 0.00000000018*Tcubed;
  }

  static double MercuryInclination(double JD);
  static double MercuryLongitudeAscendingNode(double JD);
  static double MercuryLongitudePerihelion(double JD);

  static double VenusMeanLongitude(double JD);

  constexpr static double VenusSemimajorAxis(double /*JD*/) noexcept
  {
    return 0.723329820;
  }

#ifdef _MSC_VER
  #pragma warning(suppress : 26497)
#endif //#ifdef _MSC_VER
  static double VenusEccentricity(double JD) noexcept
  {
    const double T = (JD - 2451545.0) / 36525;
    const double Tsquared = T * T;
    const double Tcubed = Tsquared * T;

    return 0.00677192 - 0.000047765*T + 0.0000000981*Tsquared + 0.00000000046*Tcubed;
  }

  static double VenusInclination(double JD);
  static double VenusLongitudeAscendingNode(double JD);
  static double VenusLongitudePerihelion(double JD);

  static double EarthMeanLongitude(double JD);

  constexpr static double EarthSemimajorAxis(double /*JD*/) noexcept
  {
    return 1.000001018;
  }

#ifdef _MSC_VER
  #pragma warning(suppress : 26497)
#endif //#ifdef _MSC_VER
  static double EarthEccentricity(double JD) noexcept
  {
    const double T = (JD - 2451545.0) / 36525;
    const double Tsquared = T * T;
    const double Tcubed = Tsquared * T;

    return 0.01670863 - 0.000042037*T - 0.0000001267*Tsquared + 0.00000000014*Tcubed;
  }

  constexpr static double EarthInclination(double /*JD*/) noexcept
  {
    return 0;
  }

  static double EarthLongitudePerihelion(double JD);

  static double MarsMeanLongitude(double JD);

  constexpr static double MarsSemimajorAxis(double /*JD*/) noexcept
  {
    return 1.523679342;
  }

#ifdef _MSC_VER
  #pragma warning(suppress : 26497)
#endif //#ifdef _MSC_VER
  static double MarsEccentricity(double JD) noexcept
  {
    const double T = (JD - 2451545.0) / 36525;
    const double Tsquared = T * T;
    const double Tcubed = Tsquared * T;

    return 0.09340065 + 0.000090484*T - 0.0000000806*Tsquared - 0.00000000025*Tcubed;
  }

  static double MarsInclination(double JD);
  static double MarsLongitudeAscendingNode(double JD);
  static double MarsLongitudePerihelion(double JD);

  static double JupiterMeanLongitude(double JD);

#ifdef _MSC_VER
  #pragma warning(suppress : 26497)
#endif //#ifdef _MSC_VER
  static double JupiterSemimajorAxis(double JD) noexcept
  {
    const double T = (JD - 2451545.0) / 36525;

    return 5.202603209 + 0.0000001913*T;
  }

#ifdef _MSC_VER
  #pragma warning(suppress : 26497)
#endif //#ifdef _MSC_VER
  static double JupiterEccentricity(double JD) noexcept
  {
    const double T = (JD - 2451545.0) / 36525;
    const double Tsquared = T * T;
    const double Tcubed = Tsquared * T;

    return 0.04849793 + 0.000163225*T - 0.0000004714*Tsquared - 0.00000000201*Tcubed;
  }

  static double JupiterInclination(double JD);
  static double JupiterLongitudeAscendingNode(double JD);
  static double JupiterLongitudePerihelion(double JD);

  static double SaturnMeanLongitude(double JD);

#ifdef _MSC_VER
  #pragma warning(suppress : 26497)
#endif //#ifdef _MSC_VER
  static double SaturnSemimajorAxis(double JD) noexcept
  {
    const double T = (JD - 2451545.0) / 36525;
    const double Tsquared = T * T;

    return 9.554909192 - 0.0000021390*T + 0.000000004*Tsquared;
  }

#ifdef _MSC_VER
  #pragma warning(suppress : 26497)
#endif //#ifdef _MSC_VER
  static double SaturnEccentricity(double JD) noexcept
  {
    const double T = (JD - 2451545.0) / 36525;
    const double Tsquared = T * T;
    const double Tcubed = Tsquared * T;

    return 0.05554814 - 0.0003446641*T - 0.0000006436*Tsquared + 0.00000000340*Tcubed;
  }

  static double SaturnInclination(double JD);
  static double SaturnLongitudeAscendingNode(double JD);
  static double SaturnLongitudePerihelion(double JD);

  static double UranusMeanLongitude(double JD);

#ifdef _MSC_VER
  #pragma warning(suppress : 26497)
#endif //#ifdef _MSC_VER
  static double UranusSemimajorAxis(double JD) noexcept
  {
    const double T = (JD - 2451545.0) / 36525;
    const double Tsquared = T * T;

    return 19.218446062 - 0.0000000372*T + 0.00000000098*Tsquared;
  }

#ifdef _MSC_VER
  #pragma warning(suppress : 26497)
#endif //#ifdef _MSC_VER
  static double UranusEccentricity(double JD) noexcept
  {
    const double T = (JD - 2451545.0) / 36525;
    const double Tsquared = T * T;
    const double Tcubed = Tsquared * T;

    return 0.04638122 - 0.000027293*T + 0.0000000789*Tsquared + 0.00000000024*Tcubed;
  }

  static double UranusInclination(double JD);
  static double UranusLongitudeAscendingNode(double JD);
  static double UranusLongitudePerihelion(double JD);

  static double NeptuneMeanLongitude(double JD);

#ifdef _MSC_VER
  #pragma warning(suppress : 26497)
#endif //#ifdef _MSC_VER
  static double NeptuneSemimajorAxis(double JD) noexcept
  {
    const double T = (JD - 2451545.0) / 36525;
    const double Tsquared = T * T;

    return 30.110386869 - 0.0000001663*T + 0.00000000069*Tsquared;
  }

#ifdef _MSC_VER
  #pragma warning(suppress : 26497)
#endif //#ifdef _MSC_VER
  static double NeptuneEccentricity(double JD) noexcept
  {
    const double T = (JD - 2451545.0) / 36525;
    const double Tcubed = T * T*T;

    return 0.00945575 + 0.000006033*T - 0.00000000005*Tcubed;
  }

  static double NeptuneInclination(double JD);
  static double NeptuneLongitudeAscendingNode(double JD);
  static double NeptuneLongitudePerihelion(double JD);

  static double MercuryMeanLongitudeJ2000(double JD);
  static double MercuryInclinationJ2000(double JD);
  static double MercuryLongitudeAscendingNodeJ2000(double JD);
  static double MercuryLongitudePerihelionJ2000(double JD);

  static double VenusMeanLongitudeJ2000(double JD);
  static double VenusInclinationJ2000(double JD);
  static double VenusLongitudeAscendingNodeJ2000(double JD);
  static double VenusLongitudePerihelionJ2000(double JD);

  static double EarthMeanLongitudeJ2000(double JD);

#ifdef _MSC_VER
  #pragma warning(suppress : 26497)
#endif //#ifdef _MSC_VER
  static double EarthInclinationJ2000(double JD) noexcept
  {
    const double T = (JD - 2451545.0) / 36525;
    const double Tsquared = T * T;
    const double Tcubed = Tsquared * T;

    return 0.0130548*T - 0.00000931*Tsquared - 0.000000034*Tcubed;
  }

  static double EarthLongitudeAscendingNodeJ2000(double JD);
  static double EarthLongitudePerihelionJ2000(double JD);

  static double MarsMeanLongitudeJ2000(double JD);
  static double MarsInclinationJ2000(double JD);
  static double MarsLongitudeAscendingNodeJ2000(double JD);
  static double MarsLongitudePerihelionJ2000(double JD);

  static double JupiterMeanLongitudeJ2000(double JD);
  static double JupiterInclinationJ2000(double JD);
  static double JupiterLongitudeAscendingNodeJ2000(double JD);
  static double JupiterLongitudePerihelionJ2000(double JD);

  static double SaturnMeanLongitudeJ2000(double JD);
  static double SaturnInclinationJ2000(double JD);
  static double SaturnLongitudeAscendingNodeJ2000(double JD);
  static double SaturnLongitudePerihelionJ2000(double JD);

  static double UranusMeanLongitudeJ2000(double JD);
  static double UranusInclinationJ2000(double JD);
  static double UranusLongitudeAscendingNodeJ2000(double JD);
  static double UranusLongitudePerihelionJ2000(double JD);

  static double NeptuneMeanLongitudeJ2000(double JD);
  static double NeptuneInclinationJ2000(double JD);
  static double NeptuneLongitudeAscendingNodeJ2000(double JD);
  static double NeptuneLongitudePerihelionJ2000(double JD);
};

#endif //__AAELEMENTSPLANETARYORBIT_H__
