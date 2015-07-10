//
//  KPCAASun.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 10/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KPCAA3DCoordinate.h"

@interface KPCAASun : NSObject

+ (double)GeometricEclipticLongitude:(double)JD;
+ (double)GeometricEclipticLatitude:(double)JD;
+ (double)GeometricEclipticLongitudeJ2000:(double)JD;
+ (double)GeometricEclipticLatitudeJ2000:(double)JD;
+ (double)GeometricFK5EclipticLongitude:(double)JD;
+ (double)GeometricFK5EclipticLatitude:(double)JD;
+ (double)ApparentEclipticLongitude:(double)JD;
+ (double)ApparentEclipticLatitude:(double)JD;
+ (KPCAA3DCoordinate *)EquatorialRectangularCoordinatesMeanEquinox:(double)JD;
+ (KPCAA3DCoordinate *)EclipticRectangularCoordinatesJ2000:(double)JD;
+ (KPCAA3DCoordinate *)EquatorialRectangularCoordinatesJ2000:(double)JD;
+ (KPCAA3DCoordinate *)EquatorialRectangularCoordinatesB1950:(double)JD;
+ (KPCAA3DCoordinate *)EquatorialRectangularCoordinatesAnyEquinox:(double)JD JDEquinox:(double)JDEquinox;

@end
