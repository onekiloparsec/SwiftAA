//
//  KPCAAElliptical.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 06/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import <Foundation/Foundation.h>
#import "KPCAA3DCoordinate.h"
#import "KPCAAPlanetaryPhenomena.h"

typedef struct KPCAAEllipticalObjectElements {
    double a;
    double e;
    double i;
    double w;
    double omega;
    double JDEquinox;
    double T;
} KPCAAEllipticalObjectElements;

typedef struct KPCAAEllipticalPlanetaryDetails {
    double ApparentGeocentricLongitude;
    double ApparentGeocentricLatitude;
    double ApparentGeocentricDistance;
    double ApparentLightTime;
    double ApparentGeocentricRA;
    double ApparentGeocentricDeclination;
} KPCAAEllipticalPlanetaryDetails;

typedef struct KPCAAEllipticalObjectDetails {
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
} KPCAAEllipticalObjectDetails;


double KPCAAEllipticalDistanceToLightTime(double Distance);
KPCAAEllipticalPlanetaryDetails KPCAAEllipticalCalculatePlanetaryDetails(double JD, KPCPlanetaryObject object, BOOL highPrecision);
double KPCAAEllipticalSemiMajorAxisFromPerihelionDistance(double q, double e);
double KPCAAEllipticalMeanMotionFromSemiMajorAxis(double a);
KPCAAEllipticalObjectDetails KPCAAEllipticalCalculateObjectDetails(double JD, KPCAAEllipticalObjectElements *elements, BOOL highPrecision);
double KPCAAEllipticalInstantaneousVelocity(double r, double a);
double KPCAAEllipticalVelocityAtPerihelion(double e, double a);
double KPCAAEllipticalVelocityAtAphelion(double e, double a);
double KPCAAEllipticalLengthOfEllipse(double e, double a);
double KPCAAEllipticalCometMagnitude(double g, double delta, double k, double r);
double KPCAAEllipticalMinorPlanetMagnitude(double H, double delta, double G, double r, double PhaseAngle);




