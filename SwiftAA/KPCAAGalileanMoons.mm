//
//  KPCAAGalileanMoons.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 08/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import "KPCAAGalileanMoons.h"
#import "AAGalileanMoons.h"

@interface KPCAA3DCoordinate ()
+ (KPCAA3DCoordinate *)coordinateByWrapping:(CAA3DCoordinate)wrappedCoord;
- (CAA3DCoordinate)wrappedCoord;
@end

@interface KPCAAGalileanMoonDetail () {
    CAAGalileanMoonDetail _wrapped;
}
- (CAAGalileanMoonDetail)wrappedDetail;
@end

@implementation KPCAAGalileanMoonDetail

- (instancetype)init
{
    self = [super init];
    if (self) {
        _wrapped = CAAGalileanMoonDetail();
    }
    return self;
}

- (instancetype)initWithWrappedDetail:(CAAGalileanMoonDetail)wrappedDetail
{
    self = [super init];
    if (self) {
        _wrapped = wrappedDetail;
    }
    return self;
}

+ (KPCAAGalileanMoonDetail *)detailByWrapping:(CAAGalileanMoonDetail)wrappedDetail
{
    return [[KPCAAGalileanMoonDetail alloc] initWithWrappedDetail:wrappedDetail];
}

- (CAAGalileanMoonDetail)wrappedDetail
{
    return _wrapped;
}

- (double)MeanLongitude
{
    return _wrapped.MeanLongitude;
}

- (void)setMeanLongitude:(double)MeanLongitude
{
    _wrapped.MeanLongitude = MeanLongitude;
}

- (double)TrueLongitude
{
    return _wrapped.TrueLongitude;
}

- (void)setTrueLongitude:(double)TrueLongitude
{
    _wrapped.TrueLongitude = TrueLongitude;
}

- (double)TropicalLongitude
{
    return _wrapped.TropicalLongitude;
}

- (void)setTropicalLongitude:(double)TropicalLongitude
{
    _wrapped.TropicalLongitude = TropicalLongitude;
}

- (double)EquatorialLatitude
{
    return _wrapped.EquatorialLatitude;
}

- (void)setEquatorialLatitude:(double)EquatorialLatitude
{
    _wrapped.EquatorialLatitude = EquatorialLatitude;
}

- (double)r
{
    return _wrapped.r;
}

- (void)setR:(double)r
{
    _wrapped.r = r;
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

- (BOOL)inTransit
{
    return (BOOL)_wrapped.bInTransit;
}

- (void)setInTransit:(BOOL)inTransit
{
    _wrapped.bInTransit = (bool)inTransit;
}

- (BOOL)inOccultation
{
    return (BOOL)_wrapped.bInOccultation;
}

- (void)setInOccultation:(BOOL)inOccultation
{
    _wrapped.bInOccultation = (bool)inOccultation;
}

- (BOOL)inEclipse
{
    return (BOOL)_wrapped.bInEclipse;
}

- (void)setInEclipse:(BOOL)inEclipse
{
    _wrapped.bInEclipse = (bool)inEclipse;
}

- (BOOL)inShadowTransit
{
    return (BOOL)_wrapped.bInShadowTransit;
}

- (void)setInShadowTransit:(BOOL)inShadowTransit
{
    _wrapped.bInShadowTransit = (bool)inShadowTransit;
}

@end

@interface KPCAAGalileanMoonsDetails () {
    CAAGalileanMoonsDetails _wrapped;
}
@end

@implementation KPCAAGalileanMoonsDetails

- (instancetype)init
{
    self = [super init];
    if (self) {
        _wrapped = CAAGalileanMoonsDetails();
    }
    return self;
}

- (instancetype)initWithWrappedDetails:(CAAGalileanMoonsDetails)wrappedDetails
{
    self = [super init];
    if (self) {
        _wrapped = wrappedDetails;
    }
    return self;
}

+ (KPCAAGalileanMoonsDetails *)detailsByWrapping:(CAAGalileanMoonsDetails)wrappedDetails
{
    return [[KPCAAGalileanMoonsDetails alloc] initWithWrappedDetails:wrappedDetails];
}

- (KPCAAGalileanMoonDetail *)Satellite1
{
    return [KPCAAGalileanMoonDetail detailByWrapping:_wrapped.Satellite1];
}

- (void)setSatellite1:(KPCAAGalileanMoonDetail *)Satellite1
{
    _wrapped.Satellite1 = Satellite1.wrappedDetail;
}

- (KPCAAGalileanMoonDetail *)Satellite2
{
    return [KPCAAGalileanMoonDetail detailByWrapping:_wrapped.Satellite2];
}

- (void)setSatellite2:(KPCAAGalileanMoonDetail *)Satellite2
{
    _wrapped.Satellite1 = Satellite2.wrappedDetail;
}

- (KPCAAGalileanMoonDetail *)Satellite3
{
    return [KPCAAGalileanMoonDetail detailByWrapping:_wrapped.Satellite3];
}

- (void)setSatellite3:(KPCAAGalileanMoonDetail *)Satellite3
{
    _wrapped.Satellite1 = Satellite3.wrappedDetail;
}

- (KPCAAGalileanMoonDetail *)Satellite4
{
    return [KPCAAGalileanMoonDetail detailByWrapping:_wrapped.Satellite4];
}

- (void)setSatellite4:(KPCAAGalileanMoonDetail *)Satellite4
{
    _wrapped.Satellite1 = Satellite4.wrappedDetail;
}

@end

@implementation KPCAAGalileanMoons

+ (KPCAAGalileanMoonsDetails *)Calculate:(double)JD
{
    return [KPCAAGalileanMoonsDetails detailsByWrapping:CAAGalileanMoons::Calculate(JD)];
}

@end