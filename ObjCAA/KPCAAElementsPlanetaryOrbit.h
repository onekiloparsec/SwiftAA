//
//  KPCAAElementsPlanetaryOrbit.h
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

double KPCAAElementsPlanetaryOrbit_MercuryMeanLongitude(double JD);
double KPCAAElementsPlanetaryOrbit_MercurySemimajorAxis(double JD);
double KPCAAElementsPlanetaryOrbit_MercuryEccentricity(double JD);
double KPCAAElementsPlanetaryOrbit_MercuryInclination(double JD);
double KPCAAElementsPlanetaryOrbit_MercuryLongitudeAscendingNode(double JD);
double KPCAAElementsPlanetaryOrbit_MercuryLongitudePerihelion(double JD);

double KPCAAElementsPlanetaryOrbit_VenusMeanLongitude(double JD);
double KPCAAElementsPlanetaryOrbit_VenusSemimajorAxis(double JD);
double KPCAAElementsPlanetaryOrbit_VenusEccentricity(double JD);
double KPCAAElementsPlanetaryOrbit_VenusInclination(double JD);
double KPCAAElementsPlanetaryOrbit_VenusLongitudeAscendingNode(double JD);
double KPCAAElementsPlanetaryOrbit_VenusLongitudePerihelion(double JD);

double KPCAAElementsPlanetaryOrbit_EarthMeanLongitude(double JD);
double KPCAAElementsPlanetaryOrbit_EarthSemimajorAxis(double JD);
double KPCAAElementsPlanetaryOrbit_EarthEccentricity(double JD);
double KPCAAElementsPlanetaryOrbit_EarthInclination(double JD);

double KPCAAElementsPlanetaryOrbit_EarthLongitudePerihelion(double JD);

double KPCAAElementsPlanetaryOrbit_MarsMeanLongitude(double JD);
double KPCAAElementsPlanetaryOrbit_MarsSemimajorAxis(double JD);
double KPCAAElementsPlanetaryOrbit_MarsEccentricity(double JD);
double KPCAAElementsPlanetaryOrbit_MarsInclination(double JD);
double KPCAAElementsPlanetaryOrbit_MarsLongitudeAscendingNode(double JD);
double KPCAAElementsPlanetaryOrbit_MarsLongitudePerihelion(double JD);

double KPCAAElementsPlanetaryOrbit_JupiterMeanLongitude(double JD);
double KPCAAElementsPlanetaryOrbit_JupiterSemimajorAxis(double JD);
double KPCAAElementsPlanetaryOrbit_JupiterEccentricity(double JD);
double KPCAAElementsPlanetaryOrbit_JupiterInclination(double JD);
double KPCAAElementsPlanetaryOrbit_JupiterLongitudeAscendingNode(double JD);
double KPCAAElementsPlanetaryOrbit_JupiterLongitudePerihelion(double JD);

double KPCAAElementsPlanetaryOrbit_SaturnMeanLongitude(double JD);
double KPCAAElementsPlanetaryOrbit_SaturnSemimajorAxis(double JD);
double KPCAAElementsPlanetaryOrbit_SaturnEccentricity(double JD);
double KPCAAElementsPlanetaryOrbit_SaturnInclination(double JD);
double KPCAAElementsPlanetaryOrbit_SaturnLongitudeAscendingNode(double JD);
double KPCAAElementsPlanetaryOrbit_SaturnLongitudePerihelion(double JD);

double KPCAAElementsPlanetaryOrbit_UranusMeanLongitude(double JD);
double KPCAAElementsPlanetaryOrbit_UranusSemimajorAxis(double JD);
double KPCAAElementsPlanetaryOrbit_UranusEccentricity(double JD);
double KPCAAElementsPlanetaryOrbit_UranusInclination(double JD);
double KPCAAElementsPlanetaryOrbit_UranusLongitudeAscendingNode(double JD);
double KPCAAElementsPlanetaryOrbit_UranusLongitudePerihelion(double JD);

double KPCAAElementsPlanetaryOrbit_NeptuneMeanLongitude(double JD);
double KPCAAElementsPlanetaryOrbit_NeptuneSemimajorAxis(double JD);
double KPCAAElementsPlanetaryOrbit_NeptuneEccentricity(double JD);
double KPCAAElementsPlanetaryOrbit_NeptuneInclination(double JD);
double KPCAAElementsPlanetaryOrbit_NeptuneLongitudeAscendingNode(double JD);
double KPCAAElementsPlanetaryOrbit_NeptuneLongitudePerihelion(double JD);

    
double KPCAAElementsPlanetaryOrbit_MercuryMeanLongitudeJ2000(double JD);
double KPCAAElementsPlanetaryOrbit_MercuryInclinationJ2000(double JD);
double KPCAAElementsPlanetaryOrbit_MercuryLongitudeAscendingNodeJ2000(double JD);
double KPCAAElementsPlanetaryOrbit_MercuryLongitudePerihelionJ2000(double JD);

