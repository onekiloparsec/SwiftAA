//
//  KPCAA3DCoordinate.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 04/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import "KPCAA3DCoordinate.h"
#import "AA3DCoordinate.h"

KPCAA3DCoordinateComponents KPCAA3DCoordinateComponentsMake(double X, double Y, double Z)
{
    KPCAA3DCoordinateComponents comps;
    comps.X = X;
    comps.Y = Y;
    comps.Z = Z;
    return comps;
}

