//
//  KPCAAEarth.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 04/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KPCAAEarth : NSObject

+ (double)EclipticLongitude:(double)JD;
+ (double)EclipticLatitude:(double)JD;
+ (double)RadiusVector:(double)JD;
+ (double)SunMeanAnomaly:(double)JD;
+ (double)Eccentricity:(double)JD;
+ (double)EclipticLongitudeJ2000:(double)JD;
+ (double)EclipticLatitudeJ2000:(double)JD;

@end
