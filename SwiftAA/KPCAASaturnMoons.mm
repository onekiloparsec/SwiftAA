//
//  KPCAASaturnMoons.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 10/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import "KPCAASaturnMoons.h"
#import "AASaturnMoons.h"

@interface KPCAA3DCoordinate ()
+ (KPCAA3DCoordinate *)coordinateByWrapping:(CAA3DCoordinate)wrappedCoord;
- (CAA3DCoordinate)wrappedCoord;
@end

@interface KPCAASaturnMoonDetail () {
    CAASaturnMoonDetail _wrapped;
}
@end

@implementation KPCAASaturnMoonDetail

- (instancetype)init
{
    self = [super init];
    if (self) {
        _wrapped = CAASaturnMoonDetail();
    }
    return self;
}

- (instancetype)initWithWrappedDetails:(CAASaturnMoonDetail)wrappedDetails
{
    self = [super init];
    if (self) {
        _wrapped = wrappedDetails;
    }
    return self;
}

+ (KPCAASaturnMoonDetail *)detailedByWrapping:(CAASaturnMoonDetail)wrappedDetails
{
    return [[KPCAASaturnMoonDetail alloc] initWithWrappedDetails:wrappedDetails];
}

- (CAASaturnMoonDetail)wrappedDetail
{
    return _wrapped;
}

- (KPCAA3DCoordinate *)TrueRectangularCoordinates
{
    return [KPCAA3DCoordinate coordinateByWrapping:_wrapped.TrueRectangularCoordinates];
}

- (void)setTrueRectangularCoordinates:(KPCAA3DCoordinate *)TrueRectangularCoordinates
{
    _wrapped.TrueRectangularCoordinates = TrueRectangularCoordinates.wrappedCoord;
}

- (KPCAA3DCoordinate *)ApparentRectangularCoordinates
{
    return [KPCAA3DCoordinate coordinateByWrapping:_wrapped.ApparentRectangularCoordinates];
}

- (void)setApparentRectangularCoordinates:(KPCAA3DCoordinate *)ApparentRectangularCoordinates
{
    _wrapped.ApparentRectangularCoordinates = ApparentRectangularCoordinates.wrappedCoord;
}

- (BOOL)isInTransit
{
    return (BOOL)_wrapped.bInTransit;
}

- (void)setIsInTransit:(BOOL)isInTransit
{
    _wrapped.bInTransit = isInTransit;
}

- (BOOL)isInOccultation
{
    return (BOOL)_wrapped.bInTransit;
}

- (void)setIsInOccultation:(BOOL)isInOccultation
{
    _wrapped.bInOccultation = isInOccultation;
}

- (BOOL)isInEclipse
{
    return (BOOL)_wrapped.bInEclipse;
}

- (void)setIsInEclipse:(BOOL)isInEclipse
{
    _wrapped.bInEclipse = isInEclipse;
}

- (BOOL)isInShadowTransit
{
    return (BOOL)_wrapped.bInShadowTransit;
}

- (void)setIsInShadowTransit:(BOOL)isInShadowTransit
{
    _wrapped.bInShadowTransit = isInShadowTransit;
}

@end


@interface KPCAASaturnMoonsDetails () {
    CAASaturnMoonsDetails _wrapped;
}
@end

@implementation KPCAASaturnMoonsDetails

- (instancetype)init
{
    self = [super init];
    if (self) {
        _wrapped = CAASaturnMoonsDetails();
    }
    return self;
}

- (instancetype)initWithWrappedDetails:(CAASaturnMoonsDetails)wrappedDetails
{
    self = [super init];
    if (self) {
        _wrapped = wrappedDetails;
    }
    return self;
}

+ (KPCAASaturnMoonsDetails *)detailedByWrapping:(CAASaturnMoonsDetails)wrappedDetails
{
    return [[KPCAASaturnMoonsDetails alloc] initWithWrappedDetails:wrappedDetails];
}

- (KPCAASaturnMoonDetail *)Satellite1
{
    return [KPCAASaturnMoonDetail detailedByWrapping:_wrapped.Satellite1];
}

- (void)setSatellite1:(KPCAASaturnMoonDetail *)Satellite1
{
    _wrapped.Satellite1 = Satellite1.wrappedDetail;
}

- (KPCAASaturnMoonDetail *)Satellite2
{
    return [KPCAASaturnMoonDetail detailedByWrapping:_wrapped.Satellite2];
}

- (void)setSatellite2:(KPCAASaturnMoonDetail *)Satellite2
{
    _wrapped.Satellite2 = Satellite2.wrappedDetail;
}

- (KPCAASaturnMoonDetail *)Satellite3
{
    return [KPCAASaturnMoonDetail detailedByWrapping:_wrapped.Satellite3];
}

- (void)setSatellite3:(KPCAASaturnMoonDetail *)Satellite3
{
    _wrapped.Satellite3 = Satellite3.wrappedDetail;
}

- (KPCAASaturnMoonDetail *)Satellite4
{
    return [KPCAASaturnMoonDetail detailedByWrapping:_wrapped.Satellite4];
}

- (void)setSatellite4:(KPCAASaturnMoonDetail *)Satellite4
{
    _wrapped.Satellite4 = Satellite4.wrappedDetail;
}

- (KPCAASaturnMoonDetail *)Satellite5
{
    return [KPCAASaturnMoonDetail detailedByWrapping:_wrapped.Satellite5];
}

- (void)setSatellite5:(KPCAASaturnMoonDetail *)Satellite5
{
    _wrapped.Satellite5 = Satellite5.wrappedDetail;
}

- (KPCAASaturnMoonDetail *)Satellite6
{
    return [KPCAASaturnMoonDetail detailedByWrapping:_wrapped.Satellite6];
}

- (void)setSatellite6:(KPCAASaturnMoonDetail *)Satellite6
{
    _wrapped.Satellite6 = Satellite6.wrappedDetail;
}

- (KPCAASaturnMoonDetail *)Satellite7
{
    return [KPCAASaturnMoonDetail detailedByWrapping:_wrapped.Satellite7];
}

- (void)setSatellite7:(KPCAASaturnMoonDetail *)Satellite7
{
    _wrapped.Satellite7 = Satellite7.wrappedDetail;
}

- (KPCAASaturnMoonDetail *)Satellite8
{
    return [KPCAASaturnMoonDetail detailedByWrapping:_wrapped.Satellite8];
}

- (void)setSatellite8:(KPCAASaturnMoonDetail *)Satellite8
{
    _wrapped.Satellite8 = Satellite8.wrappedDetail;
}

@end


@implementation KPCAASaturnMoons

+ (KPCAASaturnMoonsDetails *)Calculate:(double)JD
{
    return [KPCAASaturnMoonsDetails detailedByWrapping:CAASaturnMoons::Calculate(JD)];
}

@end
