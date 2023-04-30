/*
Module : AAMoslemCalendar.h
Purpose: Implementation for the algorithms which convert between the Julian and Moslem calendars
Created: PJN / 04-02-2004

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

#ifndef __AAMOSLEMCALENDAR_H__
#define __AAMOSLEMCALENDAR_H__

#ifndef AAPLUS_EXT_CLASS
#define AAPLUS_EXT_CLASS
#endif //#ifndef AAPLUS_EXT_CLASS


//////////////////// Includes /////////////////////////////////////////////////

#include "AADate.h"


//////////////////// Classes //////////////////////////////////////////////////

class AAPLUS_EXT_CLASS CAAMoslemCalendar
{
public:
//Static methods
  static CAACalendarDate MoslemToJulian(long Year, long Month, long Day) noexcept;
  static CAACalendarDate JulianToMoslem(long Year, long Month, long Day) noexcept;

#ifdef _MSC_VER
  #pragma warning(suppress : 26497)
#endif //#ifdef _MSC_VER
  static bool IsLeap(long Year) noexcept
  {
    const long R{Year % 30};
    return (((11*R) + 3) % 30) > 18;
  }
};


#endif //#ifndef __AAMOSLEMCALENDAR_H__
