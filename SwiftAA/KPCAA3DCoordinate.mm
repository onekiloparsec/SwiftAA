//
//  KPCAA3DCoordinate.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 04/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import "KPCAA3DCoordinate.h"

@interface KPCAA3DCoordinate () {
    CAA3DCoordinate _wrapped;
}
@end

@implementation KPCAA3DCoordinate

- (instancetype)init
{
    self = [super init];
    if (self) {
        _wrapped = CAA3DCoordinate();
    }
    return self;
}

- (instancetype)initWithWrapped:(CAA3DCoordinate)wrappedCoord
{
    self = [super init];
    if (self) {
        _wrapped = wrappedCoord;
    }
    return self;
}

+ (KPCAA3DCoordinate *)coordinateByWrapping:(CAA3DCoordinate)wrappedCoord
{
    return [[KPCAA3DCoordinate alloc] initWithWrapped:wrappedCoord];
}

- (double)X
{
    return _wrapped.X;
}

- (void)setX:(double)X
{
    _wrapped.X = X;
}

- (double)Y
{
    return _wrapped.Y;
}

- (void)setY:(double)Y
{
    _wrapped.Y = Y;
}

- (double)Z
{
    return _wrapped.Z;
}

- (void)setZ:(double)Z
{
    _wrapped.Z = Z;
}

@end