double KPCAAElementsPlanetaryOrbit_VenusMeanLongitudeJ2000(double JD);
double KPCAAElementsPlanetaryOrbit_VenusInclinationJ2000(double JD);
double KPCAAElementsPlanetaryOrbit_VenusLongitudeAscendingNodeJ2000(double JD);
double KPCAAElementsPlanetaryOrbit_VenusLongitudePerihelionJ2000(double JD);

double KPCAAElementsPlanetaryOrbit_EarthMeanLongitudeJ2000(double JD);
double KPCAAElementsPlanetaryOrbit_EarthInclinationJ2000(double JD);
double KPCAAElementsPlanetaryOrbit_EarthLongitudeAscendingNodeJ2000(double JD);
double KPCAAElementsPlanetaryOrbit_EarthLongitudePerihelionJ2000(double JD);

double KPCAAElementsPlanetaryOrbit_MarsMeanLongitudeJ2000(double JD);
double KPCAAElementsPlanetaryOrbit_MarsInclinationJ2000(double JD);
double KPCAAElementsPlanetaryOrbit_MarsLongitudeAscendingNodeJ2000(double JD);
double KPCAAElementsPlanetaryOrbit_MarsLongitudePerihelionJ2000(double JD);

double KPCAAElementsPlanetaryOrbit_JupiterMeanLongitudeJ2000(double JD);
double KPCAAElementsPlanetaryOrbit_JupiterInclinationJ2000(double JD);
double KPCAAElementsPlanetaryOrbit_JupiterLongitudeAscendingNodeJ2000(double JD);
double KPCAAElementsPlanetaryOrbit_JupiterLongitudePerihelionJ2000(double JD);

double KPCAAElementsPlanetaryOrbit_SaturnMeanLongitudeJ2000(double JD);
double KPCAAElementsPlanetaryOrbit_SaturnInclinationJ2000(double JD);
double KPCAAElementsPlanetaryOrbit_SaturnLongitudeAscendingNodeJ2000(double JD);
double KPCAAElementsPlanetaryOrbit_SaturnLongitudePerihelionJ2000(double JD);

double KPCAAElementsPlanetaryOrbit_UranusMeanLongitudeJ2000(double JD);
double KPCAAElementsPlanetaryOrbit_UranusInclinationJ2000(double JD);
double KPCAAElementsPlanetaryOrbit_UranusLongitudeAscendingNodeJ2000(double JD);
double KPCAAElementsPlanetaryOrbit_UranusLongitudePerihelionJ2000(double JD);

double KPCAAElementsPlanetaryOrbit_NeptuneMeanLongitudeJ2000(double JD);
double KPCAAElementsPlanetaryOrbit_NeptuneInclinationJ2000(double JD);
double KPCAAElementsPlanetaryOrbit_NeptuneLongitudeAscendingNodeJ2000(double JD);
double KPCAAElementsPlanetaryOrbit_NeptuneLongitudePerihelionJ2000(double JD);

    
// SwiftAA Additions
    
double KPCAAElementsPlanetaryOrbit_MeanLongitude(KPCAAPlanetStrict planet, double JD);
double KPCAAElementsPlanetaryOrbit_MeanLongitudeJ2000(KPCAAPlanetStrict planet, double JD);

double KPCAAElementsPlanetaryOrbit_SemimajorAxis(KPCAAPlanetStrict planet, double JD);
double KPCAAElementsPlanetaryOrbit_Eccentricity(KPCAAPlanetStrict planet, double JD);
    
double KPCAAElementsPlanetaryOrbit_Inclination(KPCAAPlanetStrict planet, double JD);
double KPCAAElementsPlanetaryOrbit_InclinationJ2000(KPCAAPlanetStrict planet, double JD);

double KPCAAElementsPlanetaryOrbit_LongitudeAscendingNode(KPCAAPlanetStrict planet, double JD);
double KPCAAElementsPlanetaryOrbit_LongitudeAscendingNodeJ2000(KPCAAPlanetStrict planet, double JD);

double KPCAAElementsPlanetaryOrbit_LongitudePerihelion(KPCAAPlanetStrict planet, double JD);
double KPCAAElementsPlanetaryOrbit_LongitudePerihelionJ2000(KPCAAPlanetStrict planet, double JD);

#if __cplusplus
}
#endif
