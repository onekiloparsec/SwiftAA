//
//  KPCAADate.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 04/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import "KPCAADate.h"
#import "AADate.h"

double KPCAADate_DateToJulianDay(long year, long month, long day, BOOL useGregorianCalendar) {
    return CAADate::DateToJD(year, month, day, (bool)useGregorianCalendar);
}

BOOL KPCAADate_IsLeapForYear(long year, BOOL useGregorianCalendar) {
    return CAADate::IsLeap(year, (bool)useGregorianCalendar);
}

void KPCAADate_DayOfYearToDayAndMonth(long dayOfYear, BOOL leapYear, long * dayOfMonth, long * month) {
    return CAADate::DayOfYearToDayAndMonth(dayOfYear, (bool)leapYear, *dayOfMonth, *month);
}

KPCAACalendarDate KPCAADate_JulianToGregorian(long year, long month, long day) {
    CAACalendarDate plusDate = CAADate::JulianToGregorian(year, month, day);
    KPCAACalendarDate date;
    date.Year = plusDate.Year;
    date.Month = plusDate.Month;
    date.Day = plusDate.Day;
    return date;
}

KPCAACalendarDate KPCAADate_GregorianToJulian(long year, long month, long day) {
    CAACalendarDate plusDate = CAADate::GregorianToJulian(year, month, day);
    KPCAACalendarDate date;
    date.Year = plusDate.Year;
    date.Month = plusDate.Month;
    date.Day = plusDate.Day;
    return date;
}

KPCAADateHandle KPCAADate_CreateWithDate(long year, long month, double day, BOOL useGregorianCalendar) {
    KPCAADateHandle dateHandle = new CAADate(year, month, day, (bool)useGregorianCalendar);
    return dateHandle;
}

KPCAADateHandle KPCAADate_CreateWithDateTime(long year, long month, double day, double hour, double minute, double second, BOOL useGregorianCalendar) {
    KPCAADateHandle dateHandle = new CAADate(year, month, day, hour, minute, second, (bool)useGregorianCalendar);
    return dateHandle;
}

KPCAADateHandle KPCAADate_CreateWithJulianDay(double julianDay, BOOL useGregorianCalendar) {
    KPCAADateHandle dateHandle = new CAADate(julianDay, (bool)useGregorianCalendar);
    return dateHandle;
}

void KPCAADate_Destroy(KPCAADateHandle date) {
    CAADate* datePtr = reinterpret_cast<CAADate *>(date);
    delete datePtr;
}

double KPCAADate_GetJulian(KPCAADateHandle date) {
    CAADate* datePtr = reinterpret_cast<CAADate *>(date);
    return datePtr->Julian();
}

long KPCAADate_GetDay(KPCAADateHandle date) {
    CAADate* datePtr = reinterpret_cast<CAADate *>(date);
    return datePtr->Day();
}
long KPCAADate_GetMonth(KPCAADateHandle date) {
    CAADate* datePtr = reinterpret_cast<CAADate *>(date);
    return datePtr->Month();
}
long KPCAADate_GetYear(KPCAADateHandle date) {
    CAADate* datePtr = reinterpret_cast<CAADate *>(date);
    return datePtr->Year();
}
long KPCAADate_GetHour(KPCAADateHandle date) {
    CAADate* datePtr = reinterpret_cast<CAADate *>(date);
    return datePtr->Hour();
}
long KPCAADate_GetMinute(KPCAADateHandle date) {
    CAADate* datePtr = reinterpret_cast<CAADate *>(date);
    return datePtr->Minute();
}
double KPCAADate_GetSecond(KPCAADateHandle date) {
    CAADate* datePtr = reinterpret_cast<CAADate *>(date);
    return datePtr->Second();
}

void KPCAADate_SetDateTime(KPCAADateHandle date, long year, long month, double day, double hour, double minute, double second, BOOL useGregorianCalendar) {
    CAADate* datePtr = reinterpret_cast<CAADate *>(date);
    datePtr->Set(year, month, day, hour, minute, second, (bool)useGregorianCalendar);
}

void KPCAADate_SetJulianDay(KPCAADateHandle date, double julianDay, BOOL useGregorianCalendar) {
    CAADate* datePtr = reinterpret_cast<CAADate *>(date);
    datePtr->Set(julianDay, (bool)useGregorianCalendar);
}

void KPCAADate_SetIsInGregorianCalendar(KPCAADateHandle date, BOOL useGregorianCalendar) {
    CAADate* datePtr = reinterpret_cast<CAADate *>(date);
    datePtr->SetInGregorianCalendar((bool)useGregorianCalendar);
}

void KPCAADate_GetDateTime(KPCAADateHandle date, long * year, long * month, long * day, long * hour, long * minute, double * second) {
    CAADate* datePtr = reinterpret_cast<CAADate *>(date);
    datePtr->Get(*year, *month, *day, *hour, *minute, *second);
}

DAY_OF_WEEK KPCAADate_GetDayOfWeek(KPCAADateHandle date) {
    CAADate* datePtr = reinterpret_cast<CAADate *>(date);
    return (DAY_OF_WEEK)datePtr->DayOfWeek();
}

double KPCAADate_GetDayOfYear(KPCAADateHandle date) {
    CAADate* datePtr = reinterpret_cast<CAADate *>(date);
    return datePtr->DayOfYear();
}

long KPCAADate_GetDaysInMonth(KPCAADateHandle date) {
    CAADate* datePtr = reinterpret_cast<CAADate *>(date);
    return datePtr->DaysInMonth();
}

long KPCAADate_GetDaysInYear(KPCAADateHandle date) {
    CAADate* datePtr = reinterpret_cast<CAADate *>(date);
    return datePtr->DaysInYear();
}

BOOL KPCAADate_GetLeap(KPCAADateHandle date) {
    CAADate* datePtr = reinterpret_cast<CAADate *>(date);
    return datePtr->Leap();
}

BOOL KPCAADate_GetIsInGregorianCalendar(KPCAADateHandle date) {
    CAADate* datePtr = reinterpret_cast<CAADate *>(date);
    return datePtr->InGregorianCalendar();
}

double KPCAADate_GetFractionalYear(KPCAADateHandle date) {
    CAADate* datePtr = reinterpret_cast<CAADate *>(date);
    return datePtr->FractionalYear();
}
