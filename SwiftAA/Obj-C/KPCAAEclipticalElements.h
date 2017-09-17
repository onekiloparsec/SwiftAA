//
//  KPCAAEclipticalElements.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 05/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import <Foundation/Foundation.h>
#import "KPCAASwiftAdditions.h"

#ifdef __cplusplus
extern "C" {
#endif

typedef struct KPCAAEclipticalElementDetails {
    double i;
    double w;
    double omega;
} KPCAAEclipticalElementDetails;

KPCAAEclipticalElementDetails KPCAAEclipticalElement_CalculateDetails(double i0, double w0, double omega0, double JD0, double JD);
KPCAAEclipticalElementDetails KPCAAEclipticalElement_FK4B1950ToFK5J2000(double i0, double w0, double omega0);
    
    
// SwiftAA Additions
// WARNING: These are HELIOCENTRIC ecliptical coordinates.
// To not be confused with 'regular' (geocentric) ecliptical coordinates. See AA+ p233.
    
double KPCAAEclipticalElement_EclipticLongitude(double JD, KPCAAPlanet planet, BOOL highPrecision);
double KPCAAEclipticalElement_EclipticLatitude(double JD, KPCAAPlanet planet, BOOL highPrecision);
double KPCAAEclipticalElement_RadiusVector(double JD, KPCAAPlanet planet, BOOL highPrecision);
    
#if __cplusplus
}
#endif
