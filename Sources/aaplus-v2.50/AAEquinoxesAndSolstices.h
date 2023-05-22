/*
Module : AAEquinoxesAndSolstices.h
Purpose: Implementation for the algorithms to calculate the dates of the Equinoxes and Solstices
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

#ifndef __AAEQUINOXESANDSOLSTICES_H_
#define __AAEQUINOXESANDSOLSTICES_H_

#ifndef AAPLUS_EXT_CLASS
#define AAPLUS_EXT_CLASS
#endif //#ifndef AAPLUS_EXT_CLASS


//////////////////// Classes //////////////////////////////////////////////////

class AAPLUS_EXT_CLASS CAAEquinoxesAndSolstices
{
public:
//Static methods
  static double NorthwardEquinox(long Year, bool bHighPrecision) noexcept;
  static double NorthernSolstice(long Year, bool bHighPrecision) noexcept;
  static double SouthwardEquinox(long Year, bool bHighPrecision) noexcept;
  static double SouthernSolstice(long Year, bool bHighPrecision) noexcept;
  static double LengthOfSpring(long Year, bool bNorthernHemisphere, bool bHighPrecision) noexcept;
  static double LengthOfSummer(long Year, bool bNorthernHemisphere, bool bHighPrecision) noexcept;
  static double LengthOfAutumn(long Year, bool bNorthernHemisphere, bool bHighPrecision) noexcept;
  static double LengthOfWinter(long Year, bool bNorthernHemisphere, bool bHighPrecision) noexcept;
};


#endif //#ifndef __AAEQUINOXESANDSOLSTICES_H_
