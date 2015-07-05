//
//  KPCAAElementsPlanetaryOrbit.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 05/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import "KPCAAElementsPlanetaryOrbit.h"
#import "AAElementsPlanetaryOrbit.h"

@implementation KPCAAElementsPlanetaryOrbit

+ (double)MercuryMeanLongitude:(double)JD
{
    return CAAElementsPlanetaryOrbit::MercuryMeanLongitude(JD);
}

+ (double)MercurySemimajorAxis:(double)JD
{
    return CAAElementsPlanetaryOrbit::MercurySemimajorAxis(JD);
}

+ (double)MercuryEccentricity:(double)JD
{
    return CAAElementsPlanetaryOrbit::MercuryEccentricity(JD);
}

+ (double)MercuryInclination:(double)JD
{
    return CAAElementsPlanetaryOrbit::MercuryInclination(JD);
}

+ (double)MercuryLongitudeAscendingNode:(double)JD
{
    return CAAElementsPlanetaryOrbit::MercuryLongitudeAscendingNode(JD);
}

+ (double)MercuryLongitudePerihelion:(double)JD
{
    return CAAElementsPlanetaryOrbit::MercuryLongitudePerihelion(JD);
}


+ (double)VenusMeanLongitude:(double)JD
{
    return CAAElementsPlanetaryOrbit::VenusMeanLongitude(JD);
}

+ (double)VenusSemimajorAxis:(double)JD
{
    return CAAElementsPlanetaryOrbit::VenusSemimajorAxis(JD);
}

+ (double)VenusEccentricity:(double)JD
{
    return CAAElementsPlanetaryOrbit::VenusEccentricity(JD);
}

+ (double)VenusInclination:(double)JD
{
    return CAAElementsPlanetaryOrbit::VenusInclination(JD);
}

+ (double)VenusLongitudeAscendingNode:(double)JD
{
    return CAAElementsPlanetaryOrbit::VenusLongitudeAscendingNode(JD);
}

+ (double)VenusLongitudePerihelion:(double)JD
{
    return CAAElementsPlanetaryOrbit::VenusLongitudePerihelion(JD);
}


+ (double)EarthMeanLongitude:(double)JD
{
    return CAAElementsPlanetaryOrbit::EarthMeanLongitude(JD);
}

+ (double)EarthSemimajorAxis:(double)JD
{
    return CAAElementsPlanetaryOrbit::EarthSemimajorAxis(JD);
}

+ (double)EarthEccentricity:(double)JD
{
    return CAAElementsPlanetaryOrbit::EarthEccentricity(JD);
}

+ (double)EarthInclination:(double)JD
{
    return CAAElementsPlanetaryOrbit::EarthInclination(JD);
}

+ (double)EarthLongitudePerihelion:(double)JD
{
    return CAAElementsPlanetaryOrbit::EarthLongitudePerihelion(JD);
}


+ (double)MarsMeanLongitude:(double)JD
{
    return CAAElementsPlanetaryOrbit::MarsMeanLongitude(JD);
}

+ (double)MarsSemimajorAxis:(double)JD
{
    return CAAElementsPlanetaryOrbit::MarsSemimajorAxis(JD);
}

+ (double)MarsEccentricity:(double)JD
{
    return CAAElementsPlanetaryOrbit::MarsEccentricity(JD);
}

+ (double)MarsInclination:(double)JD
{
    return CAAElementsPlanetaryOrbit::MarsInclination(JD);
}

+ (double)MarsLongitudeAscendingNode:(double)JD
{
    return CAAElementsPlanetaryOrbit::MarsLongitudeAscendingNode(JD);
}

+ (double)MarsLongitudePerihelion:(double)JD
{
    return CAAElementsPlanetaryOrbit::MarsLongitudePerihelion(JD);
}


+ (double)JupiterMeanLongitude:(double)JD
{
    return CAAElementsPlanetaryOrbit::JupiterMeanLongitude(JD);
}

+ (double)JupiterSemimajorAxis:(double)JD
{
    return CAAElementsPlanetaryOrbit::JupiterSemimajorAxis(JD);
}

+ (double)JupiterEccentricity:(double)JD
{
    return CAAElementsPlanetaryOrbit::JupiterEccentricity(JD);
}

+ (double)JupiterInclination:(double)JD
{
    return CAAElementsPlanetaryOrbit::JupiterInclination(JD);
}

