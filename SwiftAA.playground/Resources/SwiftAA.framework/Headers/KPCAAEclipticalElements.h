//
//  KPCAAEclipticalElements.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 05/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import <Foundation/Foundation.h>
#import "KPCAAPlanetaryPhenomena.h"

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

// SwiftAA Aditions
// The trick here is that CAPITALS are used in the C++ code for PlanetaryObject
// The Obj-C code respects that. To extend it here to include Earth and Pluto,
// We use the normal case.
    
typedef NS_ENUM(NSUInteger, KPCEclipticObject) {
    Mercury = MERCURY,
    Venus = VENUS,
    Earth = 99,
    Mars = MARS,
    Jupiter = JUPITER,
    Saturn = SATURN,
    Uranus = URANUS,
    Neptune = NEPTUNE,
    Pluto = 999
};
    
double KPCAAEclipticalElement_EclipticalLongitude(double JD, KPCEclipticObject object, BOOL highPrecision);
double KPCAAEclipticalElement_EclipticalLatitude(double JD, KPCEclipticObject object, BOOL highPrecision);
double KPCAAEclipticalElement_RadiusVector(double JD, KPCEclipticObject object, BOOL highPrecision);
    
#if __cplusplus
}
#endif
