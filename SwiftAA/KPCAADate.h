//
//  KPCAADate.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 04/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KPCAACalendarDate : NSObject

@property(nonatomic, assign) long Year;
@property(nonatomic, assign) long Month;
@property(nonatomic, assign) long Day;

@end


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

+ (KPCAACalendarDate *)JulianToGregorianForYear:(long)Year month:(long)Month day:(long)Day;

+ (KPCAACalendarDate *)GregorianToJulianForYear:(long)Year month:(long)Month day:(long)Day;

// Instance methods (~ 'non static' in C++)

- (double)Julian;
- (long)Day;
- (long)Month;
- (long)Year;
- (long)Hour;
- (long)Minute;
- (long)Second;

- (void)setDateWithYear:(long)Year month:(long)Month day:(double)Day hour:(double)Hour minute:(double)Minute second:(double)Second usingGregorianCalendar:(BOOL)gregorianCalendar;

- (void)setDateWithJulianDay:(double)JD usingGregorianCalendar:(BOOL)gregorianCalendar;

- (void)setInGregorianCalendar:(BOOL)gregorianCalendar;

- (void)getDateWithYear:(long *)Year month:(long *)Month day:(long *)Day hour:(long *)Hour minute:(long *)Minute second:(double *)Second;

- (DAY_OF_WEEK)DayOfWeek;
- (long)DayOfYear;
- (long)DaysInMonth;
- (long)DaysInYear;
- (BOOL)Leap;
- (BOOL)InGregorianCalendar;
- (double)FractionalYear;

@end


@interface KPCAADate (SwiftAACustom)

- (instancetype)initWithGregorianCalendarDate:(NSDate *)date;

@end
