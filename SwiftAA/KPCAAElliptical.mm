//
//  KPCAAElliptical.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 06/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import "KPCAAElliptical.h"
#import "AAElliptical.h"

double KPCAAEllipticalDistanceToLightTime(double Distance)
{
    return CAAElliptical::DistanceToLightTime(Distance);
}

KPCAAEllipticalPlanetaryDetails KPCAAEllipticalCalculatePlanetaryDetails(double JD, KPCPlanetaryObject object, BOOL highPrecision)
{
    CAAEllipticalPlanetaryDetails detailsPlus = CAAElliptical::Calculate(JD, (CAAElliptical::EllipticalObject)object, highPrecision);
    
    struct KPCAAEllipticalPlanetaryDetails details;
    details.ApparentGeocentricLongitude = detailsPlus.ApparentGeocentricLongitude;
    details.ApparentGeocentricLatitude = detailsPlus.ApparentGeocentricLatitude;
    details.ApparentGeocentricDistance = detailsPlus.ApparentGeocentricDistance;
    details.ApparentLightTime = detailsPlus.ApparentLightTime;
    details.ApparentGeocentricRA = detailsPlus.ApparentGeocentricRA;
    details.ApparentGeocentricDeclination = detailsPlus.ApparentGeocentricDeclination;

    return details;
}

double KPCAAEllipticalSemiMajorAxisFromPerihelionDistance(double q, double e)
{
    return CAAElliptical::SemiMajorAxisFromPerihelionDistance(q, e);
}

double KPCAAEllipticalMeanMotionFromSemiMajorAxis(double a)
{
    return CAAElliptical::MeanMotionFromSemiMajorAxis(a);
}

KPCAAEllipticalObjectDetails KPCAAEllipticalCalculateObjectDetails(double JD, KPCAAEllipticalObjectElements *elements, BOOL highPrecision)
{
    CAAEllipticalObjectElements elementsPlus = CAAEllipticalObjectElements();
    CAAEllipticalObjectDetails detailsPlus = CAAElliptical::Calculate(JD, elementsPlus, highPrecision);

    struct KPCAAEllipticalObjectDetails details;
    
    details.HeliocentricRectangularEquatorialCoordinateComponents = KPCAA3DCoordinateComponentsMake(detailsPlus.HeliocentricRectangularEquatorial.X,
                                                                                                    detailsPlus.HeliocentricRectangularEquatorial.Y,
                                                                                                    detailsPlus.HeliocentricRectangularEquatorial.Z);
    
    details.HeliocentricRectangularEclipticalCoordinateComponents = KPCAA3DCoordinateComponentsMake(detailsPlus.HeliocentricRectangularEcliptical.X,
                                                                                                    detailsPlus.HeliocentricRectangularEcliptical.Y,
                                                                                                    detailsPlus.HeliocentricRectangularEcliptical.Z);
    
    details.HeliocentricEclipticLongitude = detailsPlus.HeliocentricEclipticLongitude;
    details.HeliocentricEclipticLatitude = detailsPlus.HeliocentricEclipticLatitude;
    details.TrueGeocentricRA = detailsPlus.TrueGeocentricRA;
    details.TrueGeocentricDeclination = detailsPlus.TrueGeocentricDeclination;
    details.TrueGeocentricDistance = detailsPlus.TrueGeocentricDistance;
    details.TrueGeocentricLightTime = detailsPlus.TrueGeocentricLightTime;
    details.AstrometricGeocentricRA = detailsPlus.AstrometricGeocentricRA;
    details.AstrometricGeocentricDeclination = detailsPlus.AstrometricGeocentricDeclination;
    details.AstrometricGeocentricDistance = detailsPlus.AstrometricGeocentricDistance;
    details.AstrometricGeocentricLightTime = detailsPlus.AstrometricGeocentricLightTime;
    details.Elongation = detailsPlus.Elongation;
    details.PhaseAngle = detailsPlus.PhaseAngle;
    
    return details;
}

double KPCAAEllipticalInstantaneousVelocity(double r, double a)
{
    return CAAElliptical::InstantaneousVelocity(r, a);
}

double KPCAAEllipticalVelocityAtPerihelion(double e, double a)
{
    return CAAElliptical::VelocityAtPerihelion(e, a);
}

double KPCAAEllipticalVelocityAtAphelion(double e, double a)
{
    return CAAElliptical::VelocityAtAphelion(e, a);
}

double KPCAAEllipticalLengthOfEllipse(double e, double a)
{
    return CAAElliptical::LengthOfEllipse(e, a);
}

double KPCAAEllipticalCometMagnitude(double g, double delta, double k, double r)
{
    return CAAElliptical::CometMagnitude(g, delta, k, r);
}

double KPCAAEllipticalMinorPlanetMagnitude(double H, double delta, double G, double r, double PhaseAngle)
{
    return CAAElliptical::MinorPlanetMagnitude(H, delta, G, r, PhaseAngle);
}

