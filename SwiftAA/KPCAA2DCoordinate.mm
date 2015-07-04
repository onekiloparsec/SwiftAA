//
//  CAA2DCoordinate.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 03/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import "KPCAA2DCoordinate.h"

@interface KPCAA2DCoordinate () {
    CAA2DCoordinate wrapped;
}
@end

@implementation KPCAA2DCoordinate

- (instancetype)init
{
    self = [super init];
    if (self) {
        wrapped = CAA2DCoordinate();
    }
    return self;
}

- (instancetype)initWithWrapped:(CAA2DCoordinate)wrappedCoord
{
    self = [super init];
    if (self) {
        wrapped = wrappedCoord;
    }
    return self;
}

+ (KPCAA2DCoordinate *)coordinateByWrapping:(CAA2DCoordinate)wrappedCoord
{
    return [[KPCAA2DCoordinate alloc] initWithWrapped:wrappedCoord];
}

- (double)X
{
    return wrapped.X;
}

- (void)setX:(double)X
{
    wrapped.X = X;
}

- (double)Y
{
    return wrapped.Y;
}

- (void)setY:(double)Y
{
    wrapped.Y = Y;
}

@end
