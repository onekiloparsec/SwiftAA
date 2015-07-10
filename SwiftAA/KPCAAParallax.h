//
//  KPCAAParallax.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 09/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KPCAA2DCoordinate.h"

@interface KPCAATopocentricEclipticDetails : NSObject

@property(nonatomic, assign) double Lambda;
@property(nonatomic, assign) double Beta;
@property(nonatomic, assign) double Semidiameter;

@end

@interface KPCAAParallax : NSObject

+ (KPCAA2DCoordinate *)Equatorial2TopocentricDelta:(double)Alpha Delta:(double)Delta Distance:(double)Distance Longitude:(double)Longitude Latitude:(double)Latitude Height:(double)Height JD:(double)JD;

+ (KPCAA2DCoordinate *)Equatorial2Topocentric:(double)Alpha Delta:(double)Delta Distance:(double)Distance Longitude:(double)Longitude Latitude:(double)Latitude Height:(double)Height JD:(double)JD;

+ (KPCAATopocentricEclipticDetails *)Ecliptic2Topocentric:(double)Lambda Beta:(double)Beta  Semidiameter:(double)Semidiameter Distance:(double)Distance Epsilon:(double)Epsilon Latitude:(double)Latitude Height:(double)Height JD:(double)JD;

+ (double)ParallaxToDistance:(double)Parallax;
+ (double)DistanceToParallax:(double)Distance;

@end
