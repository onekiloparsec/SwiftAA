//
//  KPCAAParabolic.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 09/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KPCAA3DCoordinate.h"

@interface KPCAAParabolicObjectElements : NSObject

@property(nonatomic, assign) double q;
@property(nonatomic, assign) double i;
@property(nonatomic, assign) double w;
@property(nonatomic, assign) double omega;
@property(nonatomic, assign) double JDEquinox;
@property(nonatomic, assign) double T;

@end


@interface KPCAAParabolicObjectDetails : NSObject

@property(nonatomic, strong) KPCAA3DCoordinate *HeliocentricRectangularEquatorial;
@property(nonatomic, strong) KPCAA3DCoordinate *HeliocentricRectangularEcliptical;
@property(nonatomic, assign) double HeliocentricEclipticLongitude;
@property(nonatomic, assign) double HeliocentricEclipticLatitude;
@property(nonatomic, assign) double TrueGeocentricRA;
@property(nonatomic, assign) double TrueGeocentricDeclination;
@property(nonatomic, assign) double TrueGeocentricDistance;
@property(nonatomic, assign) double TrueGeocentricLightTime;
@property(nonatomic, assign) double AstrometricGeocentricRA;
@property(nonatomic, assign) double AstrometricGeocentricDeclination;
@property(nonatomic, assign) double AstrometricGeocentricDistance;
@property(nonatomic, assign) double AstrometricGeocentricLightTime;
@property(nonatomic, assign) double Elongation;
@property(nonatomic, assign) double PhaseAngle;

@end


@interface KPCAAParabolic : NSObject

+ (double)CalculateBarkers:(double)W;
+ (KPCAAParabolicObjectDetails *)Calculate:(double)JD elements:(KPCAAParabolicObjectElements *)elements;

@end
