//
//  KPCAAIlluminatedFraction.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 09/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import <Foundation/Foundation.h>
#import "KPCAASwiftAdditions.h"

#ifdef __cplusplus
extern "C" {
#endif
    
double KPCAAIlluminatedFraction_PhaseAngle(double r, double R, double Delta);
double KPCAAIlluminatedFraction_PhaseAngle_bis(double R, double R0, double B, double L, double L0, double Delta);
double KPCAAIlluminatedFraction_PhaseAngleRectangular(double x, double y, double z, double B, double L, double Delta);
double KPCAAIlluminatedFraction_IlluminatedFraction(double PhaseAngle);
double KPCAAIlluminatedFraction_IlluminatedFraction_bis(double r, double R, double Delta);

double KPCAAIlluminatedFraction_MercuryMagnitudeMuller(double r, double Delta, double i);
double KPCAAIlluminatedFraction_VenusMagnitudeMuller(double r, double Delta, double i);
double KPCAAIlluminatedFraction_MarsMagnitudeMuller(double r, double Delta, double i);
double KPCAAIlluminatedFraction_JupiterMagnitudeMuller(double r, double Delta);
double KPCAAIlluminatedFraction_SaturnMagnitudeMuller(double r, double Delta, double DeltaU, double B);
double KPCAAIlluminatedFraction_UranusMagnitudeMuller(double r, double Delta);
double KPCAAIlluminatedFraction_NeptuneMagnitudeMuller(double r, double Delta);

double KPCAAIlluminatedFraction_MercuryMagnitudeAA(double r, double Delta, double i);
double KPCAAIlluminatedFraction_VenusMagnitudeAA(double r, double Delta, double i);
double KPCAAIlluminatedFraction_MarsMagnitudeAA(double r, double Delta, double i);
double KPCAAIlluminatedFraction_JupiterMagnitudeAA(double r, double Delta, double i);
double KPCAAIlluminatedFraction_SaturnMagnitudeAA(double r, double Delta, double DeltaU, double B);
double KPCAAIlluminatedFraction_UranusMagnitudeAA(double r, double Delta);
double KPCAAIlluminatedFraction_NeptuneMagnitudeAA(double r, double Delta);
    
// SwiftAddition
double KPCAAIlluminatedFraction_MagnitudeMuller(KPCPlanetaryObject planet, double r, double Delta, double i);
double KPCAAIlluminatedFraction_MagnitudeAA(KPCPlanetaryObject planet, double r, double Delta, double i);
    
#if __cplusplus
}
#endif
