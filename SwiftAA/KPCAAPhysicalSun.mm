//
//  KPCAAPhysicalSun.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 10/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import "KPCAAPhysicalSun.h"
#import "AAPhysicalSun.h"

@interface KPCAAPhysicalSunDetails () {
    CAAPhysicalSunDetails _wrapped;
}
@end

@implementation KPCAAPhysicalSunDetails

- (instancetype)init
{
    self = [super init];
    if (self) {
        _wrapped = CAAPhysicalSunDetails();
    }
    return self;
}

- (instancetype)initWithWrappedDetails:(CAAPhysicalSunDetails)wrappedDetails
{
    self = [super init];
    if (self) {
        _wrapped = wrappedDetails;
    }
    return self;
}

+ (KPCAAPhysicalSunDetails *)detailsByWrapping:(CAAPhysicalSunDetails)wrappedDetails
{
    return [[KPCAAPhysicalSunDetails alloc] initWithWrappedDetails:wrappedDetails];
}

- (double)P
{
    return _wrapped.P;
}

- (void)setP:(double)P
{
    _wrapped.P = P;
}

- (double)B0
{
    return _wrapped.B0;
}

- (void)setB0:(double)B0
{
    _wrapped.B0 = B0;
}

- (double)L0
{
    return _wrapped.L0;
}

- (void)setL0:(double)L0
{
    _wrapped.L0 = L0;
}

@end

@implementation KPCAAPhysicalSun

+ (KPCAAPhysicalSunDetails *)Calculate:(double)JD
{
    return [KPCAAPhysicalSunDetails detailsByWrapping:CAAPhysicalSun::Calculate(JD)];
}

+ (double)TimeOfStartOfRotation:(long)C
{
    return CAAPhysicalSun::TimeOfStartOfRotation(C);
}

@end
