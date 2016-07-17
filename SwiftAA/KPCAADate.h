//
//  KPCAADate.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 04/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import <Foundation/Foundation.h>

typedef struct KPCAACalendarDate {
    long Year;
    long Month;
    long Day;
} KPCAACalendarDate;


typedef NS_ENUM(NSUInteger, DAY_OF_WEEK) {
    SUNDAY,
    MONDAY,
    TUESDAY,
    WEDNESDAY,
    THURSDAY,
    FRIDAY,
    SATURDAY
};

@interface KPCAADate : NSObject

// Constructors

- (instancetype)initWithYear:(long)Year month:(long)Month day:(double)Day usingGregorianCalendar:(BOOL)gregorianCalendar;

- (instancetype)initWithYear:(long)Year month:(long)Month day:(double)Day hour:(double)Hour minute:(double)Minute second:(double)Second usingGregorianCalendar:(BOOL)gregorianCalendar;

- (instancetype)initWithJulianDay:(double)JD usingGregorianCalendar:(BOOL)gregorianCalendar;

// Class methods (~ 'static' in C++)

+ (double)DateToJDForYear:(long)Year month:(long)Month day:(double)Day usingGregorianCalendar:(BOOL)gregorianCalendar;

+ (BOOL)IsLeapForYear:(long)Year usingGregorianCalendar:(BOOL)gregorianCalendar;

+ (void)DayOfYearToDayAndMonth:(long)DayOfYear leap:(BOOL)leapYear dayOfMonth:(long *)DayOfMonth month:(long *)Month;

+ (KPCAACalendarDate)JulianToGregorianForYear:(long)Year month:(long)Month day:(long)Day;

+ (KPCAACalendarDate)GregorianToJulianForYear:(long)Year month:(long)Month day:(long)Day;

// Instance methods (~ 'non static' in C++)

- (double)Julian;
- (long)Day;
- (long)Month;
- (long)Year;
- (long)Hour;
- (long)Minute;
- (double)Second;

- (void)setDateWithYear:(long)Year month:(long)Month day:(double)Day hour:(double)Hour minute:(double)Minute second:(double)Second usingGregorianCalendar:(BOOL)gregorianCalendar;

- (void)setDateWithJulianDay:(double)JD usingGregorianCalendar:(BOOL)gregorianCalendar;

- (void)setInGregorianCalendar:(BOOL)gregorianCalendar;

- (void)getDateWithYear:(long *)Year month:(long *)Month day:(long *)Day hour:(long *)Hour minute:(long *)Minute second:(double *)Second;

- (DAY_OF_WEEK)DayOfWeek;
- (double)DayOfYear;
- (long)DaysInMonth;
- (long)DaysInYear;
- (BOOL)Leap;
- (BOOL)InGregorianCalendar;
- (double)FractionalYear;

@end

@interface KPCAADate (SwiftAAAdditions)

- (instancetype)initWithGregorianCalendarDate:(NSDate *)date;

@end

