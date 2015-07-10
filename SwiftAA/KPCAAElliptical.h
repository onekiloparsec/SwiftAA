//
//  KPCAAElliptical.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 06/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KPCAA3DCoordinate.h"
#import "KPCAAPlanetaryPhenomena.h"

@interface KPCAAEllipticalObjectElements : NSObject

@property(nonatomic, assign) double a;
@property(nonatomic, assign) double e;
@property(nonatomic, assign) double i;
@property(nonatomic, assign) double w;
@property(nonatomic, assign) double omega;
@property(nonatomic, assign) double JDEquinox;
@property(nonatomic, assign) double T;

@end

@interface KPCAAEllipticalPlanetaryDetails : NSObject

@property(nonatomic, assign) double ApparentGeocentricLongitude;
@property(nonatomic, assign) double ApparentGeocentricLatitude;
@property(nonatomic, assign) double ApparentGeocentricDistance;
@property(nonatomic, assign) double ApparentLightTime;
@property(nonatomic, assign) double ApparentGeocentricRA;
@property(nonatomic, assign) double ApparentGeocentricDeclination;

@end

@interface KPCAAEllipticalObjectDetails : NSObject

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

@interface KPCAAElliptical : NSObject

+ (double)DistanceToLightTime:(double)Distance;
+ (KPCAAEllipticalPlanetaryDetails *)Calculate:(double)JD object:(KPCPlanetaryObject)object;
+ (double)SemiMajorAxisFromPerihelionDistance:(double)q e:(double)e;
+ (double)MeanMotionFromSemiMajorAxis:(double)a;
+ (KPCAAEllipticalObjectDetails *)Calculate:(double)JD elements:(KPCAAEllipticalObjectElements * __autoreleasing *) elements;
+ (double)InstantaneousVelocity:(double)r a:(double)a;
+ (double)VelocityAtPerihelion:(double)e a:(double)a;
+ (double)VelocityAtAphelion:(double)e a:(double)a;
+ (double)LengthOfEllipse:(double)e a:(double)a;
+ (double)CometMagnitude:(double)g delta:(double)delta  k:(double)k  r:(double)r;
+ (double)MinorPlanetMagnitude:(double)H delta:(double)delta G:(double)G r:(double)r PhaseAngle:(double)PhaseAngle;

@end


