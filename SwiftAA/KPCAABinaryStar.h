//
//  KPCAABinaryStar.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 04/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import <Foundation/Foundation.h>

#ifdef __cplusplus
extern "C" {
#endif

typedef struct KPCAABinaryStarDetails {
    double r;
    double Theta;
    double Rho;
} KPCAABinaryStarDetails;

/** Units:
 * t (time): decimal years
 * P (Period): mean solar years
 * T (time of periastron): decimal year
 * e (eccentricity): n.a.
 * a (semi major axis): arcseconds
 * i (inclination): degrees
 * Omega (position angle of ascending nodes): degrees
 * w (longitude of periastron): degrees
 */
KPCAABinaryStarDetails KPCAABinaryStar_CalculateDetails(double t, double P, double T, double e, double a, double i, double Omega, double w);

/** Units:
 * e: n.a.
 * i: degrees
 * w: degrees
 */
double KPCAABinaryStar_ApparentEccentricity(double e, double i, double w);

#if __cplusplus
}
#endif
