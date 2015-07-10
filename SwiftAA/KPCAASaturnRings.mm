//
//  KPCAASaturnRings.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 10/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import "KPCAASaturnRings.h"
#import "AASaturnRings.h"

@interface KPCAASaturnRingDetails () {
    CAASaturnRingDetails _wrapped;
}
@end

@implementation KPCAASaturnRingDetails

- (instancetype)init
{
    self = [super init];
    if (self) {
        _wrapped = CAASaturnRingDetails();
    }
    return self;
}

- (instancetype)initWithWrappedDetails:(CAASaturnRingDetails)wrappedDetails
{
    self = [super init];
    if (self) {
        _wrapped = wrappedDetails;
    }
    return self;
}

+ (KPCAASaturnRingDetails *)detailedByWrapping:(CAASaturnRingDetails)wrappedDetails
{
    return [[KPCAASaturnRingDetails alloc] initWithWrappedDetails:wrappedDetails];
}

- (double)B
{
    return _wrapped.B;
}

- (void)setB:(double)B
{
    _wrapped.B = B;
}

- (double)Bdash
{
    return _wrapped.Bdash;
}

- (void)setBdash:(double)Bdash
{
    _wrapped.Bdash = Bdash;
}

- (double)P
{
    return _wrapped.P;
}

- (void)setP:(double)P
{
    _wrapped.P = P;
}

- (double)a
{
    return _wrapped.a;
}

- (void)setA:(double)a
{
    _wrapped.a = a;
}

- (double)bb
{
    return _wrapped.b;
}

- (void)setBb:(double)bb
{
    _wrapped.b = bb;
}

- (double)DeltaU
{
    return _wrapped.DeltaU;
}

- (void)setDeltaU:(double)DeltaU
{
    _wrapped.DeltaU = DeltaU;
}

@end

@implementation KPCAASaturnRings

+ (KPCAASaturnRingDetails *)Calculate:(double)JD
{
    return [KPCAASaturnRingDetails detailedByWrapping:CAASaturnRings::Calculate(JD)];
}

@end
