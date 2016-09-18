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

#ifdef __cplusplus
extern "C" {
#endif

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


double KPCAAElliptical_DistanceToLightTime(double Distance);
KPCAAEllipticalPlanetaryDetails KPCAAElliptical_CalculatePlanetaryDetails(double JD, KPCPlanetaryObject object, BOOL highPrecision);
double KPCAAElliptical_SemiMajorAxisFromPerihelionDistance(double q, double e);
double KPCAAElliptical_MeanMotionFromSemiMajorAxis(double a);
KPCAAEllipticalObjectDetails KPCAAElliptical_CalculateObjectDetails(double JD, KPCAAEllipticalObjectElements *elements, BOOL highPrecision);
KPCAAEllipticalObjectDetails KPCAAElliptical_CalculateObjectDetailsNoElements(double JD, BOOL highPrecision);
double KPCAAElliptical_InstantaneousVelocity(double r, double a);
double KPCAAElliptical_VelocityAtPerihelion(double e, double a);
double KPCAAElliptical_VelocityAtAphelion(double e, double a);
double KPCAAElliptical_LengthOfEllipse(double e, double a);
double KPCAAElliptical_CometMagnitude(double g, double delta, double k, double r);
double KPCAAElliptical_MinorPlanetMagnitude(double H, double delta, double G, double r, double PhaseAngle);


#if __cplusplus
}
#endif