+ (double)JupiterLongitudeAscendingNode:(double)JD
{
    return CAAElementsPlanetaryOrbit::JupiterLongitudeAscendingNode(JD);
}

+ (double)JupiterLongitudePerihelion:(double)JD
{
    return CAAElementsPlanetaryOrbit::JupiterLongitudePerihelion(JD);
}


+ (double)SaturnMeanLongitude:(double)JD
{
    return CAAElementsPlanetaryOrbit::SaturnMeanLongitude(JD);
}

+ (double)SaturnSemimajorAxis:(double)JD
{
    return CAAElementsPlanetaryOrbit::SaturnSemimajorAxis(JD);
}

+ (double)SaturnEccentricity:(double)JD
{
    return CAAElementsPlanetaryOrbit::SaturnEccentricity(JD);
}

+ (double)SaturnInclination:(double)JD
{
    return CAAElementsPlanetaryOrbit::SaturnInclination(JD);
}

+ (double)SaturnLongitudeAscendingNode:(double)JD
{
    return CAAElementsPlanetaryOrbit::SaturnLongitudeAscendingNode(JD);
}

+ (double)SaturnLongitudePerihelion:(double)JD
{
    return CAAElementsPlanetaryOrbit::SaturnLongitudePerihelion(JD);
}


+ (double)UranusMeanLongitude:(double)JD
{
    return CAAElementsPlanetaryOrbit::UranusMeanLongitude(JD);
}

+ (double)UranusSemimajorAxis:(double)JD
{
    return CAAElementsPlanetaryOrbit::UranusSemimajorAxis(JD);
}

+ (double)UranusEccentricity:(double)JD
{
    return CAAElementsPlanetaryOrbit::UranusEccentricity(JD);
}

+ (double)UranusInclination:(double)JD
{
    return CAAElementsPlanetaryOrbit::UranusInclination(JD);
}

+ (double)UranusLongitudeAscendingNode:(double)JD
{
    return CAAElementsPlanetaryOrbit::UranusLongitudeAscendingNode(JD);
}

+ (double)UranusLongitudePerihelion:(double)JD
{
    return CAAElementsPlanetaryOrbit::UranusLongitudePerihelion(JD);
}


+ (double)NeptuneMeanLongitude:(double)JD
{
    return CAAElementsPlanetaryOrbit::NeptuneMeanLongitude(JD);
}

+ (double)NeptuneSemimajorAxis:(double)JD
{
    return CAAElementsPlanetaryOrbit::NeptuneSemimajorAxis(JD);
}

+ (double)NeptuneEccentricity:(double)JD
{
    return CAAElementsPlanetaryOrbit::NeptuneEccentricity(JD);
}

+ (double)NeptuneInclination:(double)JD
{
    return CAAElementsPlanetaryOrbit::NeptuneInclination(JD);
}

+ (double)NeptuneLongitudeAscendingNode:(double)JD
{
    return CAAElementsPlanetaryOrbit::NeptuneLongitudeAscendingNode(JD);
}

+ (double)NeptuneLongitudePerihelion:(double)JD
{
    return CAAElementsPlanetaryOrbit::NeptuneLongitudePerihelion(JD);
}


+ (double)MercuryMeanLongitudeJ2000:(double)JD
{
    return CAAElementsPlanetaryOrbit::MercuryMeanLongitudeJ2000(JD);
}

+ (double)MercuryInclinationJ2000:(double)JD
{
    return CAAElementsPlanetaryOrbit::MercuryInclinationJ2000(JD);
}

+ (double)MercuryLongitudeAscendingNodeJ2000:(double)JD
{
    return CAAElementsPlanetaryOrbit::MercuryLongitudeAscendingNodeJ2000(JD);
}

+ (double)MercuryLongitudePerihelionJ2000:(double)JD
{
    return CAAElementsPlanetaryOrbit::MercuryLongitudePerihelionJ2000(JD);
}


+ (double)VenusMeanLongitudeJ2000:(double)JD
{
    return CAAElementsPlanetaryOrbit::VenusMeanLongitudeJ2000(JD);
}

+ (double)VenusInclinationJ2000:(double)JD
{
    return CAAElementsPlanetaryOrbit::VenusInclinationJ2000(JD);
}

+ (double)VenusLongitudeAscendingNodeJ2000:(double)JD
{
    return CAAElementsPlanetaryOrbit::VenusLongitudeAscendingNodeJ2000(JD);
}

