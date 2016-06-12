//
//  KPCAASun.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 10/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import <Foundation/Foundation.h>
#import "KPCAA3DCoordinate.h"

double KPCAASunGeometricEclipticLongitude(double JD, BOOL highPrecision);
double KPCAASunGeometricEclipticLatitude(double JD, BOOL highPrecision);
double KPCAASunGeometricEclipticLongitudeJ2000(double JD, BOOL highPrecision);
double KPCAASunGeometricEclipticLatitudeJ2000(double JD, BOOL highPrecision);
double KPCAASunGeometricFK5EclipticLongitude(double JD, BOOL highPrecision);
double KPCAASunGeometricFK5EclipticLatitude(double JD, BOOL highPrecision);
double KPCAASunApparentEclipticLongitude(double JD, BOOL highPrecision);
double KPCAASunApparentEclipticLatitude(double JD, BOOL highPrecision);

KPCAA3DCoordinateComponents KPCAASunEquatorialRectangularCoordinatesMeanEquinox(double JD, BOOL highPrecision);
KPCAA3DCoordinateComponents KPCAASunEclipticRectangularCoordinatesJ2000(double JD, BOOL highPrecision);
KPCAA3DCoordinateComponents KPCAASunEquatorialRectangularCoordinatesJ2000(double JD, BOOL highPrecision);
KPCAA3DCoordinateComponents KPCAASunEquatorialRectangularCoordinatesB1950(double JD, BOOL highPrecision);
KPCAA3DCoordinateComponents KPCAASunEquatorialRectangularCoordinatesAnyEquinox(double JD, double JDEquinox, BOOL highPrecision);
