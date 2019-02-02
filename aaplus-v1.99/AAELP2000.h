/*
Module : AAELP2000.h
Purpose: Implementation for the algorithms for ELP2000-82B
Created: PJN / 28-12-2015
History: PJN / 28-12-2015 1. Initial public release.

Copyright (c) 2015 - 2019 by PJ Naughter (Web: www.naughter.com, Email: pjna@naughter.com)

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

#ifndef __AAELP2000_H__
#define __AAELP2000_H__

#ifndef AAPLUS_EXT_CLASS
#define AAPLUS_EXT_CLASS
#endif


/////////////////////// Includes //////////////////////////////////////////////

#include "AA3DCoordinate.h"


////////////////////////////// Classes ////////////////////////////////////////

struct AAPLUS_EXT_CLASS ELP2000MainProblemCoefficient
{
  int    m_I[4];
  double m_A;
  double m_B[6];
};

struct AAPLUS_EXT_CLASS ELP2000EarthTidalMoonRelativisticSolarEccentricityCoefficient
{
  int    m_IZ;
  int    m_I[4];
  double m_O;
  double m_A;
  double m_P;
};

struct AAPLUS_EXT_CLASS ELP2000PlanetPertCoefficient
{
  int    m_ip[11];
  double m_theta;
  double m_O;
  double m_P;
};

class AAPLUS_EXT_CLASS CAAELP2000
{
public:
//Static methods
  static double EclipticLongitude(double JD);
  static double EclipticLongitude(const double* pT, int nTSize);
  static double EclipticLatitude(double JD);
  static double EclipticLatitude(const double* pT, int nTSize);
  static double RadiusVector(double JD) noexcept;
  static double RadiusVector(const double* pT, int nTSize) noexcept;
  static CAA3DCoordinate EclipticRectangularCoordinates(double JD);
  static CAA3DCoordinate EclipticRectangularCoordinatesJ2000(double JD);
  static CAA3DCoordinate EquatorialRectangularCoordinatesFK5(double JD);
  static double MoonMeanLongitude(const double* pT, int nTSize) noexcept;
  static double MoonMeanLongitude(double JD) noexcept;
  static double MoonMeanLongitudeLunarPerigee(const double* pT, int nTSize) noexcept;
  static double MoonMeanLongitudeLunarPerigee(double JD) noexcept;
  static double MoonMeanLongitudeLunarAscendingNode(const double* pT, int nTSize) noexcept;
  static double MoonMeanLongitudeLunarAscendingNode(double JD) noexcept;
  static double EarthMoonBarycentreMeanLongitude(const double* pT, int nTSize) noexcept;
  static double EarthMoonBarycentreMeanLongitude(double JD) noexcept;
  static double EarthMoonBarycentreMeanLongitudeOfPerihelion(const double* pT, int nTSize) noexcept;
  static double EarthMoonBarycentreMeanLongitudeOfPerihelion(double JD) noexcept;
  static double MoonMeanSolarElongation(const double* pT, int nTSize) noexcept;
  static double MoonMeanSolarElongation(double JD) noexcept;
  static double SunMeanAnomaly(const double* pT, int nTSize) noexcept;
  static double SunMeanAnomaly(double JD) noexcept;
  static double MoonMeanAnomaly(const double* pT, int nTSize) noexcept;
  static double MoonMeanAnomaly(double JD) noexcept;
  static double MoonMeanArgumentOfLatitude(const double* pT, int nTSize) noexcept;
  static double MoonMeanArgumentOfLatitude(double JD) noexcept;
  static double MercuryMeanLongitude(double T) noexcept;
  static double VenusMeanLongitude(double T) noexcept;
  static double MarsMeanLongitude(double T) noexcept;
  static double JupiterMeanLongitude(double T) noexcept;
  static double SaturnMeanLongitude(double T) noexcept;
  static double UranusMeanLongitude(double T) noexcept;
  static double NeptuneMeanLongitude(double T) noexcept;

protected:
//static methods
  static double Accumulate(const ELP2000MainProblemCoefficient* pCoefficients, int nCoefficients, double fD, double fldash, double fl, double fF) noexcept;
  static double Accumulate_2(const ELP2000MainProblemCoefficient* pCoefficients, int nCoefficients, double fD, double fldash, double fl, double fF) noexcept;
  static double Accumulate(const double* pT, int nTSize, const ELP2000EarthTidalMoonRelativisticSolarEccentricityCoefficient* pCoefficients, int nCoefficients, double fD, double fldash, double fl, double fF, bool bI1isZero) noexcept;
  static double Accumulate_2(const double* pT, int nTSize, const ELP2000EarthTidalMoonRelativisticSolarEccentricityCoefficient* pCoefficients, int nCoefficients, double fD, double fldash, double fl, double fF, bool bI1isZero) noexcept;
  static double AccumulateTable1(const ELP2000PlanetPertCoefficient* pCoefficients, int nCoefficients, double fD, double fl, double fF, double fMe, double fV, double fT, double fMa, double fJ, double fS, double fU, double fN) noexcept;
  static double AccumulateTable1_2(const double* pT, int nTSize, const ELP2000PlanetPertCoefficient* pCoefficients, int nCoefficients, double fD, double fl, double fF, double fMe, double fV, double fT, double fMa, double fJ, double fS, double fU, double fN) noexcept;
  static double AccumulateTable2(const ELP2000PlanetPertCoefficient* pCoefficients, int nCoefficients, double fD, double fldash, double fl, double fF, double fMe, double fV, double fT, double fMa, double fJ, double fS, double fU) noexcept;
  static double AccumulateTable2_2(const double* pT, int nTSize, const ELP2000PlanetPertCoefficient* pCoefficients, int nCoefficients, double fD, double fldash, double fl, double fF, double fMe, double fV, double fT, double fMa, double fJ, double fS, double fU) noexcept;
  static double Accumulate_3(const double* pT, int nTSize, const ELP2000EarthTidalMoonRelativisticSolarEccentricityCoefficient* pCoefficients, int nCoefficients, double fD, double fldash, double fl, double fF) noexcept;
};

#endif //#ifndef __AAELP2000_H__
