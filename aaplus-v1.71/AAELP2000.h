/*
Module : AAELP2000.h
Purpose: Implementation for the algorithms for ELP2000-82B
Created: PJN / 28-12-2015
History: PJN / 28-12-2015 1. Initial public release.

Copyright (c) 2015 - 2016 by PJ Naughter (Web: www.naughter.com, Email: pjna@naughter.com)

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
  static double EclipticLatitude(double JD);
  static double RadiusVector(double JD);
  static CAA3DCoordinate EclipticRectangularCoordinates(double JD);
  static CAA3DCoordinate EclipticRectangularCoordinatesJ2000(double JD);
  static CAA3DCoordinate EquatorialRectangularCoordinatesFK5(double JD);
  static double MoonMeanLongitude(double* pT, int nTSize);
  static double MoonMeanLongitude(double JD);
  static double MoonMeanLongitudeLunarPerigee(double* pT, int nTSize);
  static double MoonMeanLongitudeLunarPerigee(double JD);
  static double MoonMeanLongitudeLunarAscendingNode(double* pT, int nTSize);
  static double MoonMeanLongitudeLunarAscendingNode(double JD);
  static double EarthMoonBarycentreMeanLongitude(double* pT, int nTSize);
  static double EarthMoonBarycentreMeanLongitude(double JD);
  static double EarthMoonBarycentreMeanLongitudeOfPerihelion(double* pT, int nTSize);
  static double EarthMoonBarycentreMeanLongitudeOfPerihelion(double JD);
  static double MoonMeanSolarElongation(double* pT, int nTSize);
  static double MoonMeanSolarElongation(double JD);
  static double SunMeanAnomaly(double* pT, int nTSize);
  static double SunMeanAnomaly(double JD);
  static double MoonMeanAnomaly(double* pT, int nTSize);
  static double MoonMeanAnomaly(double JD);
  static double MoonMeanArgumentOfLatitude(double* pT, int nTSize);
  static double MoonMeanArgumentOfLatitude(double JD);
  static double MercuryMeanLongitude(double T);
  static double VenusMeanLongitude(double T);
  static double MarsMeanLongitude(double T);
  static double JupiterMeanLongitude(double T);
  static double SaturnMeanLongitude(double T);
  static double UranusMeanLongitude(double T);
  static double NeptuneMeanLongitude(double T);

protected:
//static methods
  static double Accumulate(const ELP2000MainProblemCoefficient* pCoefficients, int nCoefficients, double fD, double fldash, double fl, double fF);
  static double Accumulate_2(const ELP2000MainProblemCoefficient* pCoefficients, int nCoefficients, double fD, double fldash, double fl, double fF);
  static double Accumulate(double* pT, int nTSize, const ELP2000EarthTidalMoonRelativisticSolarEccentricityCoefficient* pCoefficients, int nCoefficients, double fD, double fldash, double fl, double fF, bool bI1isZero);
  static double Accumulate_2(double* pT, int nTSize, const ELP2000EarthTidalMoonRelativisticSolarEccentricityCoefficient* pCoefficients, int nCoefficients, double fD, double fldash, double fl, double fF, bool bI1isZero);
  static double AccumulateTable1(const ELP2000PlanetPertCoefficient* pCoefficients, int nCoefficients, double fD, double fl, double fF, double fMe, double fV, double fT, double fMa, double fJ, double fS, double fU, double fN);
  static double AccumulateTable1_2(double* pT, int nTSize, const ELP2000PlanetPertCoefficient* pCoefficients, int nCoefficients, double fD, double fl, double fF, double fMe, double fV, double fT, double fMa, double fJ, double fS, double fU, double fN);
  static double AccumulateTable2(const ELP2000PlanetPertCoefficient* pCoefficients, int nCoefficients, double fD, double fldash, double fl, double fF, double fMe, double fV, double fT, double fMa, double fJ, double fS, double fU);
  static double AccumulateTable2_2(double* pT, int nTSize, const ELP2000PlanetPertCoefficient* pCoefficients, int nCoefficients, double fD, double fldash, double fl, double fF, double fMe, double fV, double fT, double fMa, double fJ, double fS, double fU);
  static double Accumulate_3(double* pT, int nTSize, const ELP2000EarthTidalMoonRelativisticSolarEccentricityCoefficient* pCoefficients, int nCoefficients, double fD, double fldash, double fl, double fF);
};

#endif //#ifndef __AAELP2000_H__
