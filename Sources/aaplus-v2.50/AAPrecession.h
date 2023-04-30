/*
Module : AAPrecession.h
Purpose: Implementation for the algorithms for Precession
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

#ifndef __AAPRECESSION_H__
#define __AAPRECESSION_H__

#ifndef AAPLUS_EXT_CLASS
#define AAPLUS_EXT_CLASS
#endif //#ifndef AAPLUS_EXT_CLASS


//////////////////// Includes /////////////////////////////////////////////////

#include "AACoordinateTransformation.h"


//////////////////// Classes //////////////////////////////////////////////////

class AAPLUS_EXT_CLASS CAAPrecession
{
public:
//Static methods
  static CAA2DCoordinate PrecessEquatorial(double Alpha, double Delta, double JD0, double JD) noexcept;
  static CAA2DCoordinate PrecessEquatorialFK4(double Alpha, double Delta, double JD0, double JD) noexcept;
  static CAA2DCoordinate PrecessEcliptic(double Lambda, double Beta, double JD0, double JD) noexcept;
  static CAA2DCoordinate EquatorialPMToEcliptic(double Alpha, double Delta, double Beta, double PMAlpha, double PMDelta, double Epsilon) noexcept;
  static CAA2DCoordinate AdjustPositionUsingUniformProperMotion(double t, double Alpha, double Delta, double PMAlpha, double PMDelta) noexcept;
  static CAA2DCoordinate AdjustPositionUsingMotionInSpace(double r, double deltar, double t, double Alpha, double Delta, double PMAlpha, double PMDelta) noexcept;
};


#endif //#ifndef __AAPRECESSION_H__
