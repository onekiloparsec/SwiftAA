//
//  KPCAA3DCoordinate.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 04/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import <Foundation/Foundation.h>

typedef struct KPCAA3DCoordinateComponents {
    double X;
    double Y;
    double Z;
} KPCAA3DCoordinateComponents;

// Because we can't (and don't want) import C++ header in this one, one must go through the exposition of all vars.
KPCAA3DCoordinateComponents KPCAA3DCoordinateComponentsMake(double X, double Y, double Z);
