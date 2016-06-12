//
//  KPCAAParallactic.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 09/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import <Foundation/Foundation.h>

@interface KPCAAParallactic : NSObject

+ (double)ParallacticAngle:(double)HourAngle Latitude:(double)Latitude delta:(double)delta;
+ (double)EclipticLongitudeOnHorizon:(double)LocalSiderealTime ObliquityOfEcliptic:(double)ObliquityOfEcliptic Latitude:(double)Latitude;
+ (double)AngleBetweenEclipticAndHorizon:(double)LocalSiderealTime ObliquityOfEcliptic:(double)ObliquityOfEcliptic Latitude:(double)Latitude;
+ (double)AngleBetweenNorthCelestialPoleAndNorthPoleOfEcliptic:(double)Lambda Beta:(double)Beta  ObliquityOfEcliptic:(double)ObliquityOfEcliptic;

@end
