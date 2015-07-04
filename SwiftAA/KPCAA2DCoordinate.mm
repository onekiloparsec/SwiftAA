//
//  CAA2DCoordinate.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 03/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import "KPCAA2DCoordinate.h"
#import "AA2DCoordinate.h"

@interface KPCCAA2DCoordinate () {
    CAA2DCoordinate wrapped;
}
@end

@implementation KPCCAA2DCoordinate

- (instancetype)init
{
    self = [super init];
    if (self) {
        wrapped = CAA2DCoordinate();
    }
    return self;
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
