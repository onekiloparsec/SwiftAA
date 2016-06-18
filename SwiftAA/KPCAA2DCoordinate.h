//
//  CAA2DCoordinate.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 03/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import <Foundation/Foundation.h>

#ifdef __cplusplus
extern "C" {
#endif

typedef struct KPCAA2DCoordinateComponents {
    double X;
    double Y;
} KPCAA2DCoordinateComponents;

// Because we can't (and don't want) import C++ header in this one, one must go through the exposition of all vars.
KPCAA2DCoordinateComponents KPCAA2DCoordinateComponentsMake(double X, double Y);

#if __cplusplus
}
#endif
