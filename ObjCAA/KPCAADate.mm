//
//  KPCAADate.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 04/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import "KPCAADate.h"
#import "AADate.h"

@interface KPCAADate () {
    CAADate _wrapped;
}
@end

@implementation KPCAADate

- (instancetype)init
{
    self = [super init];
    if (self) {
        _wrapped = CAADate();
    }
    return self;
}

- (instancetype)initWithWrappedDate:(CAADate)wrappedDate
{
    self = [super init];
    if (self) {
        _wrapped = wrappedDate;
    }
    return self;
}

- (instancetype)initWithYear:(long)Year month:(long)Month day:(double)Day usingGregorianCalendar:(BOOL)gregorianCalendar
{
    return [self initWithWrappedDate:CAADate(Year, Month, Day, (bool)gregorianCalendar)];
}

- (instancetype)initWithYear:(long)Year month:(long)Month day:(double)Day hour:(double)Hour minute:(double)Minute second:(double)Second usingGregorianCalendar:(BOOL)gregorianCalendar
{
    return [self initWithWrappedDate:CAADate(Year, Month, Day, Hour, Minute, Second, (bool)gregorianCalendar)];
}

- (instancetype)initWithJulianDay:(double)JD usingGregorianCalendar:(BOOL)gregorianCalendar
{
    return [self initWithWrappedDate:CAADate(JD, (bool)gregorianCalendar)];
}

+ (double)DateToJDForYear:(long)Year month:(long)Month day:(double)Day usingGregorianCalendar:(BOOL)gregorianCalendar
{
    return CAADate::DateToJD(Year, Month, Day, (bool)gregorianCalendar);
}

+ (BOOL)IsLeapForYear:(long)Year usingGregorianCalendar:(BOOL)gregorianCalendar
{
    return CAADate::IsLeap(Year, (bool)gregorianCalendar);
}

+ (void)DayOfYearToDayAndMonth:(long)DayOfYear leap:(BOOL)leapYear dayOfMonth:(long *)DayOfMonth month:(long *)Month
{
    return CAADate::DayOfYearToDayAndMonth(DayOfYear, (bool)leapYear, *DayOfMonth, *Month);
}

+ (KPCAACalendarDate)JulianToGregorianForYear:(long)Year month:(long)Month day:(long)Day
{
    CAACalendarDate plusDate = CAADate::JulianToGregorian(Year, Month, Day);
    KPCAACalendarDate date;
    date.Year = plusDate.Year;
    date.Month = plusDate.Month;
    date.Day = plusDate.Day;
    return date;
}

+ (KPCAACalendarDate)GregorianToJulianForYear:(long)Year month:(long)Month day:(long)Day
{
    CAACalendarDate plusDate = CAADate::GregorianToJulian(Year, Month, Day);
    KPCAACalendarDate date;
    date.Year = plusDate.Year;
    date.Month = plusDate.Month;
    date.Day = plusDate.Day;
    return date;
}

+ (BOOL)AfterPapalReformForYear:(long)Year month:(long)Month day:(double)Day
{
    return (BOOL)CAADate::AfterPapalReform(Year, Month, Day);
}

+ (BOOL)AfterPapalReformForJulianDay:(double)JD
{
    return (BOOL)CAADate::AfterPapalReform(JD);
}

+ (double)DayOfYearForJulianDay:(double)JD year:(long)Year usingGregorianCalendar:(BOOL)gregorianCalendar
{
    return CAADate::DayOfYear(JD, Year, (bool)gregorianCalendar);
}

+ (long)DaysInMonth:(long)Month leap:(BOOL)leapYear
{
    return CAADate::DaysInMonth(Month, (bool)leapYear);
}

- (double)Julian
{
    return _wrapped.Julian();
}

- (long)Day
{
    return _wrapped.Day();
}

- (long)Month
{
    return _wrapped.Month();
}

- (long)Year
{
    return _wrapped.Year();
}

- (long)Hour
{
    return _wrapped.Hour();
}

- (long)Minute
{
    return _wrapped.Minute();
}

- (double)Second
{
    return _wrapped.Second();
}

- (void)setDateWithYear:(long)Year month:(long)Month day:(double)Day hour:(double)Hour minute:(double)Minute second:(double)Second usingGregorianCalendar:(BOOL)gregorianCalendar
{
    _wrapped.Set(Year, Month, Day, Hour, Minute, Second, (bool)gregorianCalendar);
}

- (void)setDateWithJulianDay:(double)JD usingGregorianCalendar:(BOOL)gregorianCalendar
{
    _wrapped.Set(JD, (bool)gregorianCalendar);
}

- (void)setInGregorianCalendar:(BOOL)gregorianCalendar
{
    _wrapped.SetInGregorianCalendar((bool)gregorianCalendar);
}

- (void)getDateWithYear:(long *)Year month:(long *)Month day:(long *)Day hour:(long *)Hour minute:(long *)Minute second:(double *)Second
{
    _wrapped.Get(*Year, *Month, *Day, *Hour, *Minute, *Second);
}

- (DAY_OF_WEEK)DayOfWeek
{
    return (DAY_OF_WEEK)_wrapped.DayOfWeek();
}

- (double)DayOfYear
{
    return _wrapped.DayOfYear();
}

- (long)DaysInMonth
{
    return _wrapped.DaysInMonth();
}

- (long)DaysInYear
{
    return _wrapped.DaysInYear();
}

- (BOOL)Leap
{
    return _wrapped.Leap();
}

- (BOOL)InGregorianCalendar
{
    return _wrapped.InGregorianCalendar();
}

- (double)FractionalYear
{
    return _wrapped.FractionalYear();
}

@end

@implementation KPCAADate (SwiftAAAdditions)

- (instancetype)initWithGregorianCalendarDate:(NSDate *)date
{
    NSCalendar *gregorianCalendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:date];
    
    return [self initWithWrappedDate:CAADate(components.year, components.month, components.day, components.hour, components.minute, components.second, YES)];
}

@end


