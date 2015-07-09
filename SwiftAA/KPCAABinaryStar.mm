//
//  KPCAABinaryStar.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 04/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import "KPCAABinaryStar.h"
#import "AABinaryStar.h"

@interface KPCAABinaryStarDetails () {
    CAABinaryStarDetails _wrapped;
}
@end

@implementation KPCAABinaryStarDetails

- (instancetype)init
{
    self = [super init];
    if (self) {
        _wrapped = CAABinaryStarDetails();
    }
    return self;
}

- (instancetype)initWithWrapped:(CAABinaryStarDetails)wrappedDetails
{
    self = [super init];
    if (self) {
        _wrapped = wrappedDetails;
    }
    return self;
}

+ (KPCAABinaryStarDetails *)detailsByWrapping:(CAABinaryStarDetails)wrappedDetails
{
    return [[KPCAABinaryStarDetails alloc] initWithWrapped:wrappedDetails];
}

@end

@implementation KPCAABinaryStar

+ (KPCAABinaryStarDetails *)CalculateWithTime:(double)t period:(double)P timeOfPeriastron:(double)T eccentricity:(double)e semimajorAxis:(double)a inclination:(double)i positionAngleOfAscendingNode:(double)Omega longitudeOfPeriastron:(double)w
{
    return [KPCAABinaryStarDetails detailsByWrapping:CAABinaryStar::Calculate(t, P, T, e, a, i, Omega, w)];
}

+ (double)ApparentEccentricityForEccentricity:(double)e inclination:(double)i longitudeOfPeriastron:(double)w
{
    return CAABinaryStar::ApparentEccentricity(e, i, w);
}

@end
