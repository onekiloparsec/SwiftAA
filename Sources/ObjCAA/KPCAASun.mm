//
//  KPCAASun.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 10/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import "KPCAASun.h"
#import "AASun.h"

double KPCAASun_GeometricEclipticLongitude(double JD, BOOL highPrecision)
{
    return CAASun::GeometricEclipticLongitude(JD, highPrecision);
}

double KPCAASun_GeometricEclipticLatitude(double JD, BOOL highPrecision)
{
    return CAASun::GeometricEclipticLatitude(JD, highPrecision);
}

double KPCAASun_GeometricEclipticLongitudeJ2000(double JD, BOOL highPrecision)
{
    return CAASun::GeometricEclipticLongitudeJ2000(JD, highPrecision);
}

double KPCAASun_GeometricEclipticLatitudeJ2000(double JD, BOOL highPrecision)
{
    return CAASun::GeometricEclipticLatitudeJ2000(JD, highPrecision);
}

double KPCAASun_GeometricFK5EclipticLongitude(double JD, BOOL highPrecision)
{
    return CAASun::GeometricFK5EclipticLongitude(JD, highPrecision);
}

double KPCAASun_GeometricFK5EclipticLatitude(double JD, BOOL highPrecision)
{
    return CAASun::GeometricFK5EclipticLatitude(JD, highPrecision);
}

double KPCAASun_ApparentEclipticLongitude(double JD, BOOL highPrecision)
{
    return CAASun::ApparentEclipticLongitude(JD, highPrecision);
}

double KPCAASun_ApparentEclipticLatitude(double JD, BOOL highPrecision)
{
    return CAASun::ApparentEclipticLatitude(JD, highPrecision);
}


KPCAA3DCoordinateComponents KPCAASun_EquatorialRectangularCoordinatesMeanEquinox(double JD, BOOL highPrecision)
{
    CAA3DCoordinate coords = CAASun::EquatorialRectangularCoordinatesMeanEquinox(JD, highPrecision);
    return KPCAA3DCoordinateComponentsMake(coords.X, coords.Y, coords.Z);
}

KPCAA3DCoordinateComponents KPCAASun_EclipticRectangularCoordinatesJ2000(double JD, BOOL highPrecision)
{
    CAA3DCoordinate coords = CAASun::EclipticRectangularCoordinatesJ2000(JD, highPrecision);
    return KPCAA3DCoordinateComponentsMake(coords.X, coords.Y, coords.Z);
}

KPCAA3DCoordinateComponents KPCAASun_EquatorialRectangularCoordinatesJ2000(double JD, BOOL highPrecision)
{
    CAA3DCoordinate coords = CAASun::EquatorialRectangularCoordinatesJ2000(JD, highPrecision);
    return KPCAA3DCoordinateComponentsMake(coords.X, coords.Y, coords.Z);
}

KPCAA3DCoordinateComponents KPCAASun_EquatorialRectangularCoordinatesB1950(double JD, BOOL highPrecision)
{
    CAA3DCoordinate coords = CAASun::EquatorialRectangularCoordinatesB1950(JD, highPrecision);
    return KPCAA3DCoordinateComponentsMake(coords.X, coords.Y, coords.Z);
}

KPCAA3DCoordinateComponents KPCAASun_EquatorialRectangularCoordinatesAnyEquinox(double JD, double JDEquinox, BOOL highPrecision)
{
    CAA3DCoordinate coords = CAASun::EquatorialRectangularCoordinatesAnyEquinox(JD, JDEquinox, highPrecision);
    return KPCAA3DCoordinateComponentsMake(coords.X, coords.Y, coords.Z);
}

