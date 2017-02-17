//
//  KPCAAElliptical.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 06/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import "KPCAAElliptical.h"
#import "AAElliptical.h"

CAAElliptical::EllipticalObject ellipticalObjectFromPlanetaryObject(KPCPlanetaryObject object);
CAAElliptical::EllipticalObject ellipticalObjectFromPlanetaryObject(KPCPlanetaryObject object) {
    switch (object) {
        case MERCURY:
            return CAAElliptical::EllipticalObject::MERCURY;
            break;
        case VENUS:
            return CAAElliptical::EllipticalObject::VENUS;
            break;
        case MARS:
            return CAAElliptical::EllipticalObject::MARS;
            break;
        case JUPITER:
            return CAAElliptical::EllipticalObject::JUPITER;
            break;
        case SATURN:
            return CAAElliptical::EllipticalObject::SATURN;
            break;
        case URANUS:
            return CAAElliptical::EllipticalObject::URANUS;
            break;
        case NEPTUNE:
            return CAAElliptical::EllipticalObject::NEPTUNE;
            break;
            
        default:
            throw NSInvalidArgumentException;
            break;
    }
}

double KPCAAElliptical_DistanceToLightTime(double Distance)
{
    return CAAElliptical::DistanceToLightTime(Distance);
}

KPCAAEllipticalPlanetaryDetails KPCAAElliptical_CalculatePlanetaryDetails(double JD, KPCPlanetaryObject object, BOOL highPrecision)
{
    CAAElliptical::EllipticalObject ellipticalObject = ellipticalObjectFromPlanetaryObject(object);
    CAAEllipticalPlanetaryDetails detailsPlus = CAAElliptical::Calculate(JD, ellipticalObject, highPrecision);
    
    struct KPCAAEllipticalPlanetaryDetails details;
    details.ApparentGeocentricLongitude = detailsPlus.ApparentGeocentricLongitude;
    details.ApparentGeocentricLatitude = detailsPlus.ApparentGeocentricLatitude;
    details.ApparentGeocentricDistance = detailsPlus.ApparentGeocentricDistance;
    details.ApparentLightTime = detailsPlus.ApparentLightTime;
    details.ApparentGeocentricRA = detailsPlus.ApparentGeocentricRA;
    details.ApparentGeocentricDeclination = detailsPlus.ApparentGeocentricDeclination;

    return details;
}

double KPCAAElliptical_SemiMajorAxisFromPerihelionDistance(double q, double e)
{
    return CAAElliptical::SemiMajorAxisFromPerihelionDistance(q, e);
}

double KPCAAElliptical_MeanMotionFromSemiMajorAxis(double a)
{
    return CAAElliptical::MeanMotionFromSemiMajorAxis(a);
}

KPCAAEllipticalObjectDetails KPCAAElliptical_CalculateObjectDetails(double JD, KPCAAEllipticalObjectElements *elements, BOOL highPrecision)
{
    CAAEllipticalObjectElements elementsPlus = CAAEllipticalObjectElements();
    CAAEllipticalObjectDetails detailsPlus = CAAElliptical::Calculate(JD, elementsPlus, highPrecision);
    
    (*elements).a = elementsPlus.a;
    (*elements).e = elementsPlus.e;
    (*elements).i = elementsPlus.i;
    (*elements).w = elementsPlus.w;
    (*elements).omega = elementsPlus.omega;
    (*elements).JDEquinox = elementsPlus.JDEquinox;
    (*elements).T = elementsPlus.T;

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

KPCAAEllipticalObjectDetails KPCAAElliptical_CalculateObjectDetailsNoElements(double JD, BOOL highPrecision)
{
    KPCAAEllipticalObjectElements elements;
    return KPCAAElliptical_CalculateObjectDetails(JD, &elements, highPrecision);
}

double KPCAAElliptical_InstantaneousVelocity(double r, double a)
{
    return CAAElliptical::InstantaneousVelocity(r, a);
}

double KPCAAElliptical_VelocityAtPerihelion(double e, double a)
{
    return CAAElliptical::VelocityAtPerihelion(e, a);
}

double KPCAAElliptical_VelocityAtAphelion(double e, double a)
{
    return CAAElliptical::VelocityAtAphelion(e, a);
}

double KPCAAElliptical_LengthOfEllipse(double e, double a)
{
    return CAAElliptical::LengthOfEllipse(e, a);
}

double KPCAAElliptical_CometMagnitude(double g, double delta, double k, double r)
{
    return CAAElliptical::CometMagnitude(g, delta, k, r);
}

double KPCAAElliptical_MinorPlanetMagnitude(double H, double delta, double G, double r, double PhaseAngle)
{
    return CAAElliptical::MinorPlanetMagnitude(H, delta, G, r, PhaseAngle);
}

