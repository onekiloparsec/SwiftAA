//
//  KPCAANearParabolic.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 09/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KPCAA3DCoordinate.h"

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


KPCAANearParabolicObjectDetails KPCAANearParabolicCalculateObjectDetails(double JD, KPCAANearParabolicObjectElements elements, BOOL highPrecision);
void KPCAANearParabolicCalulateTrueAnnomalyAndRadius(double JD, struct KPCAANearParabolicObjectElements elements, double *v, double *r);

