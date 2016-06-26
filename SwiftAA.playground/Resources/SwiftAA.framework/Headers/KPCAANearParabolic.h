//
//  KPCAANearParabolic.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 09/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import <Foundation/Foundation.h>
#import "KPCAA3DCoordinate.h"

#ifdef __cplusplus
extern "C" {
#endif

typedef struct KPCAANearParabolicObjectElements {
    double q;
    double i;
    double w;
    double omega;
    double JDEquinox;
    double T;
    double e;
} KPCAANearParabolicObjectElements;


typedef struct KPCAANearParabolicObjectDetails {
    KPCAA3DCoordinateComponents HeliocentricRectangularEquatorialCoordinateComponents;
    KPCAA3DCoordinateComponents HeliocentricRectangularEclipticalCoordinateComponents;
    double HeliocentricEclipticLongitude;
    double HeliocentricEclipticLatitude;
    double TrueGeocentricRA;
    double TrueGeocentricDeclination;
    double TrueGeocentricDistance;
    double TrueGeocentricLightTime;
    double AstrometricGeocentricRA;
    double AstrometricGeocentricDeclination;
    double AstrometricGeocentricDistance;
    double AstrometricGeocentricLightTime;
    double Elongation;
    double PhaseAngle;
} KPCAANearParabolicObjectDetails;


KPCAANearParabolicObjectDetails KPCAANearParabolic_CalculateObjectDetails(double JD, KPCAANearParabolicObjectElements elements, BOOL highPrecision);
void KPCAANearParabolic_CalulateTrueAnnomalyAndRadius(double JD, struct KPCAANearParabolicObjectElements elements, double *v, double *r);

#if __cplusplus
}
#endif
