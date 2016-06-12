//
//  KPCAAParabolic.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 09/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import <Foundation/Foundation.h>
#import "KPCAA3DCoordinate.h"

typedef struct KPCAAParabolicObjectElements {
    double q;
    double i;
    double w;
    double omega;
    double JDEquinox;
    double T;
} KPCAAParabolicObjectElements;


typedef struct KPCAAParabolicObjectDetails {
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
} KPCAAParabolicObjectDetails;


double KPCAAParabolicBarkers(double W);
KPCAAParabolicObjectDetails KPCAAParabolicCalculateDetails(double JD, struct KPCAAParabolicObjectElements elements, BOOL highPrecision);

