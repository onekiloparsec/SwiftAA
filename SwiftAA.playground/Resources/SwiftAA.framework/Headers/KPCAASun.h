//
//  KPCAASun.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 10/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import <Foundation/Foundation.h>
#import "KPCAA3DCoordinate.h"

#ifdef __cplusplus
extern "C" {
#endif

double KPCAASun_GeometricEclipticLongitude(double JD, BOOL highPrecision);
double KPCAASun_GeometricEclipticLatitude(double JD, BOOL highPrecision);
double KPCAASun_GeometricEclipticLongitudeJ2000(double JD, BOOL highPrecision);
double KPCAASun_GeometricEclipticLatitudeJ2000(double JD, BOOL highPrecision);
double KPCAASun_GeometricFK5EclipticLongitude(double JD, BOOL highPrecision);
double KPCAASun_GeometricFK5EclipticLatitude(double JD, BOOL highPrecision);
double KPCAASun_ApparentEclipticLongitude(double JD, BOOL highPrecision);
double KPCAASun_ApparentEclipticLatitude(double JD, BOOL highPrecision);

KPCAA3DCoordinateComponents KPCAASun_EquatorialRectangularCoordinatesMeanEquinox(double JD, BOOL highPrecision);
KPCAA3DCoordinateComponents KPCAASun_EclipticRectangularCoordinatesJ2000(double JD, BOOL highPrecision);
KPCAA3DCoordinateComponents KPCAASun_EquatorialRectangularCoordinatesJ2000(double JD, BOOL highPrecision);
KPCAA3DCoordinateComponents KPCAASun_EquatorialRectangularCoordinatesB1950(double JD, BOOL highPrecision);
KPCAA3DCoordinateComponents KPCAASun_EquatorialRectangularCoordinatesAnyEquinox(double JD, double JDEquinox, BOOL highPrecision);

#if __cplusplus
}
#endif
