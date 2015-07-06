//
//  KPCAAElliptical.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 06/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import "KPCAAElliptical.h"

@interface KPCAAEllipticalObjectElements () {
    CAAEllipticalObjectElements _wrapped;
}
- (CAAEllipticalObjectElements)wrappedElements;
@end

@implementation KPCAAEllipticalObjectElements

- (instancetype)init
{
    self = [super init];
    if (self) {
        _wrapped = CAAEllipticalObjectElements();
    }
    return self;
}

- (instancetype)initWithWrappedElements:(CAAEllipticalObjectElements)wrappedElements
{
    self = [super init];
    if (self) {
        _wrapped = wrappedElements;
    }
    return self;
}

+ (KPCAAEllipticalObjectElements *)elementsByWrapping:(CAAEllipticalObjectElements)wrappedElements
{
    return [[KPCAAEllipticalObjectElements alloc] initWithWrappedElements:wrappedElements];
}

- (CAAEllipticalObjectElements)wrappedElements
{
    return _wrapped;
}

- (double)a
{
    return _wrapped.a;
}

- (void)setA:(double)a
{
    _wrapped.a = a;
}

- (double)e
{
    return _wrapped.e;
}

- (void)setE:(double)e
{
    _wrapped.e = e;
}

- (double)i
{
    return _wrapped.i;
}

- (void)setI:(double)i
{
    _wrapped.i = i;
}

- (double)w
{
    return _wrapped.w;
}

- (void)setW:(double)w
{
    _wrapped.w = w;
}

- (double)omega
{
    return _wrapped.omega;
}

- (void)setOmega:(double)omega
{
    _wrapped.omega = omega;
}

- (double)JDEquinox
{
    return _wrapped.JDEquinox;
}

- (void)setJDEquinox:(double)JDEquinox
{
    _wrapped.JDEquinox = JDEquinox;
}

- (double)T
{
    return _wrapped.T;
}

- (void)setT:(double)T
{
    _wrapped.T = T;
}

@end

@interface KPCAAEllipticalPlanetaryDetails () {
    CAAEllipticalPlanetaryDetails _wrapped;
}
@end

@implementation KPCAAEllipticalPlanetaryDetails

- (instancetype)init
{
    self = [super init];
    if (self) {
        _wrapped = CAAEllipticalPlanetaryDetails();
    }
    return self;
}

- (instancetype)initWithWrappedDetails:(CAAEllipticalPlanetaryDetails)wrappedDetails
{
    self = [super init];
    if (self) {
        _wrapped = wrappedDetails;
    }
    return self;
}

+ (KPCAAEllipticalPlanetaryDetails *)detailsByWrapping:(CAAEllipticalPlanetaryDetails)wrappedDetails
{
    return [[KPCAAEllipticalPlanetaryDetails alloc] initWithWrappedDetails:wrappedDetails];
}

- (double)ApparentGeocentricLongitude
{
    return _wrapped.ApparentGeocentricLongitude;
}

- (void)setApparentGeocentricLongitude:(double)ApparentGeocentricLongitude
{
    _wrapped.ApparentGeocentricLongitude = ApparentGeocentricLongitude;
}

- (double)ApparentGeocentricLatitude
{
    return _wrapped.ApparentGeocentricLatitude;
}

- (void)setApparentGeocentricLatitude:(double)ApparentGeocentricLatitude
{
    _wrapped.ApparentGeocentricLatitude = ApparentGeocentricLatitude;
}

- (double)ApparentGeocentricDistance
{
    return _wrapped.ApparentGeocentricDistance;
}

- (void)setApparentGeocentricDistance:(double)ApparentGeocentricDistance
{
    _wrapped.ApparentGeocentricDistance = ApparentGeocentricDistance;
}

- (double)ApparentLightTime
{
    return _wrapped.ApparentLightTime;
}

- (void)setApparentLightTime:(double)ApparentLightTime
{
    _wrapped.ApparentLightTime = ApparentLightTime;
}

