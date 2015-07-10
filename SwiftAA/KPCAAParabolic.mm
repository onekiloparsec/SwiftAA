//
//  KPCAAParabolic.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 09/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import "KPCAAParabolic.h"
#import "AAParabolic.h"

@interface KPCAA3DCoordinate ()
+ (KPCAA3DCoordinate *)coordinateByWrapping:(CAA3DCoordinate)wrappedCoord;
- (CAA3DCoordinate)wrappedCoord;
@end


@interface KPCAAParabolicObjectElements () {
    CAAParabolicObjectElements _wrapped;
}
- (CAAParabolicObjectElements)wrappedElements;
@end

@implementation KPCAAParabolicObjectElements

- (instancetype)init
{
    self = [super init];
    if (self) {
        _wrapped = CAAParabolicObjectElements();
    }
    return self;
}

- (instancetype)initWithWrappedElements:(CAAParabolicObjectElements)wrappedElements
{
    self = [super init];
    if (self) {
        _wrapped = wrappedElements;
    }
    return self;
}

+ (KPCAAParabolicObjectElements *)elementsByWrapping:(CAAParabolicObjectElements)wrappedElements
{
    return [[KPCAAParabolicObjectElements alloc] initWithWrappedElements:wrappedElements];
}

- (CAAParabolicObjectElements)wrappedElements
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

@end



@interface KPCAAParabolicObjectDetails () {
    CAAParabolicObjectDetails _wrapped;
}
@end

@implementation KPCAAParabolicObjectDetails

- (instancetype)init
{
    self = [super init];
    if (self) {
        _wrapped = CAAParabolicObjectDetails();
    }
    return self;
}

- (instancetype)initWithWrappedDetails:(CAAParabolicObjectDetails)wrappedDetails
{
    self = [super init];
    if (self) {
        _wrapped = wrappedDetails;
    }
    return self;
}

+ (KPCAAParabolicObjectDetails *)detailsByWrapping:(CAAParabolicObjectDetails)wrappedDetails
{
    return [[KPCAAParabolicObjectDetails alloc] initWithWrappedDetails:wrappedDetails];
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
    return _wrapped.AstrometricGeocenticRA;
}

- (void)setAstrometricGeocentricRA:(double)AstrometricGeocentricRA
{
    _wrapped.AstrometricGeocenticRA = AstrometricGeocentricRA;
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




@implementation KPCAAParabolic

+ (double)CalculateBarkers:(double)W
{
    return CAAParabolic::CalculateBarkers(W);
}

+ (KPCAAParabolicObjectDetails *)Calculate:(double)JD elements:(KPCAAParabolicObjectElements *)elements
{
    return [KPCAAParabolicObjectDetails detailsByWrapping:CAAParabolic::Calculate(JD, elements.wrappedElements)];
}

@end
