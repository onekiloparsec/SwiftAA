//
//  CAA2DCoordinate.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 03/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KPCAA2DCoordinate : NSObject

@property(nonatomic, assign) double X;
@property(nonatomic, assign) double Y;

@end

typedef struct KPCAA2DCoordinateComponents {
    double X;
    double Y;
} KPCAA2DCoordinateComponents;

KPCAA2DCoordinateComponents KPCAA2DCoordinateComponentsMake(double X, double Y);
