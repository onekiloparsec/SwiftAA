//
//  KPCAANearParabolic.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 09/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import "KPCAANearParabolic.h"

@interface KPCAANearParabolicObjectElements () {
    CAANearParabolicObjectElements _wrapped;
}
- (CAANearParabolicObjectElements)wrappedElements;
@end

@implementation KPCAANearParabolicObjectElements

- (instancetype)init
{
    self = [super init];
    if (self) {
        _wrapped = CAANearParabolicObjectElements();
    }
    return self;
}

- (instancetype)initWithWrappedElements:(CAANearParabolicObjectElements)wrappedElements
{
    self = [super init];
    if (self) {
        _wrapped = wrappedElements;
    }
    return self;
}

+ (KPCAANearParabolicObjectElements *)elementsByWrapping:(CAANearParabolicObjectElements)wrappedElements
{
    return [[KPCAANearParabolicObjectElements alloc] initWithWrappedElements:wrappedElements];
}

- (CAANearParabolicObjectElements)wrappedElements
{
    return _wrapped;
}

- (double)q
{
    return _wrapped.q;
}

- (void)setQ:(double)q
{
    _wrapped.q = q;
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

- (double)e
{
    return _wrapped.e;
}

- (void)setE:(double)e
{
    _wrapped.e = e;
}

@end


@interface KPCAANearParabolicObjectDetails () {
    CAANearParabolicObjectDetails _wrapped;
}
@end

@implementation KPCAANearParabolicObjectDetails

- (instancetype)init
{
    self = [super init];
    if (self) {
        _wrapped = CAANearParabolicObjectDetails();
    }
    return self;
}

- (instancetype)initWithWrappedDetails:(CAANearParabolicObjectDetails)wrappedDetails
{
    self = [super init];
    if (self) {
        _wrapped = wrappedDetails;
    }
    return self;
}

+ (KPCAANearParabolicObjectDetails *)detailsByWrapping:(CAANearParabolicObjectDetails)wrappedDetails
{
    return [[KPCAANearParabolicObjectDetails alloc] initWithWrappedDetails:wrappedDetails];
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



@implementation KPCAANearParabolic

+ (KPCAANearParabolicObjectDetails *)Calculate:(double)JD elements:(CAANearParabolicObjectElements&) elements
{
    return [KPCAANearParabolicObjectDetails detailsByWrapping:CAANearParabolic::Calculate(JD, elements)];
}

+ (double)cbrt:(double)x
{
    return CAANearParabolic::cbrt(x);
}

+ (void)CalulateTrueAnnomalyAndRadius:(double)JD elements:(CAANearParabolicObjectElements&)elements v:(double&)v r:(double&)r
{
    return CAANearParabolic::CalulateTrueAnnomalyAndRadius(JD, elements, v, r);
}

@end
