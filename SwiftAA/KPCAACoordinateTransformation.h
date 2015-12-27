//
//  KPCAACoordinateTransformation.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 04/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
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

