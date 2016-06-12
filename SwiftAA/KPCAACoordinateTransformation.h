//
//  KPCAACoordinateTransformation.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 04/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import <Foundation/Foundation.h>
#import "KPCAA2DCoordinate.h"

// Alpha=R.A., Delta=Declination, Epsilon=Epoch
KPCAA2DCoordinateComponents KPCAACoordinateTransformationEquatorial2Ecliptic(double Alpha, double Delta, double Epsilon);

// Lambda=Celestial Longitude, Beta=Celestial Latitude, Epsilon=Epoch
KPCAA2DCoordinateComponents KPCAACoordinateTransformationEcliptic2Equatorial(double Lambda, double Beta, double Epsilon);

// lha=Local Hour Angle, Delta=Declination, latitude=Latitude
KPCAA2DCoordinateComponents KPCAACoordinateTransformationEquatorial2Horizontal(double lha, double Delta, double latitude);

// A=Azimuth, h=Altitude, latitude=latitude
KPCAA2DCoordinateComponents KPCAACoordinateTransformationHorizontal2Equatorial(double A, double h, double latitude);

// Alpha=R.A., Delta=Declination
KPCAA2DCoordinateComponents KPCAACoordinateTransformationEquatorial2Galactic(double Alpha, double Delta);

// l=Galactic Longitude, b=Galactic Latitude;
KPCAA2DCoordinateComponents KPCAACoordinateTransformationGalactic2Equatorial(double l, double b);

double DegreesToRadians(double Degrees);
double RadiansToDegrees(double Radians);
double RadiansToHours(double Radians);
double HoursToRadians(double Hours);
double HoursToDegrees(double Hours);
double DegreesToHours(double Degrees);
double PI();
double MapTo0To360Range(double Degrees);
double MapToMinus90To90Range(double Degrees);
double MapTo0To24Range(double HourAngle);
double MapTo0To2PIRange(double Angle);
double DMSToDegrees(double Degrees, double Minutes, double Seconds, bool bPositive);

