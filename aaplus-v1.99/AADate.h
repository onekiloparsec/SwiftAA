/*
Module : AADate.h
Purpose: Implementation for the algorithms which convert between the Gregorian and Julian calendars and the Julian Day
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
#endif //#if _MSC_VER > 1000

#ifndef __AADATE_H__
#define __AADATE_H__

#ifndef AAPLUS_EXT_CLASS
#define AAPLUS_EXT_CLASS
#endif //#ifndef AAPLUS_EXT_CLASS


/////////////////////// Classes ///////////////////////////////////////////////

class AAPLUS_EXT_CLASS CAACalendarDate
{
public:
//Constructors / Destructors
  CAACalendarDate() noexcept : Year(0),
                               Month(0),
                               Day(0)
  {
  };

//Member variables
  long Year;
  long Month;
  long Day;
};


class AAPLUS_EXT_CLASS CAADate
{
public:
//Enums
  enum class DAY_OF_WEEK
  {
    SUNDAY	  = 0,
    MONDAY	  = 1,
    TUESDAY	  = 2,
    WEDNESDAY	= 3,
    THURSDAY	= 4,
    FRIDAY	  = 5,
    SATURDAY	= 6
  };

//Constructors / Destructors
  CAADate() noexcept;
  CAADate(long Year, long Month, double Day, bool bGregorianCalendar) noexcept;
  CAADate(long Year, long Month, double Day, double Hour, double Minute, double Second, bool bGregorianCalendar) noexcept;
  CAADate(double JD, bool bGregorianCalendar) noexcept;

//Static Methods
  static double          DateToJD(long Year, long Month, double Day, bool bGregorianCalendar) noexcept;
  static bool            IsLeap(long Year, bool bGregorianCalendar) noexcept;
  static void            DayOfYearToDayAndMonth(long DayOfYear, bool bLeap, long& DayOfMonth, long& Month) noexcept;
  static CAACalendarDate JulianToGregorian(long Year, long Month, long Day) noexcept;
  static CAACalendarDate GregorianToJulian(long Year, long Month, long Day) noexcept;
  static long            INT(double value) noexcept;

  constexpr static bool AfterPapalReform(long Year, long Month, double Day)
  {
    return ((Year > 1582) || ((Year == 1582) && (Month > 10)) || ((Year == 1582) && (Month == 10) && (Day >= 15)));
  }

  constexpr static bool AfterPapalReform(double JD)
  {
    return (JD >= 2299160.5);
  }

  static double          DayOfYear(double JD, long Year, bool bGregorianCalendar) noexcept;
  static long            DaysInMonth(long Month, bool bLeap) noexcept;

//Non Static methods
  double      Julian() const noexcept { return m_dblJulian; };
  operator    double() const noexcept { return m_dblJulian; };
  long        Day() const noexcept;
  long        Month() const noexcept;
  long        Year() const noexcept;
  long        Hour() const noexcept;
  long        Minute() const noexcept;
  double      Second() const noexcept;
  void        Set(long Year, long Month, double Day, double Hour, double Minute, double Second, bool bGregorianCalendar) noexcept;
  void        Set(double JD, bool bGregorianCalendar) noexcept;
  void        SetInGregorianCalendar(bool bGregorianCalendar) noexcept;
  void        Get(long& Year, long& Month, long& Day, long& Hour, long& Minute, double& Second) const noexcept;
  DAY_OF_WEEK DayOfWeek() const noexcept;
  double      DayOfYear() const noexcept;
  long        DaysInMonth() const noexcept;
  long        DaysInYear() const noexcept;
  bool        Leap() const noexcept;
  bool        InGregorianCalendar() const noexcept { return m_bGregorianCalendar; };
  double      FractionalYear() const noexcept;

protected:
//Member variables
  double m_dblJulian;  //Julian Day number for this date
  bool   m_bGregorianCalendar; //Is this date in the Gregorian calendar
};


#endif //#ifndef __AADATE_H__
