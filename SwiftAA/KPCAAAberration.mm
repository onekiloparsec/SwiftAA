//
//  KPCAAAberration.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 04/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import "KPCAAAberration.h"
#import "AAAberration.h"

KPCAA3DCoordinateComponents KPCAAAberration_EarthVelocity(double JD, BOOL highPrecision)
{
    CAA3DCoordinate coords = CAAAberration::EarthVelocity(JD, highPrecision);
    return KPCAA3DCoordinateComponentsMake(coords.X, coords.Y, coords.Z);
}

KPCAA2DCoordinateComponents KPCAAAberration_EquatorialAberration(double Alpha, double Delta, double JD, BOOL highPrecision)
{
    CAA2DCoordinate coords = CAAAberration::EquatorialAberration(Alpha, Delta, JD, highPrecision);
    return KPCAA2DCoordinateComponentsMake(coords.X, coords.Y);
}

KPCAA2DCoordinateComponents KPCAAAberration_EclipticAberration(double Lambda, double Beta, double JD, BOOL highPrecision)
{
    CAA2DCoordinate coords = CAAAberration::EclipticAberration(Lambda, Beta, JD, highPrecision);
    return KPCAA2DCoordinateComponentsMake(coords.X, coords.Y);
}
