//
//  KPCAAGlobe.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 08/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import "KPCAAGlobe.h"
#import "AAGlobe.h"

@implementation KPCAAGlobe

+ (double)RhoSinThetaPrime:(double)GeographicalLatitude height:(double)Height
{
    return CAAGlobe::RhoSinThetaPrime(GeographicalLatitude, Height);
}

+ (double)RhoCosThetaPrime:(double)GeographicalLatitude height:(double)Height
{
    return CAAGlobe::RhoCosThetaPrime(GeographicalLatitude, Height);
}

+ (double)RadiusOfParallelOfLatitude:(double)GeographicalLatitude
{
    return CAAGlobe::RadiusOfParallelOfLatitude(GeographicalLatitude);
}

+ (double)RadiusOfCurvature:(double)GeographicalLatitude
{
    return CAAGlobe::RadiusOfCurvature(GeographicalLatitude);
}

+ (double)DistanceBetweenPointsWithGeographicalLatitude1:(double)GeographicalLatitude1 GeographicalLongitude1:(double)GeographicalLongitude1 GeographicalLatitude2:(double)GeographicalLatitude2 GeographicalLongitude2:(double)GeographicalLongitude2
{
    return CAAGlobe::DistanceBetweenPoints(GeographicalLatitude1, GeographicalLongitude1, GeographicalLatitude2, GeographicalLongitude2);
}

@end