+ (double)VenusLongitudePerihelionJ2000:(double)JD
{
    return CAAElementsPlanetaryOrbit::VenusLongitudePerihelionJ2000(JD);
}


+ (double)EarthMeanLongitudeJ2000:(double)JD
{
    return CAAElementsPlanetaryOrbit::EarthMeanLongitudeJ2000(JD);
}

+ (double)EarthInclinationJ2000:(double)JD
{
    return CAAElementsPlanetaryOrbit::EarthInclinationJ2000(JD);
}

+ (double)EarthLongitudeAscendingNodeJ2000:(double)JD
{
    return CAAElementsPlanetaryOrbit::EarthLongitudeAscendingNodeJ2000(JD);
}

+ (double)EarthLongitudePerihelionJ2000:(double)JD
{
    return CAAElementsPlanetaryOrbit::EarthLongitudePerihelionJ2000(JD);
}


+ (double)MarsMeanLongitudeJ2000:(double)JD
{
    return CAAElementsPlanetaryOrbit::MarsMeanLongitudeJ2000(JD);
}

+ (double)MarsInclinationJ2000:(double)JD
{
    return CAAElementsPlanetaryOrbit::MarsInclinationJ2000(JD);
}

+ (double)MarsLongitudeAscendingNodeJ2000:(double)JD
{
    return CAAElementsPlanetaryOrbit::MarsLongitudeAscendingNodeJ2000(JD);
}

+ (double)MarsLongitudePerihelionJ2000:(double)JD
{
    return CAAElementsPlanetaryOrbit::MarsLongitudePerihelionJ2000(JD);
}


+ (double)JupiterMeanLongitudeJ2000:(double)JD
{
    return CAAElementsPlanetaryOrbit::JupiterMeanLongitudeJ2000(JD);
}

+ (double)JupiterInclinationJ2000:(double)JD
{
    return CAAElementsPlanetaryOrbit::JupiterInclinationJ2000(JD);
}

+ (double)JupiterLongitudeAscendingNodeJ2000:(double)JD
{
    return CAAElementsPlanetaryOrbit::JupiterLongitudeAscendingNodeJ2000(JD);
}

+ (double)JupiterLongitudePerihelionJ2000:(double)JD
{
    return CAAElementsPlanetaryOrbit::JupiterLongitudePerihelionJ2000(JD);
}


+ (double)SaturnMeanLongitudeJ2000:(double)JD
{
    return CAAElementsPlanetaryOrbit::SaturnMeanLongitudeJ2000(JD);
}

+ (double)SaturnInclinationJ2000:(double)JD
{
    return CAAElementsPlanetaryOrbit::SaturnInclinationJ2000(JD);
}

+ (double)SaturnLongitudeAscendingNodeJ2000:(double)JD
{
    return CAAElementsPlanetaryOrbit::SaturnLongitudeAscendingNodeJ2000(JD);
}

+ (double)SaturnLongitudePerihelionJ2000:(double)JD
{
    return CAAElementsPlanetaryOrbit::SaturnLongitudePerihelionJ2000(JD);
}


+ (double)UranusMeanLongitudeJ2000:(double)JD
{
    return CAAElementsPlanetaryOrbit::UranusMeanLongitudeJ2000(JD);
}

+ (double)UranusInclinationJ2000:(double)JD
{
    return CAAElementsPlanetaryOrbit::UranusInclinationJ2000(JD);
}

+ (double)UranusLongitudeAscendingNodeJ2000:(double)JD
{
    return CAAElementsPlanetaryOrbit::UranusLongitudeAscendingNodeJ2000(JD);
}

+ (double)UranusLongitudePerihelionJ2000:(double)JD
{
    return CAAElementsPlanetaryOrbit::UranusLongitudePerihelionJ2000(JD);
}


+ (double)NeptuneMeanLongitudeJ2000:(double)JD
{
    return CAAElementsPlanetaryOrbit::NeptuneMeanLongitudeJ2000(JD);
}

+ (double)NeptuneInclinationJ2000:(double)JD
{
    return CAAElementsPlanetaryOrbit::NeptuneInclinationJ2000(JD);
}

+ (double)NeptuneLongitudeAscendingNodeJ2000:(double)JD
{
    return CAAElementsPlanetaryOrbit::NeptuneLongitudeAscendingNodeJ2000(JD);
}

+ (double)NeptuneLongitudePerihelionJ2000:(double)JD
{
    return CAAElementsPlanetaryOrbit::NeptuneLongitudePerihelionJ2000(JD);
}


@end
