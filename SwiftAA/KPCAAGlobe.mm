//
//  KPCAAGlobe.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 08/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import "KPCAAGlobe.h"
#import "AAGlobe.h"

double KPCAAGlobeRhoSinThetaPrime(double GeographicalLatitude, double Height)
{
    return CAAGlobe::RhoSinThetaPrime(GeographicalLatitude, Height);
}

double KPCAAGlobeRhoCosThetaPrime(double GeographicalLatitude, double Height)
{
    return CAAGlobe::RhoCosThetaPrime(GeographicalLatitude, Height);
}

double KPCAAGlobeRadiusOfParallelOfLatitude(double GeographicalLatitude)
{
    return CAAGlobe::RadiusOfParallelOfLatitude(GeographicalLatitude);
}

double KPCAAGlobeRadiusOfCurvature(double GeographicalLatitude)
{
    return CAAGlobe::RadiusOfCurvature(GeographicalLatitude);
}

double KPCAAGlobeDistanceBetweenPoints(double GeographicalLatitude1,
                                       double GeographicalLongitude1,
                                       double GeographicalLatitude2,
                                       double GeographicalLongitude2)
{
    return CAAGlobe::DistanceBetweenPoints(GeographicalLatitude1, GeographicalLongitude1, GeographicalLatitude2, GeographicalLongitude2);
}

