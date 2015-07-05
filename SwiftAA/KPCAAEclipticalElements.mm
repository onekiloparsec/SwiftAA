//
//  KPCAAEclipticalElements.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 05/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import "KPCAAEclipticalElements.h"

@interface KPCAAEclipticalElementDetails () {
    CAAEclipticalElementDetails _wrapped;
}
@end

@implementation KPCAAEclipticalElementDetails

- (instancetype)init
{
    self = [super init];
    if (self) {
        _wrapped = CAAEclipticalElementDetails();
    }
    return self;
}

- (instancetype)initWithWrappedDetails:(CAAEclipticalElementDetails)wrappedDetails
{
    self = [super init];
    if (self) {
        _wrapped = wrappedDetails;
    }
    return self;
}

+ (KPCAAEclipticalElementDetails *)detailsByWrapping:(CAAEclipticalElementDetails)wrappedDetails
{
    return [[KPCAAEclipticalElementDetails alloc] initWithWrappedDetails:wrappedDetails];
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

@end

@implementation KPCAAEclipticalElements

+ (KPCAAEclipticalElementDetails *)CalculateForI0:(double)i0 w0:(double)w0 omega0:(double)omega0 JD0:(double)JD0 JD:(double)JD
{
    return [KPCAAEclipticalElementDetails detailsByWrapping:CAAEclipticalElements::Calculate(i0, w0, omega0, JD0, JD)];
}

+ (KPCAAEclipticalElementDetails *)FK4B1950ToFK5J2000ForI0:(double)i0 w0:(double)w0 omega0:(double)omega0
{
    return [KPCAAEclipticalElementDetails detailsByWrapping:CAAEclipticalElements::FK4B1950ToFK5J2000(i0, w0, omega0)];
}

@end