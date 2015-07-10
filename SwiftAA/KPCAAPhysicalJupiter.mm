//
//  KPCAAPhysicalJupiter.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 10/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import "KPCAAPhysicalJupiter.h"
#import "AAPhysicalJupiter.h"

@interface KPCAAPhysicalJupiterDetails () {
    CAAPhysicalJupiterDetails _wrapped;
}
@end

@implementation KPCAAPhysicalJupiterDetails

- (instancetype)init
{
    self = [super init];
    if (self) {
        _wrapped = CAAPhysicalJupiterDetails();
    }
    return self;
}

- (instancetype)initWithWrappedDetails:(CAAPhysicalJupiterDetails)wrappedDetails
{
    self = [super init];
    if (self) {
        _wrapped = wrappedDetails;
    }
    return self;
}

+ (KPCAAPhysicalJupiterDetails *)detailsByWrapping:(CAAPhysicalJupiterDetails)wrappedDetails
{
    return [[KPCAAPhysicalJupiterDetails alloc] initWithWrappedDetails:wrappedDetails];
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

- (double)Geometricw1
{
    return _wrapped.Geometricw1;
}

- (void)setGeometricw1:(double)Geometricw1
{
    _wrapped.Geometricw1 = Geometricw1;
}

- (double)Geometricw2
{
    return _wrapped.Geometricw2;
}

- (void)setGeometricw2:(double)Geometricw2
{
    _wrapped.Geometricw2 = Geometricw2;
}

- (double)Apparentw1
{
    return _wrapped.Apparentw1;
}

- (void)setApparentw1:(double)Apparentw1
{
    _wrapped.Apparentw1 = Apparentw1;
}

- (double)Apparentw2
{
    return _wrapped.Apparentw2;
}

- (void)setApparentw2:(double)Apparentw2
{
    _wrapped.Apparentw2 = Apparentw2;
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

@implementation KPCAAPhysicalJupiter

+ (KPCAAPhysicalJupiterDetails *)Calculate:(double)JD
{
    return [KPCAAPhysicalJupiterDetails detailsByWrapping:CAAPhysicalJupiter::Calculate(JD)];
}

@end
