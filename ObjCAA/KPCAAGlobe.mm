//
//  KPCAAGlobe.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 08/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import "KPCAAGlobe.h"
#import "AAGlobe.h"

double KPCAAGlobe_RhoSinThetaPrime(double GeographicalLatitude, double Height)
{
    return CAAGlobe::RhoSinThetaPrime(GeographicalLatitude, Height);
}

double KPCAAGlobe_RhoCosThetaPrime(double GeographicalLatitude, double Height)
{
    return CAAGlobe::RhoCosThetaPrime(GeographicalLatitude, Height);
}

double KPCAAGlobe_RadiusOfParallelOfLatitude(double GeographicalLatitude)
{
    return CAAGlobe::RadiusOfParallelOfLatitude(GeographicalLatitude);
}

double KPCAAGlobe_RadiusOfCurvature(double GeographicalLatitude)
{
    return CAAGlobe::RadiusOfCurvature(GeographicalLatitude);
}

double KPCAAGlobe_DistanceBetweenPoints(double GeographicalLatitude1,
                                       double GeographicalLongitude1,
                                       double GeographicalLatitude2,
                                       double GeographicalLongitude2)
{
    return CAAGlobe::DistanceBetweenPoints(GeographicalLatitude1, GeographicalLongitude1, GeographicalLatitude2, GeographicalLongitude2);
}

