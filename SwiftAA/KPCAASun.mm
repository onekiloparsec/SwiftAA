//
//  KPCAASun.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 10/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import "KPCAASun.h"
#import "AASun.h"

double KPCAASunGeometricEclipticLongitude(double JD, BOOL highPrecision)
{
    return CAASun::GeometricEclipticLongitude(JD, highPrecision);
}

double KPCAASunGeometricEclipticLatitude(double JD, BOOL highPrecision)
{
    return CAASun::GeometricEclipticLatitude(JD, highPrecision);
}

double KPCAASunGeometricEclipticLongitudeJ2000(double JD, BOOL highPrecision)
{
    return CAASun::GeometricEclipticLongitudeJ2000(JD, highPrecision);
}

double KPCAASunGeometricEclipticLatitudeJ2000(double JD, BOOL highPrecision)
{
    return CAASun::GeometricEclipticLatitudeJ2000(JD, highPrecision);
}

double KPCAASunGeometricFK5EclipticLongitude(double JD, BOOL highPrecision)
{
    return CAASun::GeometricFK5EclipticLongitude(JD, highPrecision);
}

double KPCAASunGeometricFK5EclipticLatitude(double JD, BOOL highPrecision)
{
    return CAASun::GeometricFK5EclipticLatitude(JD, highPrecision);
}

double KPCAASunApparentEclipticLongitude(double JD, BOOL highPrecision)
{
    return CAASun::ApparentEclipticLongitude(JD, highPrecision);
}

double KPCAASunApparentEclipticLatitude(double JD, BOOL highPrecision)
{
    return CAASun::ApparentEclipticLatitude(JD, highPrecision);
}


KPCAA3DCoordinateComponents KPCAASunEquatorialRectangularCoordinatesMeanEquinox(double JD, BOOL highPrecision)
{
    CAA3DCoordinate coords = CAASun::EquatorialRectangularCoordinatesMeanEquinox(JD, highPrecision);
    return KPCAA3DCoordinateComponentsMake(coords.X, coords.Y, coords.Z);
}

KPCAA3DCoordinateComponents KPCAASunEclipticRectangularCoordinatesJ2000(double JD, BOOL highPrecision)
{
    CAA3DCoordinate coords = CAASun::EclipticRectangularCoordinatesJ2000(JD, highPrecision);
    return KPCAA3DCoordinateComponentsMake(coords.X, coords.Y, coords.Z);
}

KPCAA3DCoordinateComponents KPCAASunEquatorialRectangularCoordinatesJ2000(double JD, BOOL highPrecision)
{
    CAA3DCoordinate coords = CAASun::EquatorialRectangularCoordinatesJ2000(JD, highPrecision);
    return KPCAA3DCoordinateComponentsMake(coords.X, coords.Y, coords.Z);
}

KPCAA3DCoordinateComponents KPCAASunEquatorialRectangularCoordinatesB1950(double JD, BOOL highPrecision)
{
    CAA3DCoordinate coords = CAASun::EquatorialRectangularCoordinatesB1950(JD, highPrecision);
    return KPCAA3DCoordinateComponentsMake(coords.X, coords.Y, coords.Z);
}

KPCAA3DCoordinateComponents KPCAASunEquatorialRectangularCoordinatesAnyEquinox(double JD, double JDEquinox, BOOL highPrecision)
{
    CAA3DCoordinate coords = CAASun::EquatorialRectangularCoordinatesAnyEquinox(JD, JDEquinox, highPrecision);
    return KPCAA3DCoordinateComponentsMake(coords.X, coords.Y, coords.Z);
}

