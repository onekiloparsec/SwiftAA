//
//  KPCAAParallax.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 09/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import <Foundation/Foundation.h>
#import "KPCAA2DCoordinate.h"

#ifdef __cplusplus
extern "C" {
#endif

typedef struct KPCAATopocentricEclipticDetails {
    double Lambda;
    double Beta;
    double Semidiameter;
} KPCAATopocentricEclipticDetails;

KPCAA2DCoordinateComponents KPCAAParallax_Equatorial2TopocentricDelta(double Alpha, double Delta, double Distance, double Longitude, double Latitude, double Height, double JD);

KPCAA2DCoordinateComponents KPCAAParallax_Equatorial2Topocentric(double Alpha, double Delta, double Distance, double Longitude, double Latitude, double Height, double JD);

KPCAATopocentricEclipticDetails KPCAAParallax_Ecliptic2Topocentric(double Lambda, double Beta, double Semidiameter, double Distance, double Epsilon, double Latitude, double Height, double JD);

double KPCAAParallax_ParallaxToDistance(double Parallax);
double KPCAAParallax_DistanceToParallax(double Distance);

#if __cplusplus
}
#endif
