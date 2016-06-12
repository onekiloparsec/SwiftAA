//
//  KPCAAParallax.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 09/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import <Foundation/Foundation.h>
#import "KPCAA2DCoordinate.h"

typedef struct KPCAATopocentricEclipticDetails {
    double Lambda;
    double Beta;
    double Semidiameter;
} KPCAATopocentricEclipticDetails;

KPCAA2DCoordinateComponents KPCAAParallaxEquatorial2TopocentricDelta(double Alpha, double Delta, double Distance, double Longitude, double Latitude, double Height, double JD);

KPCAA2DCoordinateComponents KPCAAParallaxEquatorial2Topocentric(double Alpha, double Delta, double Distance, double Longitude, double Latitude, double Height, double JD);

KPCAATopocentricEclipticDetails KPCAAParallaxEcliptic2Topocentric(double Lambda, double Beta, double Semidiameter, double Distance, double Epsilon, double Latitude, double Height, double JD);

double KPCAAParallaxParallaxToDistance(double Parallax);
double KPCAAParallaxDistanceToParallax(double Distance);

