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
#import "KPCAASwiftAdditions.h"

#ifdef __cplusplus
extern "C" {
#endif

// As for AA+ 2.44 onward, there is no more PLUTO_elliptical.
typedef NS_ENUM(NSUInteger, KPCAAEllipticalObject) {
    SUN_elliptical,
    MERCURY_elliptical,
    VENUS_elliptical,
    MARS_elliptical,
    JUPITER_elliptical,
    SATURN_elliptical,
    URANUS_elliptical,
    NEPTUNE_elliptical,
    UNDEFINED_elliptical = 999 // Swift Addition
};

typedef struct KPCAAEllipticalObjectElements {
    double a; // semi-major axis (AU)
    double e; // eccentricity
    double i; // inclination (degree)
    double w; // longitude (argument) of perihelion, yes it corresponds to lowercase omega in Meeu's book (see pp 228).
    double omega; // longitude of ascending node, yes it corresponds to capital Omega in Meeus' book (see pp 228).
    double JDEquinox; // J2000
    double T; // time of perihelion
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
KPCAAEllipticalPlanetaryDetails KPCAAElliptical_CalculatePlanetaryDetails(double JD, KPCAAEllipticalObject object, BOOL highPrecision);
double KPCAAElliptical_SemiMajorAxisFromPerihelionDistance(double q, double e);
double KPCAAElliptical_MeanMotionFromSemiMajorAxis(double a);
KPCAAEllipticalObjectDetails KPCAAElliptical_CalculateObjectDetails(double JD, KPCAAEllipticalObjectElements *elements, BOOL highPrecision);
KPCAAEllipticalObjectDetails KPCAAElliptical_CalculateObjectDetailsNoElements(double JD, KPCAAPlanetStrict planetStrict, BOOL highPrecision);
double KPCAAElliptical_InstantaneousVelocity(double r, double a);
double KPCAAElliptical_VelocityAtPerihelion(double e, double a);
double KPCAAElliptical_VelocityAtAphelion(double e, double a);
double KPCAAElliptical_LengthOfEllipse(double e, double a);
double KPCAAElliptical_CometMagnitude(double g, double delta, double k, double r);
double KPCAAElliptical_MinorPlanetMagnitude(double H, double delta, double G, double r, double PhaseAngle);


#if __cplusplus
}
#endif


