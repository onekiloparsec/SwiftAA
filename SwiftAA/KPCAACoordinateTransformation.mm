//
//  KPCAACoordinateTransformation.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 04/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import "KPCAACoordinateTransformation.h"
#import "AACoordinateTransformation.h"

KPCAA2DCoordinateComponents KPCAACoordinateTransformation_Equatorial2Ecliptic(double Alpha, double Delta, double Epsilon)
{
    CAA2DCoordinate coords = CAACoordinateTransformation::Equatorial2Ecliptic(Alpha, Delta, Epsilon);
    return KPCAA2DCoordinateComponentsMake(coords.X, coords.Y);
}

KPCAA2DCoordinateComponents KPCAACoordinateTransformation_Ecliptic2Equatorial(double Lambda, double Beta, double Epsilon)
{
    CAA2DCoordinate coords = CAACoordinateTransformation::Ecliptic2Equatorial(Lambda, Beta, Epsilon);
    return KPCAA2DCoordinateComponentsMake(coords.X, coords.Y);
}

KPCAA2DCoordinateComponents KPCAACoordinateTransformation_Equatorial2Horizontal(double lha, double Delta, double latitude)
{
    CAA2DCoordinate coords = CAACoordinateTransformation::Equatorial2Horizontal(lha, Delta, latitude);
    return KPCAA2DCoordinateComponentsMake(coords.X, coords.Y);
}

KPCAA2DCoordinateComponents KPCAACoordinateTransformation_Horizontal2Equatorial(double A, double h, double latitude)
{
    CAA2DCoordinate coords = CAACoordinateTransformation::Horizontal2Equatorial(A, h, latitude);
    return KPCAA2DCoordinateComponentsMake(coords.X, coords.Y);
}

KPCAA2DCoordinateComponents KPCAACoordinateTransformation_Equatorial2Galactic(double Alpha, double Delta)
{
    CAA2DCoordinate coords = CAACoordinateTransformation::Equatorial2Galactic(Alpha, Delta);
    return KPCAA2DCoordinateComponentsMake(coords.X, coords.Y);
}

KPCAA2DCoordinateComponents KPCAACoordinateTransformation_Galactic2Equatorial(double l, double b)
{
    CAA2DCoordinate coords = CAACoordinateTransformation::Galactic2Equatorial(l, b);
    return KPCAA2DCoordinateComponentsMake(coords.X, coords.Y);
}

double DegreesToRadians(double Degrees)
{
    return CAACoordinateTransformation::DegreesToRadians(Degrees);
}

double RadiansToDegrees(double Radians)
{
    return CAACoordinateTransformation::RadiansToDegrees(Radians);
}

double RadiansToHours(double Radians)
{
    return CAACoordinateTransformation::RadiansToHours(Radians);
}

double HoursToRadians(double Hours)
{
    return CAACoordinateTransformation::HoursToRadians(Hours);
}

double HoursToDegrees(double Hours)
{
    return CAACoordinateTransformation::HoursToDegrees(Hours);
}

double DegreesToHours(double Degrees)
{
    return CAACoordinateTransformation::DegreesToHours(Degrees);
}

double PI()
{
    return CAACoordinateTransformation::PI();
}

double MapTo0To360Range(double Degrees)
{
    return CAACoordinateTransformation::MapTo0To360Range(Degrees);
}

double MapToMinus90To90Range(double Degrees)
{
    return CAACoordinateTransformation::MapToMinus90To90Range(Degrees);
}

double MapTo0To24Range(double HourAngle)
{
    return CAACoordinateTransformation::MapTo0To24Range(HourAngle);
}

double MapTo0To2PIRange(double Angle)
{
    return CAACoordinateTransformation::MapTo0To2PIRange(Angle);
}

double DMSToDegrees(double Degrees, double Minutes, double Seconds, bool bPositive)
{
    return CAACoordinateTransformation::DMSToDegrees(Degrees, Minutes, Seconds, bPositive);
}

