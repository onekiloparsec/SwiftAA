//
//  KPCAADiameters.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 04/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import <Foundation/Foundation.h>
#import "KPCAASwiftAdditions.h"

#ifdef __cplusplus
extern "C" {
#endif

double KPCAADiameters_SunSemidiameterA(double Delta);
double KPCAADiameters_MercurySemidiameterA(double Delta);
double KPCAADiameters_VenusSemidiameterA(double Delta);
double KPCAADiameters_MarsSemidiameterA(double Delta);
double KPCAADiameters_JupiterEquatorialSemidiameterA(double Delta);
double KPCAADiameters_JupiterPolarSemidiameterA(double Delta);
double KPCAADiameters_SaturnEquatorialSemidiameterA(double Delta);
double KPCAADiameters_SaturnPolarSemidiameterA(double Delta);
double KPCAADiameters_ApparentSaturnPolarSemidiameterA(double Delta, double B);
double KPCAADiameters_UranusSemidiameterA(double Delta);
double KPCAADiameters_NeptuneSemidiameterA(double Delta);

double KPCAADiameters_MercurySemidiameterB(double Delta);
double KPCAADiameters_VenusSemidiameterB(double Delta);
double KPCAADiameters_MarsSemidiameterB(double Delta);
double KPCAADiameters_JupiterEquatorialSemidiameterB(double Delta);
double KPCAADiameters_JupiterPolarSemidiameterB(double Delta);
double KPCAADiameters_SaturnEquatorialSemidiameterB(double Delta);
double KPCAADiameters_SaturnPolarSemidiameterB(double Delta);
double KPCAADiameters_ApparentSaturnPolarSemidiameterB(double Delta, double B);
double KPCAADiameters_UranusSemidiameterB(double Delta);
double KPCAADiameters_NeptuneSemidiameterB(double Delta);
double KPCAADiameters_PlutoSemidiameterB(double Delta);

double KPCAADiameters_GeocentricMoonSemidiameter(double Delta);
double KPCAADiameters_TopocentricMoonSemidiameter(double DistanceDelta, double Delta, double H, double Latitude, double Height);
double KPCAADiameters_AsteroidDiameter(double H, double A);
double KPCAADiameters_ApparentAsteroidDiameter(double H, double A);

// SwiftAA Additions
    
double KPCAADiameters_EquatorialSemiDiameterB(KPCAAPlanet planet, double Delta);
double KPCAADiameters_PolarSemiDiameterB(KPCAAPlanet planet, double Delta);
    
#if __cplusplus
}
#endif
