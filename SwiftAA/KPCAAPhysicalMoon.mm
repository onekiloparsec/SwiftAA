//
//  KPCAAPhysicalMoon.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 10/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import "KPCAAPhysicalMoon.h"
#import "AAPhysicalMoon.h"

@interface KPCAAPhysicalMoonDetails () {
    CAAPhysicalMoonDetails _wrapped;
}
@end

@implementation KPCAAPhysicalMoonDetails

- (instancetype)init
{
    self = [super init];
    if (self) {
        _wrapped = CAAPhysicalMoonDetails();
    }
    return self;
}

- (instancetype)initWithWrappedDetails:(CAAPhysicalMoonDetails)wrappedDetails
{
    self = [super init];
    if (self) {
        _wrapped = wrappedDetails;
    }
    return self;
}

+ (KPCAAPhysicalMoonDetails *)detailsByWrapping:(CAAPhysicalMoonDetails)wrappedDetails
{
    return [[KPCAAPhysicalMoonDetails alloc] initWithWrappedDetails:wrappedDetails];
}

- (double)ldash
{
    return _wrapped.ldash;
}

- (void)setLdash:(double)ldash
{
    _wrapped.ldash = ldash;
}

- (double)bdash
{
    return _wrapped.bdash;
}

- (void)setBdash:(double)bdash
{
    _wrapped.bdash = bdash;
}

- (double)ldash2
{
    return _wrapped.ldash2;
}

- (void)setLdash2:(double)ldash2
{
    _wrapped.ldash2 = ldash2;
}

- (double)bdash2
{
    return _wrapped.bdash2;
}

- (void)setBdash2:(double)bdash2
{
    _wrapped.bdash2 = bdash2;
}

- (double)l
{
    return _wrapped.l;
}

- (void)setL:(double)l
{
    _wrapped.l = l;
}

- (double)b
{
    return _wrapped.b;
}

- (void)setB:(double)b
{
    _wrapped.b = b;
}

- (double)P
{
    return _wrapped.P;
}

- (void)setP:(double)P
{
    _wrapped.P = P;
}

@end


@interface KPCAASelenographicMoonDetails () {
    CAASelenographicMoonDetails _wrapped;
}
@end

@implementation KPCAASelenographicMoonDetails

- (instancetype)init
{
    self = [super init];
    if (self) {
        _wrapped = CAASelenographicMoonDetails();
    }
    return self;
}

- (instancetype)initWithWrappedDetails:(CAASelenographicMoonDetails)wrappedDetails
{
    self = [super init];
    if (self) {
        _wrapped = wrappedDetails;
    }
    return self;
}

+ (KPCAASelenographicMoonDetails *)detailsByWrapping:(CAASelenographicMoonDetails)wrappedDetails
{
    return [[KPCAASelenographicMoonDetails alloc] initWithWrappedDetails:wrappedDetails];
}

- (double)l0
{
    return _wrapped.l0;
}

- (void)setL0:(double)l0
{
    _wrapped.l0 = l0;
}

- (double)b0
{
    return _wrapped.b0;
}

- (void)setB0:(double)b0
{
    _wrapped.b0 = b0;
}

- (double)c0
{
    return _wrapped.c0;
}

- (void)setC0:(double)c0
{
    _wrapped.c0 = c0;
}

@end


@implementation KPCAAPhysicalMoon

+ (KPCAAPhysicalMoonDetails *)CalculateGeocentric:(double)JD
{
    return [KPCAAPhysicalMoonDetails detailsByWrapping:CAAPhysicalMoon::CalculateGeocentric(JD)];
}

+ (KPCAAPhysicalMoonDetails *)CalculateTopocentric:(double)JD Longitude:(double)Longitude Latitude:(double)Latitude
{
    return [KPCAAPhysicalMoonDetails detailsByWrapping:CAAPhysicalMoon::CalculateTopocentric(JD, Longitude, Latitude)];
}

+ (KPCAASelenographicMoonDetails *)CalculateSelenographicPositionOfSun:(double)JD
{
    return [KPCAASelenographicMoonDetails detailsByWrapping:CAAPhysicalMoon::CalculateSelenographicPositionOfSun(JD)];
}

+ (double)AltitudeOfSun:(double)JD Longitude:(double)Longitude Latitude:(double)Latitude
{
    return CAAPhysicalMoon::AltitudeOfSun(JD, Longitude, Latitude);
}

+ (double)TimeOfSunrise:(double)JD Longitude:(double)Longitude Latitude:(double)Latitude
{
    return CAAPhysicalMoon::TimeOfSunrise(JD, Longitude, Latitude);
}

+ (double)TimeOfSunset:(double)JD Longitude:(double)Longitude Latitude:(double)Latitude
{
    return CAAPhysicalMoon::TimeOfSunset(JD, Longitude, Latitude);
}

@end
