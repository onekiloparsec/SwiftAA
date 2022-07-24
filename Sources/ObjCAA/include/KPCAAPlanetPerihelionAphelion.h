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
double KPCAAPlanetPerihelionAphelion_MercuryPerihelion(double k);
double KPCAAPlanetPerihelionAphelion_MercuryAphelion(double k);

long KPCAAPlanetPerihelionAphelion_VenusK(double Year);
double KPCAAPlanetPerihelionAphelion_VenusPerihelion(double k);
double KPCAAPlanetPerihelionAphelion_VenusAphelion(double k);

long KPCAAPlanetPerihelionAphelion_EarthK(double Year);
double KPCAAPlanetPerihelionAphelion_EarthPerihelion(double k, BOOL barycentric);
double KPCAAPlanetPerihelionAphelion_EarthAphelion(double k, BOOL barycentric);

long KPCAAPlanetPerihelionAphelion_MarsK(double Year);
double KPCAAPlanetPerihelionAphelion_MarsPerihelion(double k);
double KPCAAPlanetPerihelionAphelion_MarsAphelion(double k);

long KPCAAPlanetPerihelionAphelion_JupiterK(double Year);
double KPCAAPlanetPerihelionAphelion_JupiterPerihelion(double k);
double KPCAAPlanetPerihelionAphelion_JupiterAphelion(double k);

long KPCAAPlanetPerihelionAphelion_SaturnK(double Year);
double KPCAAPlanetPerihelionAphelion_SaturnPerihelion(double k);
double KPCAAPlanetPerihelionAphelion_SaturnAphelion(double k);

long KPCAAPlanetPerihelionAphelion_UranusK(double Year);
double KPCAAPlanetPerihelionAphelion_UranusPerihelion(double k);
double KPCAAPlanetPerihelionAphelion_UranusAphelion(double k);

long KPCAAPlanetPerihelionAphelion_NeptuneK(double Year);
double KPCAAPlanetPerihelionAphelion_NeptunePerihelion(double k);
double KPCAAPlanetPerihelionAphelion_NeptuneAphelion(double k);

    
// SwiftAA Additions
    
double KPCAAPlanetPerihelionAphelion_K(double Year, KPCAAPlanetStrict planet);
double KPCAAPlanetPerihelionAphelion_Perihelion(double k, KPCAAPlanetStrict planet);
double KPCAAPlanetPerihelionAphelion_Aphelion(double k, KPCAAPlanetStrict planet);
    
#if __cplusplus
}
#endif
