//
//  KPCAAPlanetPerihelionAphelion.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 10/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import <Foundation/Foundation.h>
#import "KPCAASwiftAdditions.h"

#ifdef __cplusplus
extern "C" {
#endif

long KPCAAPlanetPerihelionAphelion_MercuryK(double Year);
double KPCAAPlanetPerihelionAphelion_MercuryPerihelion(long k);
double KPCAAPlanetPerihelionAphelion_MercuryAphelion(long k);

long KPCAAPlanetPerihelionAphelion_VenusK(double Year);
double KPCAAPlanetPerihelionAphelion_VenusPerihelion(long k);
double KPCAAPlanetPerihelionAphelion_VenusAphelion(long k);

long KPCAAPlanetPerihelionAphelion_EarthK(double Year);
double KPCAAPlanetPerihelionAphelion_EarthPerihelion(long k, BOOL barycentric);
double KPCAAPlanetPerihelionAphelion_EarthAphelion(long k, BOOL barycentric);

long KPCAAPlanetPerihelionAphelion_MarsK(double Year);
double KPCAAPlanetPerihelionAphelion_MarsPerihelion(long k);
double KPCAAPlanetPerihelionAphelion_MarsAphelion(long k);

long KPCAAPlanetPerihelionAphelion_JupiterK(double Year);
double KPCAAPlanetPerihelionAphelion_JupiterPerihelion(long k);
double KPCAAPlanetPerihelionAphelion_JupiterAphelion(long k);

long KPCAAPlanetPerihelionAphelion_SaturnK(double Year);
double KPCAAPlanetPerihelionAphelion_SaturnPerihelion(long k);
double KPCAAPlanetPerihelionAphelion_SaturnAphelion(long k);

long KPCAAPlanetPerihelionAphelion_UranusK(double Year);
double KPCAAPlanetPerihelionAphelion_UranusPerihelion(long k);
double KPCAAPlanetPerihelionAphelion_UranusAphelion(long k);

long KPCAAPlanetPerihelionAphelion_NeptuneK(double Year);
double KPCAAPlanetPerihelionAphelion_NeptunePerihelion(long k);
double KPCAAPlanetPerihelionAphelion_NeptuneAphelion(long k);

    
// SwiftAA Additions
    
long KPCAAPlanetPerihelionAphelion_K(double Year, KPCAAPlanetStrict planet);
double KPCAAPlanetPerihelionAphelion_Perihelion(long k, KPCAAPlanetStrict planet);
double KPCAAPlanetPerihelionAphelion_Aphelion(long k, KPCAAPlanetStrict planet);
    
#if __cplusplus
}
#endif
