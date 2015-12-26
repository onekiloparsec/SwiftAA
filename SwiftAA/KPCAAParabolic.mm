//
//  KPCAAParabolic.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 09/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import "KPCAAParabolic.h"
#import "AAParabolic.h"

double KPCAAParabolicBarkers(double W)
{
    return CAAParabolic::CalculateBarkers(W);
}

KPCAAParabolicObjectDetails KPCAAParabolicCalculateDetails(double JD, KPCAAParabolicObjectElements elements, BOOL highPrecision)
{
    CAAParabolicObjectElements elementsPlus = CAAParabolicObjectElements();
    elementsPlus.q = elements.q;
    elementsPlus.i = elements.i;
    elementsPlus.w = elements.w;
    elementsPlus.omega = elements.omega;
    elementsPlus.JDEquinox = elements.JDEquinox;
    elementsPlus.T = elements.T;
    
    CAAParabolicObjectDetails detailsPlus = CAAParabolic::Calculate(JD, elementsPlus, highPrecision);
    
    KPCAAParabolicObjectDetails details;
    
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
    details.AstrometricGeocentricRA = detailsPlus.AstrometricGeocenticRA;
    details.AstrometricGeocentricDeclination = detailsPlus.AstrometricGeocentricDeclination;
    details.AstrometricGeocentricDistance = detailsPlus.AstrometricGeocentricDistance;
    details.AstrometricGeocentricLightTime = detailsPlus.AstrometricGeocentricLightTime;
    details.Elongation = detailsPlus.Elongation;
    details.PhaseAngle = detailsPlus.PhaseAngle;
    
    return details;
    
}
