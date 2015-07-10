//
//  KPCAARiseTransitSet.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 10/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import "KPCAARiseTransitSet.h"
#import "AARiseTransitSet.h"

@interface KPCAARiseTransitSetDetails () {
    CAARiseTransitSetDetails _wrapped;
}
@end

@implementation KPCAARiseTransitSetDetails

- (instancetype)init
{
    self = [super init];
    if (self) {
        _wrapped = CAARiseTransitSetDetails();
    }
    return self;
}

- (instancetype)initWithWrappedDetails:(CAARiseTransitSetDetails)wrappedDetails
{
    self = [super init];
    if (self) {
        _wrapped = wrappedDetails;
    }
    return self;
}

+ (KPCAARiseTransitSetDetails *)detailedByWrapping:(CAARiseTransitSetDetails)wrappedDetails
{
    return [[KPCAARiseTransitSetDetails alloc] initWithWrappedDetails:wrappedDetails];
}

- (BOOL)isRiseValid
{
    return (BOOL)_wrapped.bRiseValid;
}

- (void)setIsRiseValid:(BOOL)isRiseValid
{
    _wrapped.bRiseValid = isRiseValid;
}

- (double)Rise
{
    return _wrapped.Rise;
}

- (void)setRise:(double)Rise
{
    _wrapped.Rise = Rise;
}

- (BOOL)isTransitAboveHorizon
{
    return (BOOL)_wrapped.bTransitAboveHorizon;
}

- (void)setIsTransitAboveHorizon:(BOOL)isTransitAboveHorizon
{
    _wrapped.bTransitAboveHorizon = isTransitAboveHorizon;
}

- (double)Transit
{
    return _wrapped.Transit;
}

- (void)setTransit:(double)Transit
{
    _wrapped.Transit = Transit;
}

- (BOOL)isSetValid
{
    return (BOOL)_wrapped.bSetValid;
}

- (void)setIsSetValid:(BOOL)isSetValid
{
    _wrapped.bSetValid = isSetValid;
}

- (double)Set
{
    return _wrapped.Set;
}

- (void)setSet:(double)Set
{
    _wrapped.Set = Set;
}

@end

@implementation KPCAARiseTransitSet

+ (KPCAARiseTransitSetDetails *)Calculate:(double)JD Alpha1:(double)Alpha1 Delta1:(double)Delta1 Alpha2:(double)Alpha2 Delta2:(double)Delta2 Alpha3:(double)Alpha3 Delta3:(double)Delta3 Longitude:(double)Longitude Latitude:(double)Latitude h0:(double)h0
{
    return [KPCAARiseTransitSetDetails detailedByWrapping:CAARiseTransitSet::Calculate(JD, Alpha1, Delta1, Alpha2, Delta2, Alpha3, Delta3, Longitude, Latitude, h0)];
}

@end