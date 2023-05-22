/*
Module : AAJewishCalendar.cpp
Purpose: Implementation for the algorithms which convert between the Gregorian and Julian calendars and the Jewish calendar
Created: PJN / 04-02-2004
History: PJN / 28-01-2007 1. Minor updates to fit in with new layout of CAADate class
         PJN / 26-06-2022 1. Updated all the code in AAJewishCalendar.cpp to use C++ uniform initialization for all 
                          variable declarations.

Copyright (c) 2004 - 2023 by PJ Naughter (Web: www.naughter.com, Email: pjna@naughter.com)

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
#include "AAJewishCalendar.h"
#include <cmath>


//////////////////// Implementation ///////////////////////////////////////////

CAACalendarDate CAAJewishCalendar::DateOfPesach(long Year, bool bGregorianCalendar) noexcept
{
  //What will be the return value
  CAACalendarDate Pesach;

  const long C{CAADate::INT(Year/100.0)};
  long S{CAADate::INT(((3.0*C) - 5)/4.0)};
  if (bGregorianCalendar == false)
    S = 0;
  const long A{Year + 3760};
  const long a{((12*Year) + 12) % 19};
  const long b{Year % 4};
  const double Q{-1.904412361576 + (1.554241796621*a) + (0.25*b) - (0.003177794022*Year) + S};
  const long INTQ{CAADate::INT(Q)};
  const long j{(INTQ + (3*Year) + (5*b) + 2 - S) % 7};
  const double r{Q - INTQ};

  if ((j == 2) || (j == 4) || (j == 6))
    Pesach.Day = INTQ + 23;
  else if ((j == 1) && (a > 6) && (r >= 0.632870370))
    Pesach.Day = INTQ + 24;
  else if ((j == 0) && (a > 11) && (r >= 0.897723765))
    Pesach.Day = INTQ + 23;
  else
    Pesach.Day = INTQ + 22;

  if (Pesach.Day > 31)
  {
    Pesach.Month = 4;
    Pesach.Day -= 31;
  }
  else
    Pesach.Month = 3;

  Pesach.Year = A;

  return Pesach;
}

long CAAJewishCalendar::DaysInYear(long Year) noexcept
{
  //Find the previous civil year corresponding to the specified Jewish year
  const long CivilYear{Year - 3761};

  //Find the date of the next Jewish Year in that civil year
  const CAACalendarDate CurrentPesach{DateOfPesach(CivilYear)};
  const bool bGregorian{CAADate::AfterPapalReform(CivilYear, CurrentPesach.Month, CurrentPesach.Day)};
  const CAADate CurrentYear{CivilYear, CurrentPesach.Month, static_cast<double>(CurrentPesach.Day), bGregorian};

  const CAACalendarDate NextPesach{DateOfPesach(CivilYear+1)};
  const CAADate NextYear{CivilYear+1, NextPesach.Month, static_cast<double>(NextPesach.Day), bGregorian};

  return static_cast<long>(NextYear - CurrentYear);
}