- (double)ApparentGeocentricRA
{
    return _wrapped.ApparentGeocentricRA;
}

- (void)setApparentGeocentricRA:(double)ApparentGeocentricRA
{
    _wrapped.ApparentGeocentricRA = ApparentGeocentricRA;
}

- (double)ApparentGeocentricDeclination
{
    return _wrapped.ApparentGeocentricDeclination;
}

- (void)setApparentGeocentricDeclination:(double)ApparentGeocentricDeclination
{
    _wrapped.ApparentGeocentricDeclination = ApparentGeocentricDeclination;
}

@end

@interface KPCAAEllipticalObjectDetails () {
    CAAEllipticalObjectDetails _wrapped;
}
@end

@implementation KPCAAEllipticalObjectDetails

- (instancetype)init
{
    self = [super init];
    if (self) {
        _wrapped = CAAEllipticalObjectDetails();
    }
    return self;
}

- (instancetype)initWithWrappedDetails:(CAAEllipticalObjectDetails)wrappedDetails
{
    self = [super init];
    if (self) {
        _wrapped = wrappedDetails;
    }
    return self;
}

+ (KPCAAEllipticalObjectDetails *)detailsByWrapping:(CAAEllipticalObjectDetails)wrappedDetails
{
    return [[KPCAAEllipticalObjectDetails alloc] initWithWrappedDetails:wrappedDetails];
}

- (KPCAA3DCoordinate *)HeliocentricRectangularEquatorial
{
    return [KPCAA3DCoordinate coordinateByWrapping:_wrapped.HeliocentricRectangularEquatorial];
}

- (void)setHeliocentricRectangularEquatorial:(KPCAA3DCoordinate *)HeliocentricRectangularEquatorial
{
    _wrapped.HeliocentricRectangularEquatorial = HeliocentricRectangularEquatorial.wrappedCoord;
}

- (KPCAA3DCoordinate *)HeliocentricRectangularEcliptical
{
    return [KPCAA3DCoordinate coordinateByWrapping:_wrapped.HeliocentricRectangularEcliptical];
}

- (void)setHeliocentricRectangularEcliptical:(KPCAA3DCoordinate *)HeliocentricRectangularEcliptical
{
    _wrapped.HeliocentricRectangularEcliptical = HeliocentricRectangularEcliptical.wrappedCoord;
}

- (double)HeliocentricEclipticLongitude
{
    return _wrapped.HeliocentricEclipticLongitude;
}

- (void)setHeliocentricEclipticLongitude:(double)HeliocentricEclipticLongitude
{
    _wrapped.HeliocentricEclipticLongitude = HeliocentricEclipticLongitude;
}

- (double)HeliocentricEclipticLatitude
{
    return _wrapped.HeliocentricEclipticLatitude;
}

- (void)setHeliocentricEclipticLatitude:(double)HeliocentricEclipticLatitude
{
    _wrapped.HeliocentricEclipticLatitude = HeliocentricEclipticLatitude;
}

- (double)TrueGeocentricRA
{
    return _wrapped.TrueGeocentricRA;
}

- (void)setTrueGeocentricRA:(double)TrueGeocentricRA
{
    _wrapped.TrueGeocentricRA = TrueGeocentricRA;
}

- (double)TrueGeocentricDeclination
{
    return _wrapped.TrueGeocentricDeclination;
}

- (void)setTrueGeocentricDeclination:(double)TrueGeocentricDeclination
{
    _wrapped.TrueGeocentricDeclination = TrueGeocentricDeclination;
}

- (double)TrueGeocentricDistance
{
    return _wrapped.TrueGeocentricDistance;
}

- (void)setTrueGeocentricDistance:(double)TrueGeocentricDistance
{
    _wrapped.TrueGeocentricDistance = TrueGeocentricDistance;
}

- (double)TrueGeocentricLightTime
{
    return _wrapped.TrueGeocentricLightTime;
}

