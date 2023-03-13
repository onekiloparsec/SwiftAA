//
//  CAA2DCoordinate.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 03/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import "KPCAA2DCoordinate.h"
#import "AA2DCoordinate.h"

KPCAA2DCoordinateComponents KPCAA2DCoordinateComponentsMake(double X, double Y)
{
    KPCAA2DCoordinateComponents comps;
    comps.X = X;
    comps.Y = Y;
    return comps;
}
