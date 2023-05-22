/*
Module : AAJewishCalendar.h
Purpose: Implementation for the algorithms which convert between the Gregorian, Julian and the Jewish calendar
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

#ifndef __AAJEWISHCALENDAR_H__
#define __AAJEWISHCALENDAR_H__

#ifndef AAPLUS_EXT_CLASS
#define AAPLUS_EXT_CLASS
#endif //#ifndef AAPLUS_EXT_CLASS


//////////////////// Includes /////////////////////////////////////////////////

#include "AADate.h"


//////////////////// Classes //////////////////////////////////////////////////

class AAPLUS_EXT_CLASS CAAJewishCalendar
{
public:
//Static methods
  static CAACalendarDate DateOfPesach(long Year, bool bGregorianCalendar = true) noexcept;

#ifdef _MSC_VER
  #pragma warning(suppress : 26497)
#endif //#ifdef _MSC_VER
  static bool IsLeap(long Year) noexcept
  {
    const long ymod19 = Year % 19;

    return (ymod19 == 0) || (ymod19 == 3) || (ymod19 == 6) || (ymod19 == 8) || (ymod19 == 11) || (ymod19 == 14) || (ymod19 == 17);
  }

  static long DaysInYear(long Year) noexcept;
};


#endif //#ifndef __AAJEWISHCALENDAR_H__
