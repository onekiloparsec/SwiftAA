//
//  KPCAACoordinateTransformation.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 04/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import "KPCAACoordinateTransformation.h"
#import "AACoordinateTransformation.h"

KPCAA2DCoordinateComponents KPCAACoordinateTransformationEquatorial2Ecliptic(double Alpha, double Delta, double Epsilon)
{
    CAA2DCoordinate coords = CAACoordinateTransformation::Equatorial2Ecliptic(Alpha, Delta, Epsilon);
    return KPCAA2DCoordinateComponentsMake(coords.X, coords.Y);
}

KPCAA2DCoordinateComponents KPCAACoordinateTransformationEcliptic2Equatorial(double Lambda, double Beta, double Epsilon)
{
    CAA2DCoordinate coords = CAACoordinateTransformation::Ecliptic2Equatorial(Lambda, Beta, Epsilon);
    return KPCAA2DCoordinateComponentsMake(coords.X, coords.Y);
}

KPCAA2DCoordinateComponents KPCAACoordinateTransformationEquatorial2Horizontal(double lha, double Delta, double latitude)
{
    CAA2DCoordinate coords = CAACoordinateTransformation::Equatorial2Horizontal(lha, Delta, latitude);
    return KPCAA2DCoordinateComponentsMake(coords.X, coords.Y);
}

KPCAA2DCoordinateComponents KPCAACoordinateTransformationHorizontal2Equatorial(double A, double h, double latitude)
{
    CAA2DCoordinate coords = CAACoordinateTransformation::Horizontal2Equatorial(A, h, latitude);
    return KPCAA2DCoordinateComponentsMake(coords.X, coords.Y);
}

KPCAA2DCoordinateComponents KPCAACoordinateTransformationEquatorial2Galactic(double Alpha, double Delta)
{
    CAA2DCoordinate coords = CAACoordinateTransformation::Equatorial2Galactic(Alpha, Delta);
    return KPCAA2DCoordinateComponentsMake(coords.X, coords.Y);
}

KPCAA2DCoordinateComponents KPCAACoordinateTransformationGalactic2Equatorial(double l, double b)
{
    CAA2DCoordinate coords = CAACoordinateTransformation::Galactic2Equatorial(l, b);
    return KPCAA2DCoordinateComponentsMake(coords.X, coords.Y);
}

