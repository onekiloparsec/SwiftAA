//
//  KPCAANearParabolic.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 09/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KPCAA3DCoordinate.h"

@interface KPCAANearParabolicObjectElements : NSObject

@property(nonatomic, assign) double q;
@property(nonatomic, assign) double i;
@property(nonatomic, assign) double w;
@property(nonatomic, assign) double omega;
@property(nonatomic, assign) double JDEquinox;
@property(nonatomic, assign) double T;
@property(nonatomic, assign) double e;

@end


@interface KPCAANearParabolicObjectDetails : NSObject

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


@interface KPCAANearParabolic : NSObject

+ (KPCAANearParabolicObjectDetails *)Calculate:(double)JD elements:(KPCAANearParabolicObjectElements *)elements;

+ (double)cbrt:(double)x;

+ (void)CalulateTrueAnnomalyAndRadius:(double)JD elements:(KPCAANearParabolicObjectElements *)elements v:(double *)v r:(double *)r;

@end
