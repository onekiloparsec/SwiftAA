//
//  KPCAAEclipses.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 04/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import "KPCAAEclipses.h"

@interface KPCAASolarEclipseDetails () {
    CAASolarEclipseDetails _wrapped;
}
@end

@implementation KPCAASolarEclipseDetails

- (instancetype)init
{
    self = [super init];
    if (self) {
        _wrapped = CAASolarEclipseDetails();
    }
    return self;
}

- (instancetype)initWithWrappedDetails:(CAASolarEclipseDetails)wrappedDetails
{
    self = [super init];
    if (self) {
        _wrapped = wrappedDetails;
    }
    return self;
}

+ (KPCAASolarEclipseDetails *)detailsByWrapping:(CAASolarEclipseDetails)wrappedDetails
{
    return [[KPCAASolarEclipseDetails alloc] initWithWrappedDetails:wrappedDetails];
}

- (BOOL)eclipse
{
    return _wrapped.bEclipse;
}

- (void)setEclipse:(BOOL)eclipse
{
    _wrapped.bEclipse = eclipse;
}

- (double)TimeOfMaximumEclipse
{
    return _wrapped.TimeOfMaximumEclipse;
}

- (void)setTimeOfMaximumEclipse:(double)TimeOfMaximumEclipse
{
    _wrapped.TimeOfMaximumEclipse = TimeOfMaximumEclipse;
}

- (double)F
{
    return _wrapped.F;
}

- (void)setF:(double)F
{
    _wrapped.F = F;
}

- (double)u
{
    return _wrapped.u;
}

- (void)setU:(double)u
{
    _wrapped.u = u;
}

- (double)gamma
{
    return _wrapped.gamma;
}

- (void)setGamma:(double)gamma
{
    _wrapped.gamma = gamma;
}

- (double)GreatestMagnitude
{
    return _wrapped.GreatestMagnitude;
}

- (void)setGreatestMagnitude:(double)GreatestMagnitude
{
    _wrapped.GreatestMagnitude = GreatestMagnitude;
}

@end


// Lunar

@interface KPCAALunarEclipseDetails () {
    CAALunarEclipseDetails _wrapped;
}
@end

@implementation KPCAALunarEclipseDetails

- (instancetype)init
{
    self = [super init];
    if (self) {
        _wrapped = CAALunarEclipseDetails();
    }
    return self;
}

- (instancetype)initWithWrappedDetails:(CAALunarEclipseDetails)wrappedDetails
{
    self = [super init];
    if (self) {
        _wrapped = wrappedDetails;
    }
    return self;
}

+ (KPCAALunarEclipseDetails *)detailsByWrapping:(CAALunarEclipseDetails)wrappedDetails;
{
    return [[KPCAALunarEclipseDetails alloc] initWithWrappedDetails:wrappedDetails];
}

- (BOOL)eclipse
{
    return _wrapped.bEclipse;
}

- (void)setEclipse:(BOOL)eclipse
{
    _wrapped.bEclipse = eclipse;
}

- (double)TimeOfMaximumEclipse
{
    return _wrapped.TimeOfMaximumEclipse;
}

- (void)setTimeOfMaximumEclipse:(double)TimeOfMaximumEclipse
{
    _wrapped.TimeOfMaximumEclipse = TimeOfMaximumEclipse;
}

- (double)F
{
    return _wrapped.F;
}

- (void)setF:(double)F
{
    _wrapped.F = F;
}

- (double)u
{
    return _wrapped.u;
}

- (void)setU:(double)u
{
    _wrapped.u = u;
}

- (double)gamma
{
    return _wrapped.gamma;
}

- (void)setGamma:(double)gamma
{
    _wrapped.gamma = gamma;
}

- (double)PenumbralRadii
{
    return _wrapped.PenumbralRadii;
}

- (void)setPenumbralRadii:(double)PenumbralRadii
{
    _wrapped.PenumbralRadii = PenumbralRadii;
}

- (double)UmbralRadii
{
    return _wrapped.UmbralRadii;
}

- (void)setUmbralRadii:(double)UmbralRadii
{
    _wrapped.UmbralRadii = UmbralRadii;
}

- (double)PenumbralMagnitude
{
    return _wrapped.PenumbralMagnitude;
}

- (void)setPenumbralMagnitude:(double)PenumbralMagnitude
{
    _wrapped.PenumbralMagnitude = PenumbralMagnitude;
}

- (double)UmbralMagnitude
{
    return _wrapped.UmbralMagnitude;
}

- (void)setUmbralMagnitude:(double)UmbralMagnitude
{
    _wrapped.UmbralMagnitude = UmbralMagnitude;
}

- (double)PartialPhaseSemiDuration
{
    return _wrapped.PartialPhaseSemiDuration;
}

- (void)setPartialPhaseSemiDuration:(double)PartialPhaseSemiDuration
{
    _wrapped.PartialPhasePenumbraSemiDuration = PartialPhaseSemiDuration;
}

- (double)TotalPhaseSemiDuration
{
    return _wrapped.TotalPhaseSemiDuration;
}

- (void)setTotalPhaseSemiDuration:(double)TotalPhaseSemiDuration
{
    _wrapped.TotalPhaseSemiDuration = TotalPhaseSemiDuration;
}

- (double)PartialPhasePenumbraSemiDuration
{
    return _wrapped.PartialPhasePenumbraSemiDuration;
}

- (void)setPartialPhasePenumbraSemiDuration:(double)PartialPhasePenumbraSemiDuration
{
    _wrapped.PartialPhasePenumbraSemiDuration = PartialPhasePenumbraSemiDuration;
}

@end

@implementation KPCAAEclipses

+ (KPCAASolarEclipseDetails *)CalculateSolar:(double)k
{
    return [KPCAASolarEclipseDetails detailsByWrapping:CAAEclipses::CalculateSolar(k)];
}

+ (KPCAALunarEclipseDetails *)CalculateLunar:(double)k
{
    return [KPCAALunarEclipseDetails detailsByWrapping:CAAEclipses::CalculateLunar(k)];
}


@end