- (void)setTrueGeocentricLightTime:(double)TrueGeocentricLightTime
{
    _wrapped.TrueGeocentricLightTime = TrueGeocentricLightTime;
}

- (double)AstrometricGeocentricRA
{
    return _wrapped.AstrometricGeocentricRA;
}

- (void)setAstrometricGeocentricRA:(double)AstrometricGeocentricRA
{
    _wrapped.AstrometricGeocentricRA = AstrometricGeocentricRA;
}

- (double)AstrometricGeocentricDeclination
{
    return _wrapped.AstrometricGeocentricDeclination;
}

- (void)setAstrometricGeocentricDeclination:(double)AstrometricGeocentricDeclination
{
    _wrapped.AstrometricGeocentricDeclination = AstrometricGeocentricDeclination;
}

- (double)AstrometricGeocentricDistance
{
    return _wrapped.AstrometricGeocentricDistance;
}

- (void)setAstrometricGeocentricDistance:(double)AstrometricGeocentricDistance
{
    _wrapped.AstrometricGeocentricDistance = AstrometricGeocentricDistance;
}

- (double)AstrometricGeocentricLightTime
{
    return _wrapped.AstrometricGeocentricLightTime;
}

- (void)setAstrometricGeocentricLightTime:(double)AstrometricGeocentricLightTime
{
    _wrapped.AstrometricGeocentricLightTime = AstrometricGeocentricLightTime;
}

- (double)Elongation
{
    return _wrapped.Elongation;
}

- (void)setElongation:(double)Elongation
{
    _wrapped.Elongation = Elongation;
}

- (double)PhaseAngle
{
    return _wrapped.PhaseAngle;
}

- (void)setPhaseAngle:(double)PhaseAngle
{
    _wrapped.PhaseAngle = PhaseAngle;
}

@end

@implementation KPCAAElliptical

+ (double)DistanceToLightTime:(double)Distance
{
    return CAAElliptical::DistanceToLightTime(Distance);
}

+ (KPCAAEllipticalPlanetaryDetails *)Calculate:(double)JD object:(KPCEllipticalObject)object
{
    return [KPCAAEllipticalPlanetaryDetails detailsByWrapping:CAAElliptical::Calculate(JD, (CAAElliptical::EllipticalObject)object)];
}

+ (double)SemiMajorAxisFromPerihelionDistance:(double)q e:(double)e
{
    return CAAElliptical::SemiMajorAxisFromPerihelionDistance(q, e);
}

+ (double)MeanMotionFromSemiMajorAxis:(double)a
{
    return CAAElliptical::MeanMotionFromSemiMajorAxis(a);
}

+ (KPCAAEllipticalObjectDetails *)Calculate:(double)JD elements:(KPCAAEllipticalObjectElements * __autoreleasing *)elements
{
    CAAEllipticalObjectElements wrappedElements = (*elements).wrappedElements;
    return [KPCAAEllipticalObjectDetails detailsByWrapping:CAAElliptical::Calculate(JD, wrappedElements)];
}

+ (double)InstantaneousVelocity:(double)r a:(double)a
{
    return CAAElliptical::InstantaneousVelocity(r, a);
}

+ (double)VelocityAtPerihelion:(double)e a:(double)a
{
    return CAAElliptical::VelocityAtPerihelion(e, a);
}

+ (double)VelocityAtAphelion:(double)e a:(double)a
{
    return CAAElliptical::VelocityAtAphelion(e, a);
}

+ (double)LengthOfEllipse:(double)e a:(double)a
{
    return CAAElliptical::LengthOfEllipse(e, a);
}

+ (double)CometMagnitude:(double)g delta:(double)delta  k:(double)k  r:(double)r
{
    return CAAElliptical::CometMagnitude(g, delta, k, r);
}

+ (double)MinorPlanetMagnitude:(double)H delta:(double)delta G:(double)G r:(double)r PhaseAngle:(double)PhaseAngle
{
    return CAAElliptical::MinorPlanetMagnitude(H, delta, G, r, PhaseAngle);
}

@end