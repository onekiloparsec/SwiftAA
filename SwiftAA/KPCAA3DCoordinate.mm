//
//  KPCAA3DCoordinate.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 04/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import "KPCAA3DCoordinate.h"
#import "AA3DCoordinate.h"

KPCAA3DCoordinateComponents KPCAA3DCoordinateComponentsMake(double X, double Y, double Z)
{
    KPCAA3DCoordinateComponents comps;
    comps.X = X;
    comps.Y = Y;
    comps.Z = X;
    return comps;
}

