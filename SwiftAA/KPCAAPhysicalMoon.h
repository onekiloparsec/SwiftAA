//
//  KPCAAPhysicalMoon.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 10/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KPCAAPhysicalMoonDetails : NSObject

@property(nonatomic, assign) double ldash;
@property(nonatomic, assign) double bdash;
@property(nonatomic, assign) double ldash2;
@property(nonatomic, assign) double bdash2;
@property(nonatomic, assign) double l;
@property(nonatomic, assign) double b;
@property(nonatomic, assign) double P;

@end

@interface KPCAASelenographicMoonDetails : NSObject

@property(nonatomic, assign) double l0;
@property(nonatomic, assign) double b0;
@property(nonatomic, assign) double c0;

@end

@interface KPCAAPhysicalMoon : NSObject

+ (KPCAAPhysicalMoonDetails *)CalculateGeocentric:(double)JD;
+ (KPCAAPhysicalMoonDetails *)CalculateTopocentric:(double)JD Longitude:(double)Longitude Latitude:(double)Latitude;
+ (KPCAASelenographicMoonDetails *)CalculateSelenographicPositionOfSun:(double)JD;

+ (double)AltitudeOfSun:(double)JD Longitude:(double)Longitude Latitude:(double)Latitude;
+ (double)TimeOfSunrise:(double)JD Longitude:(double)Longitude Latitude:(double)Latitude;
+ (double)TimeOfSunset:(double)JD Longitude:(double)Longitude Latitude:(double)Latitude;

@end
