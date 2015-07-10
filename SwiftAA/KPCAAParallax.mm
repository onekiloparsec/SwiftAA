//
//  KPCAAParallax.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 09/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import "KPCAAParallax.h"
#import "AAParallax.h"

@interface KPCAATopocentricEclipticDetails () {
    CAATopocentricEclipticDetails _wrapped;
}
@end

@implementation KPCAATopocentricEclipticDetails

- (instancetype)init
{
    self = [super init];
    if (self) {
        _wrapped = CAATopocentricEclipticDetails();
    }
    return self;
}

- (instancetype)initWithWrappedDetails:(CAATopocentricEclipticDetails)wrappedDetails
{
    self = [super init];
    if (self) {
        _wrapped = wrappedDetails;
    }
    return self;
}

+ (KPCAATopocentricEclipticDetails *)detailsByWrapping:(CAATopocentricEclipticDetails)wrappedDetails
{
    return [[KPCAATopocentricEclipticDetails alloc] initWithWrappedDetails:wrappedDetails];
}

- (double)Lambda
{
    return _wrapped.Lambda;
}

- (void)setLambda:(double)Lambda
{
    _wrapped.Lambda = Lambda;
}

- (double)Beta
{
    return _wrapped.Beta;
}

- (void)setBeta:(double)Beta
{
    _wrapped.Beta = Beta;
}

- (double)Semidiameter
{
    return _wrapped.Semidiameter;
}

- (void)setSemidiameter:(double)Semidiameter
{
    _wrapped.Semidiameter = Semidiameter;
}

@end


@implementation KPCAAParallax

+ (KPCAA2DCoordinate *)Equatorial2TopocentricDelta:(double)Alpha Delta:(double)Delta Distance:(double)Distance Longitude:(double)Longitude Latitude:(double)Latitude Height:(double)Height JD:(double)JD
{
    return [KPCAA2DCoordinate coordinateByWrapping:CAAParallax::Equatorial2TopocentricDelta(Alpha, Delta, Distance, Longitude, Latitude, Height, JD)];
}

+ (KPCAA2DCoordinate *)Equatorial2Topocentric:(double)Alpha Delta:(double)Delta Distance:(double)Distance Longitude:(double)Longitude Latitude:(double)Latitude Height:(double)Height JD:(double)JD
{
    return [KPCAA2DCoordinate coordinateByWrapping:CAAParallax::Equatorial2Topocentric(Alpha, Delta, Distance, Longitude, Latitude, Height, JD)];
}

+ (KPCAATopocentricEclipticDetails *)Ecliptic2Topocentric:(double)Lambda Beta:(double)Beta  Semidiameter:(double)Semidiameter Distance:(double)Distance Epsilon:(double)Epsilon Latitude:(double)Latitude Height:(double)Height JD:(double)JD
{
    return [KPCAATopocentricEclipticDetails detailsByWrapping:CAAParallax::Ecliptic2Topocentric(Lambda, Beta, Semidiameter, Distance, Epsilon, Latitude, Height, JD)];
}

+ (double)ParallaxToDistance:(double)Parallax
{
    return CAAParallax::ParallaxToDistance(Parallax);
}

+ (double)DistanceToParallax:(double)Distance
{
    return CAAParallax::DistanceToParallax(Distance);
}

@end