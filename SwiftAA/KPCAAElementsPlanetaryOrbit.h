//
//  KPCAAElementsPlanetaryOrbit.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 05/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KPCAAElementsPlanetaryOrbit : NSObject

+ (double)MercuryMeanLongitude:(double)JD;
+ (double)MercurySemimajorAxis:(double)JD;
+ (double)MercuryEccentricity:(double)JD;
+ (double)MercuryInclination:(double)JD;
+ (double)MercuryLongitudeAscendingNode:(double)JD;
+ (double)MercuryLongitudePerihelion:(double)JD;

+ (double)VenusMeanLongitude:(double)JD;
+ (double)VenusSemimajorAxis:(double)JD;
+ (double)VenusEccentricity:(double)JD;
+ (double)VenusInclination:(double)JD;
+ (double)VenusLongitudeAscendingNode:(double)JD;
+ (double)VenusLongitudePerihelion:(double)JD;

+ (double)EarthMeanLongitude:(double)JD;
+ (double)EarthSemimajorAxis:(double)JD;
+ (double)EarthEccentricity:(double)JD;
+ (double)EarthInclination:(double)JD;
+ (double)EarthLongitudePerihelion:(double)JD;

+ (double)MarsMeanLongitude:(double)JD;
+ (double)MarsSemimajorAxis:(double)JD;
+ (double)MarsEccentricity:(double)JD;
+ (double)MarsInclination:(double)JD;
+ (double)MarsLongitudeAscendingNode:(double)JD;
+ (double)MarsLongitudePerihelion:(double)JD;

+ (double)JupiterMeanLongitude:(double)JD;
+ (double)JupiterSemimajorAxis:(double)JD;
+ (double)JupiterEccentricity:(double)JD;
+ (double)JupiterInclination:(double)JD;
+ (double)JupiterLongitudeAscendingNode:(double)JD;
+ (double)JupiterLongitudePerihelion:(double)JD;

+ (double)SaturnMeanLongitude:(double)JD;
+ (double)SaturnSemimajorAxis:(double)JD;
+ (double)SaturnEccentricity:(double)JD;
+ (double)SaturnInclination:(double)JD;
+ (double)SaturnLongitudeAscendingNode:(double)JD;
+ (double)SaturnLongitudePerihelion:(double)JD;

+ (double)UranusMeanLongitude:(double)JD;
+ (double)UranusSemimajorAxis:(double)JD;
+ (double)UranusEccentricity:(double)JD;
+ (double)UranusInclination:(double)JD;
+ (double)UranusLongitudeAscendingNode:(double)JD;
+ (double)UranusLongitudePerihelion:(double)JD;

+ (double)NeptuneMeanLongitude:(double)JD;
+ (double)NeptuneSemimajorAxis:(double)JD;
+ (double)NeptuneEccentricity:(double)JD;
+ (double)NeptuneInclination:(double)JD;
+ (double)NeptuneLongitudeAscendingNode:(double)JD;
+ (double)NeptuneLongitudePerihelion:(double)JD;

+ (double)MercuryMeanLongitudeJ2000:(double)JD;
+ (double)MercuryInclinationJ2000:(double)JD;
+ (double)MercuryLongitudeAscendingNodeJ2000:(double)JD;
+ (double)MercuryLongitudePerihelionJ2000:(double)JD;

+ (double)VenusMeanLongitudeJ2000:(double)JD;
+ (double)VenusInclinationJ2000:(double)JD;
+ (double)VenusLongitudeAscendingNodeJ2000:(double)JD;
+ (double)VenusLongitudePerihelionJ2000:(double)JD;

+ (double)EarthMeanLongitudeJ2000:(double)JD;
+ (double)EarthInclinationJ2000:(double)JD;
+ (double)EarthLongitudeAscendingNodeJ2000:(double)JD;
+ (double)EarthLongitudePerihelionJ2000:(double)JD;

+ (double)MarsMeanLongitudeJ2000:(double)JD;
+ (double)MarsInclinationJ2000:(double)JD;
+ (double)MarsLongitudeAscendingNodeJ2000:(double)JD;
+ (double)MarsLongitudePerihelionJ2000:(double)JD;

+ (double)JupiterMeanLongitudeJ2000:(double)JD;
+ (double)JupiterInclinationJ2000:(double)JD;
+ (double)JupiterLongitudeAscendingNodeJ2000:(double)JD;
+ (double)JupiterLongitudePerihelionJ2000:(double)JD;

+ (double)SaturnMeanLongitudeJ2000:(double)JD;
+ (double)SaturnInclinationJ2000:(double)JD;
+ (double)SaturnLongitudeAscendingNodeJ2000:(double)JD;
+ (double)SaturnLongitudePerihelionJ2000:(double)JD;

+ (double)UranusMeanLongitudeJ2000:(double)JD;
+ (double)UranusInclinationJ2000:(double)JD;
+ (double)UranusLongitudeAscendingNodeJ2000:(double)JD;
+ (double)UranusLongitudePerihelionJ2000:(double)JD;

+ (double)NeptuneMeanLongitudeJ2000:(double)JD;
+ (double)NeptuneInclinationJ2000:(double)JD;
+ (double)NeptuneLongitudeAscendingNodeJ2000:(double)JD;
+ (double)NeptuneLongitudePerihelionJ2000:(double)JD;

@end
