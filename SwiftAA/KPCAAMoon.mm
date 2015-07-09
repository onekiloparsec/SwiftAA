//
//  KPCAAMoon.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 09/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import "KPCAAMoon.h"
#import "AAMoon.h"

@implementation KPCAAMoon

+ (double)MeanLongitude:(double)JD
{
    return CAAMoon::MeanLongitude(JD);
}

+ (double)MeanElongation:(double)JD
{
    return CAAMoon::MeanElongation(JD);
}

+ (double)MeanAnomaly:(double)JD
{
    return CAAMoon::MeanAnomaly(JD);
}

+ (double)ArgumentOfLatitude:(double)JD
{
    return CAAMoon::ArgumentOfLatitude(JD);
}

+ (double)MeanLongitudeAscendingNode:(double)JD
{
    return CAAMoon::MeanLongitudeAscendingNode(JD);
}

+ (double)MeanLongitudePerigee:(double)JD
{
    return CAAMoon::MeanLongitudePerigee(JD);
}

+ (double)TrueLongitudeAscendingNode:(double)JD
{
    return CAAMoon::TrueLongitudeAscendingNode(JD);
}

+ (double)EclipticLongitude:(double)JD
{
    return CAAMoon::EclipticLongitude(JD);
}

+ (double)EclipticLatitude:(double)JD
{
    return CAAMoon::EclipticLatitude(JD);
}

+ (double)RadiusVector:(double)JD
{
    return CAAMoon::RadiusVector(JD);
}

+ (double)RadiusVectorToHorizontalParallax:(double)RadiusVector
{
    return CAAMoon::RadiusVectorToHorizontalParallax(RadiusVector);
}

+ (double)HorizontalParallaxToRadiusVector:(double)Parallax
{
    return CAAMoon::HorizontalParallaxToRadiusVector(Parallax);
}

@end
