//
//  KPCAAMoon.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 09/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KPCAAMoon : NSObject

+ (double)MeanLongitude:(double)JD;
+ (double)MeanElongation:(double)JD;
+ (double)MeanAnomaly:(double)JD;
+ (double)ArgumentOfLatitude:(double)JD;
+ (double)MeanLongitudeAscendingNode:(double)JD;
+ (double)MeanLongitudePerigee:(double)JD;
+ (double)TrueLongitudeAscendingNode:(double)JD;

+ (double)EclipticLongitude:(double)JD;
+ (double)EclipticLatitude:(double)JD;
+ (double)RadiusVector:(double)JD;

+ (double)RadiusVectorToHorizontalParallax:(double)RadiusVector;
+ (double)HorizontalParallaxToRadiusVector:(double)Parallax;

@end
