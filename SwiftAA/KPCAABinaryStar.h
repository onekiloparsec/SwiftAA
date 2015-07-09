//
//  KPCAABinaryStar.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 04/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KPCAABinaryStarDetails : NSObject

@property(nonatomic, assign) double r;
@property(nonatomic, assign) double Theta;
@property(nonatomic, assign) double Rho;

@end

@interface KPCAABinaryStar : NSObject

/** Units:
 * t: decimal years
 * P: mean solar years
 * T: decimal year
 * e: n.a.
 * a: arcseconds
 * i: degrees
 * Omega: degrees
 * w: degrees
 */
+ (KPCAABinaryStarDetails *)CalculateWithTime:(double)t period:(double)P timeOfPeriastron:(double)T eccentricity:(double)e semimajorAxis:(double)a inclination:(double)i positionAngleOfAscendingNode:(double)Omega longitudeOfPeriastron:(double)w;

/** Units:
 * e: n.a.
 * i: degrees
 * w: degrees
 */
+ (double)ApparentEccentricityForEccentricity:(double)e inclination:(double)i longitudeOfPeriastron:(double)w;

@end
