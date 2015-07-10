//
//  KPCPhysicalMars.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 10/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import "KPCPhysicalMars.h"
#import "AAPhysicalMars.h"

@interface KPCAAPhysicalMarsDetails () {
    CAAPhysicalMarsDetails _wrapped;
}
@end

@implementation KPCAAPhysicalMarsDetails

- (instancetype)init
{
    self = [super init];
    if (self) {
        _wrapped = CAAPhysicalMarsDetails();
    }
    return self;
}

- (instancetype)initWithWrappedDetails:(CAAPhysicalMarsDetails)wrappedDetails
{
    self = [super init];
    if (self) {
        _wrapped = wrappedDetails;
    }
    return self;
}

+ (KPCAAPhysicalMarsDetails *)detailsByWrapping:(CAAPhysicalMarsDetails)wrappedDetails
{
    return [[KPCAAPhysicalMarsDetails alloc] initWithWrappedDetails:wrappedDetails];
}

- (double)DE
{
    return _wrapped.DE;
}

- (void)setDE:(double)DE
{
    _wrapped.DE = DE;
}

- (double)DS
{
    return _wrapped.DS;
}

- (void)setDS:(double)DS
{
    _wrapped.DS = DS;
}

- (double)w
{
    return _wrapped.w;
}

- (void)setW:(double)w
{
    _wrapped.w = w;
}

- (double)P
{
    return _wrapped.P;
}

- (void)setP:(double)P
{
    _wrapped.P = P;
}

- (double)X
{
    return _wrapped.X;
}

- (void)setX:(double)X
{
    _wrapped.X = X;
}

- (double)k
{
    return _wrapped.k;
}

- (void)setK:(double)k
{
    _wrapped.k = k;
}

- (double)q
{
    return _wrapped.q;
}

- (void)setQ:(double)q
{
    _wrapped.q = q;
}

- (double)d
{
    return _wrapped.d;
}

- (void)setD:(double)d
{
    _wrapped.d = d;
}

@end

@implementation KPCPhysicalMars

+ (KPCAAPhysicalMarsDetails *)Calculate:(double)JD
{
    return [KPCAAPhysicalMarsDetails detailsByWrapping:CAAPhysicalMars::Calculate(JD)];
}

@end
