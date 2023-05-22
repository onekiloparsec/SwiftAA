/*
Module : AASaturnMoons.h
Purpose: Implementation for the algorithms which obtain the positions of the moons of Saturn
Created: PJN / 09-01-2004

Copyright (c) 2004 - 2023 by PJ Naughter (Web: www.naughter.com, Email: pjna@naughter.com)

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

#ifndef __AASATURNMOONS_H__
#define __AASATURNMOONS_H__

#ifndef AAPLUS_EXT_CLASS
#define AAPLUS_EXT_CLASS
#endif //#ifndef AAPLUS_EXT_CLASS


//////////////////// Includes /////////////////////////////////////////////////

#include "AA3DCoordinate.h"


//////////////////// Classes //////////////////////////////////////////////////

class AAPLUS_EXT_CLASS CAASaturnMoonDetail
{
public:
  CAA3DCoordinate TrueRectangularCoordinates;
  CAA3DCoordinate ApparentRectangularCoordinates;
  bool bInTransit{false};
  bool bInOccultation{false};
  bool bInEclipse{false};
  bool bInShadowTransit{false};
};

class AAPLUS_EXT_CLASS CAASaturnMoonsDetails
{
public:
//Member variables
  CAASaturnMoonDetail Satellite1;
  CAASaturnMoonDetail Satellite2;
  CAASaturnMoonDetail Satellite3;
  CAASaturnMoonDetail Satellite4;
  CAASaturnMoonDetail Satellite5;
  CAASaturnMoonDetail Satellite6;
  CAASaturnMoonDetail Satellite7;
  CAASaturnMoonDetail Satellite8;
};

class AAPLUS_EXT_CLASS CAASaturnMoons
{
public:
//Static methods
  static CAASaturnMoonsDetails Calculate(double JD, bool bHighPrecision) noexcept;

protected:
  static CAASaturnMoonsDetails CalculateHelper(double JD, double sunlongrad, double betarad, double R, bool bHighPrecision) noexcept;
  static void HelperSubroutine(double e, double lambdadash, double p, double a, double omega, double i, double c1, double s1, double& r, double& lambda, double& gamma, double& w) noexcept;
  static void Rotations(double X, double Y, double Z, double c1, double s1, double c2, double s2, double lambda0, double beta0, double& A4, double& B4, double& C4) noexcept;
  static void FillInPhenomenaDetails(CAASaturnMoonDetail& detail) noexcept;
};


#endif //#ifndef __AASATURNMOONS_H__
