/*
Module : AADate.cpp
Purpose: Implementation for the algorithms which convert between the Gregorian and Julian calendars and the Julian Day
Created: PJN / 29-12-2003
History: PJN / 10-11-2004 1. Fix for CAADate::Get so that it works correctly for propalactive calendar dates
         PJN / 15-05-2005 1. Fix for CAADate::Set(double JD, bool bGregorianCalendarCalendar) not setting the m_bGregorianCalendarCalendar
                          member variable correctly. 
         PJN / 26-01-2006 1. After a bug report from Ing. Taras Kapuszczak that a round trip of the date 25 January 100 as 
                          specified in the Gregorian calendar to the Julian day number and then back again produces the
                          incorrect date 26 January 100, I've spent some time looking into the 2 key Meeus Julian Day
                          algorithms. It seems that the algorithms which converts from a Calendar date to JD works ok for
                          propalactive dates, but the reverse algorithm which converts from a JD to a Calendar date does not.
                          Since I made the change in behaviour to support propalactive Gregorian dates to address issues
                          with the Moslem calendar (and since then I have discovered further unresolved bugs in the Moslem
                          calendar algorithms and advised people to check out my AA+ library instead), I am now reverting
                          these changes so that the date algorithms are now as presented in Meeus's book. This means that 
                          dates after 15 October 1582 are assumed to be in the Gregorian calendar and dates before are 
                          assumed to be in the Julian calendar. This change also means that some of the CAADate class 
                          methods no longer require the now defunct "bool" parameter to specify which calendar the date 
                          represents. As part of the testing for this release verification code has been added to AATest.cpp
                          to test all the dates from JD 0 (i.e. 1 January -4712) to a date long in the future. Hopefully
                          with this verification code, we should have no more reported issues with the class CAADate. Again 
                          if you would prefer a much more robust and comprehensive Date time class framework, don't forget 
                          to check out the authors DTime+ library.
                          2. Optimized CAADate constructor code
                          3. Provided a static version of CAADate::DaysInMonth() method
                          4. Discovered an issue in CAADate::JulianToGregorian. It seems the algorithm presented in the
                          book to do conversion from the Julian to Gregorian calendar fails for Julian dates before the 
                          Gregorian calendar reform in 1582. I have sent an email to Jean Meeus to find out if this is a
                          bug in my code or a deficiency in the algorithm presented. Currently the code will assert in this
                          function if it is called for a date before the Gregorian reform.
         PJN / 27-01-2007 1. The static version of the Set method has been renamed to DateToJD to avoid any confusion with
                          the other Set methods. Thanks to Ing. Taras Kapuszczak for reporting this issue.
                          2. The method InGregorianCalendar has now also been renamed to the more appropriate 
                          AfterPapalReform.
                          3. Reinstated the bGregorianCalendar parameter for the CAADate constructors and Set methods.
                          4. Changed the parameter layout for the static version of DaysInMonth
                          5. Addition of a InGregorianCalendar method.
                          6. Addition of a SetInGregorianCalendar method.
                          7. Reworked implementation of GregorianToJulian method.
                          8. Reworked implementation of JulianToGregorian method.
         PJN / 07-02-2009 1. Updated the static version of CAADate::DaysInMonth to compile cleanly using code analysis
         PJN / 29-03-2015 1. Fixed up some variable initializations around the use of modf. Thanks to Arnaud Cueille for
                          reporting this issue.
         PJN / 18-02-2017 1. Reworked the CAADate::SetInGregorianCalendar method to use the AfterPapalReform method.
         PJN / 18-04-2020 1. Made a number of the CAADate methods [[nodiscard]] when compiled as C++ 17
         PJN / 29-04-2020 1. Fixed a compilation issue on GCC where size_t was undefined in various modules. Thanks to
                          Bert Devlieghe for reporting this bug.
         PJN / 03-10-2021 1. Renamed CAADate::DAY_OF_WEEK type to DOW.
         PJN / 22-03-2022 1. Fixed an issue in CAADate::DayOfWeek for dates which are close to or prior to the Julian
                          day epoch. Thanks to "znight" for reporting this issue.
                          2. Updated all the code in the AADate.cpp to use C++ uniform initialization for all variable
                          declarations.

Copyright (c) 2003 - 2023 by PJ Naughter (Web: www.naughter.com, Email: pjna@naughter.com)

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
#include "AADate.h"
#include <cmath>
#include <cassert>
#include <cstddef>
#include <array>


//////////////////// Implementation ///////////////////////////////////////////

CAADate::CAADate() noexcept : m_dblJulian{0},
                              m_bGregorianCalendar{false}
{
}

CAADate::CAADate(long Year, long Month, double Day, bool bGregorianCalendar) noexcept : m_dblJulian{0},
                                                                                        m_bGregorianCalendar{false}
{
  Set(Year, Month, Day, 0, 0, 0, bGregorianCalendar);
}

CAADate::CAADate(long Year, long Month, double Day, double Hour, double Minute, double Second, bool bGregorianCalendar) noexcept : m_dblJulian{0},
                                                                                                                                   m_bGregorianCalendar{false}
{
  Set(Year, Month, Day, Hour, Minute, Second, bGregorianCalendar);
}

CAADate::CAADate(double JD, bool bGregorianCalendar) noexcept : m_dblJulian{0},
                                                                m_bGregorianCalendar{false}
{
  Set(JD, bGregorianCalendar);
}

double CAADate::DateToJD(long Year, long Month, double Day, bool bGregorianCalendar) noexcept
{
  long Y{Year};
  long M{Month};
  if (M < 3)
  {
    Y = Y - 1;
    M = M + 12;
  }

  long B{0};
  if (bGregorianCalendar)
  {
    const long A{INT(Y / 100.0)};
    B = 2 - A + INT(A / 4.0);
  }

  return 0.0 + INT(365.25 * (Y + 4716.0)) + INT(30.6001 * (M + 1.0)) + Day + B - 1524.5;
}

bool CAADate::IsLeap(long Year, bool bGregorianCalendar) noexcept
{
  if (bGregorianCalendar)
  {
    if ((Year % 100) == 0)
      return ((Year % 400) == 0) ? true : false;
    else
      return ((Year % 4) == 0) ? true : false;
  }
  else
    return ((Year % 4) == 0) ? true : false;
}

void CAADate::Set(long Year, long Month, double Day, double Hour, double Minute, double Second, bool bGregorianCalendar) noexcept
{
  const double dblDay{Day + (Hour / 24) + (Minute / 1440) + (Second / 86400)};
  Set(DateToJD(Year, Month, dblDay, bGregorianCalendar), bGregorianCalendar);
}

void CAADate::Get(long& Year, long& Month, long& Day, long& Hour, long& Minute, double& Second) const noexcept
{
  const double JD{m_dblJulian + 0.5};
  double tempZ{0};
  double F{modf(JD, &tempZ)};
  const long Z{static_cast<long>(tempZ)};
  long A = 0;

  if (m_bGregorianCalendar) //There is a difference here between the Meeus implementation and this one
  //if (Z >= 2299161)       //The Meeus implementation automatically assumes the Gregorian Calendar 
                            //came into effect on 15 October 1582 (JD: 2299161), while the CAADate
                            //implementation has a "m_bGregorianCalendar" value to decide if the date
                            //was specified in the Gregorian or Julian Calendars. This difference
                            //means in effect that CAADate fully supports a propalactive version of the
                            //Julian calendar. This allows you to construct Julian dates after the Papal
                            //reform in 1582. This is useful if you want to construct dates in countries
                            //which did not immediately adapt the Gregorian calendar
  {
    const long alpha{INT((Z - 1867216.25) / 36524.25)};
    A = Z + 1 + alpha - INT(INT(alpha)/4.0);
  }
  else
    A = Z;

  const long B{A + 1524};
  long C{INT((B - 122.1) / 365.25)};
  const long D{INT(365.25 * C)};
  long E{INT((0.0 + B - D) / 30.6001)};

  double dblDay{0.0 + B - D - INT(30.6001 * E) + F};
  Day = static_cast<long>(dblDay);

  if (E < 14)
    Month = E - 1;
  else
    Month = E - 13;

  if (Month > 2)
    Year = C - 4716;
  else
    Year = C - 4715;

  F = modf(dblDay, &tempZ);
  Hour = INT(F*24);
  Minute = INT((F - (Hour)/24.0)*1440.0);
  Second = (F - (Hour / 24.0) - (Minute / 1440.0)) * 86400.0;
}

void CAADate::Set(double JD, bool bGregorianCalendar) noexcept
{
  m_dblJulian = JD;
  SetInGregorianCalendar(bGregorianCalendar);
}

void CAADate::SetInGregorianCalendar(bool bGregorianCalendar) noexcept
{
  const bool bAfterPapalReform{AfterPapalReform(m_dblJulian)};

#ifdef _DEBUG
  if (bGregorianCalendar) //We do not allow storage of proleptic Gregorian dates
    assert(bAfterPapalReform);
#endif //#ifdef _DEBUG

  m_bGregorianCalendar = bGregorianCalendar && bAfterPapalReform;
}

long CAADate::Day() const noexcept
{
  long Year{0};
  long Month{0};
  long Day{0};
  long Hour{0};
  long Minute{0};
  double Second{0};
  Get(Year, Month, Day, Hour, Minute, Second);
  return Day;
}

long CAADate::Month() const noexcept
{
  long Year{0};
  long Month{0};
  long Day{0};
  long Hour{0};
  long Minute{0};
  double Second{0};
  Get(Year, Month, Day, Hour, Minute, Second);
  return Month;
}

long CAADate::Year() const noexcept
{
  long Year{0};
  long Month{0};
  long Day{0};
  long Hour{0};
  long Minute{0};
  double Second{0};
  Get(Year, Month, Day, Hour, Minute, Second);
  return Year;
}

long CAADate::Hour() const noexcept
{
  long Year{0};
  long Month{0};
  long Day{0};
  long Hour{0};
  long Minute{0};
  double Second{0};
  Get(Year, Month, Day, Hour, Minute, Second);
  return Hour;
}

long CAADate::Minute() const noexcept
{
  long Year{0};
  long Month{0};
  long Day{0};
  long Hour{0};
  long Minute{0};
  double Second{0};
  Get(Year, Month, Day, Hour, Minute, Second);
  return Minute;
}

double CAADate::Second() const noexcept
{
  long Year{0};
  long Month{0};
  long Day{0};
  long Hour{0};
  long Minute{0};
  double Second{0};
  Get(Year, Month, Day, Hour, Minute, Second);
  return Second;
}

CAADate::DOW CAADate::DayOfWeek() const noexcept
{
  const long t{static_cast<long>(m_dblJulian + 1.5)};
  if (t >= 0)
    return static_cast<DOW>(t % 7);
  else
  {
    long r{7 - (abs(t) % 7)};
    if (r == 7)
      r -= 7;
    return static_cast<DOW>(r);
  }
}

long CAADate::DaysInMonth(long Month, bool bLeap) noexcept
{
  //Validate our parameters
  assert((Month >= 1) && (Month <= 12));
#ifdef _MSC_VER
  __analysis_assume(Month >= 1 && Month <= 12);
#endif //#ifdef _MSC_VER

  static constexpr std::array<int, 12> g_NonLeapMonths{31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
  static constexpr std::array<int, 12> g_LeapMonths{31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};

  if (bLeap)
  {
  #ifdef _MSC_VER
    #pragma warning(suppress : 26446 26472 26482)
  #endif //#ifdef _MSC_VER
    return g_LeapMonths[static_cast<size_t>(Month) - 1];
  }
  else
  {
  #ifdef _MSC_VER
    #pragma warning(suppress : 26446 26472 26482)
  #endif //#ifdef _MSC_VER
    return g_NonLeapMonths[static_cast<size_t>(Month) - 1];
  }
}

long CAADate::DaysInMonth() const noexcept
{
  long Year{0};
  long Month{0};
  long Day{0};
  long Hour{0};
  long Minute{0};
  double Second{0};
  Get(Year, Month, Day, Hour, Minute, Second);

  return DaysInMonth(Month, IsLeap(Year, m_bGregorianCalendar));
}

long CAADate::DaysInYear() const noexcept
{
  long Year{0};
  long Month{0};
  long Day{0};
  long Hour{0};
  long Minute{0};
  double Second{0};
  Get(Year, Month, Day, Hour, Minute, Second);

  if (IsLeap(Year, m_bGregorianCalendar))
    return 366;
  else
    return 365;
}

double CAADate::DayOfYear() const noexcept
{
  long Year{0};
  long Month{0};
  long Day{0};
  long Hour{0};
  long Minute{0};
  double Second{0};
  Get(Year, Month, Day, Hour, Minute, Second);

  return DayOfYear(m_dblJulian, Year, AfterPapalReform(Year, 1, 1));
}

double CAADate::DayOfYear(double JD, long Year, bool bGregorianCalendar) noexcept
{
  return JD - DateToJD(Year, 1, 1, bGregorianCalendar) + 1;
}

double CAADate::FractionalYear() const noexcept
{
  long Year{0};
  long Month{0};
  long Day{0};
  long Hour{0};
  long Minute{0};
  double Second{0};
  Get(Year, Month, Day, Hour, Minute, Second);

  long DaysInYear{0};
  if (IsLeap(Year, m_bGregorianCalendar))
    DaysInYear = 366;
  else
    DaysInYear = 365;

  return Year + ((m_dblJulian - DateToJD(Year, 1, 1, AfterPapalReform(Year, 1, 1))) / DaysInYear);
}

bool CAADate::Leap() const noexcept
{
  return IsLeap(Year(), m_bGregorianCalendar);
}

void CAADate::DayOfYearToDayAndMonth(long DayOfYear, bool bLeap, long& DayOfMonth, long& Month) noexcept
{
  long K{bLeap ? 1 : 2};

  Month = INT(9 * (0.0 + K + DayOfYear) / 275.0 + 0.98);
  if (DayOfYear < 32)
    Month = 1;

  DayOfMonth = DayOfYear - INT((275.0 * Month) / 9.0) + (K * INT((Month + 9.0) / 12.0)) + 30;
}

long CAADate::INT(double value) noexcept
{
  if (value >= 0)
    return static_cast<long>(value);
  else
    return static_cast<long>(value - 1);
}

CAACalendarDate CAADate::JulianToGregorian(long Year, long Month, long Day) noexcept
{
  CAADate date{Year, Month, static_cast<double>(Day), false};
  date.SetInGregorianCalendar(true);

  CAACalendarDate GregorianDate;
  long Hour{0};
  long Minute{0};
  double Second{0};
  date.Get(GregorianDate.Year, GregorianDate.Month, GregorianDate.Day, Hour, Minute, Second);

  return GregorianDate;
}

CAACalendarDate CAADate::GregorianToJulian(long Year, long Month, long Day) noexcept
{
  CAADate date{Year, Month, static_cast<double>(Day), true};
  date.SetInGregorianCalendar(false);

  CAACalendarDate JulianDate;
  long Hour{0};
  long Minute{0};
  double Second{0};
  date.Get(JulianDate.Year, JulianDate.Month, JulianDate.Day, Hour, Minute, Second);

  return JulianDate;
}
