//
//  KPCAANearParabolic.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 09/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import "KPCAANearParabolic.h"
#import "AANearParabolic.h"

KPCAANearParabolicObjectDetails KPCAANearParabolic_CalculateObjectDetails(double JD, KPCAANearParabolicObjectElements elements, BOOL highPrecision)
{
    CAANearParabolicObjectElements elementsPlus = CAANearParabolicObjectElements();

    elementsPlus.q = elements.q;
    elementsPlus.i = elements.i;
    elementsPlus.w = elements.w;
    elementsPlus.omega = elements.omega;
    elementsPlus.JDEquinox = elements.JDEquinox;
    elementsPlus.T = elements.T;
    elementsPlus.e = elements.e;
    
    CAANearParabolicObjectDetails detailsPlus = CAANearParabolic::Calculate(JD, elementsPlus, highPrecision);
    
    struct KPCAANearParabolicObjectDetails details;
    
    details.HeliocentricRectangularEclipticalCoordinateComponents = KPCAA3DCoordinateComponentsMake(detailsPlus.HeliocentricRectangularEcliptical.X,
                                                                                                    detailsPlus.HeliocentricRectangularEcliptical.Y,
                                                                                                    detailsPlus.HeliocentricRectangularEcliptical.Z);
    
    details.HeliocentricRectangularEquatorialCoordinateComponents = KPCAA3DCoordinateComponentsMake(detailsPlus.HeliocentricRectangularEquatorial.X,
                                                                                                    detailsPlus.HeliocentricRectangularEquatorial.Y,
                                                                                                    detailsPlus.HeliocentricRectangularEquatorial.Z);
    
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

void KPCAANearParabolic_CalulateTrueAnnomalyAndRadius(double JD, struct KPCAANearParabolicObjectElements elements, double *v, double *r)
{
    CAANearParabolicObjectElements elementsPlus;
    CAANearParabolic::CalulateTrueAnnomalyAndRadius(JD, elementsPlus, *v, *r);
    
    elements.q = elementsPlus.q;
    elements.i = elementsPlus.i;
    elements.w = elementsPlus.w;
    elements.omega = elementsPlus.omega;
    elements.JDEquinox = elementsPlus.JDEquinox;
    elements.T = elementsPlus.T;
    elements.e = elementsPlus.e;
}
