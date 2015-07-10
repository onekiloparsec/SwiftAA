//
//  KPCAAPlanetPerihelionAphelion.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 10/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import "KPCAAPlanetPerihelionAphelion.h"
#import "AAPlanetPerihelionAphelion.h"

@implementation KPCAAPlanetPerihelionAphelion

+ (long)MercuryK:(double)Year
{
    return CAAPlanetPerihelionAphelion::MercuryK(Year);
}

+ (double)MercuryPerihelion:(long)k
{
    return CAAPlanetPerihelionAphelion::MercuryPerihelion(k);
}

+ (double)MercuryAphelion:(long)k
{
    return CAAPlanetPerihelionAphelion::MercuryAphelion(k);
}

+ (long)VenusK:(double)Year
{
    return CAAPlanetPerihelionAphelion::VenusK(Year);
}

+ (double)VenusPerihelion:(long)k
{
    return CAAPlanetPerihelionAphelion::VenusPerihelion(k);
}

+ (double)VenusAphelion:(long)k
{
    return CAAPlanetPerihelionAphelion::VenusAphelion(k);
}

+ (long)EarthK:(double)Year
{
    return CAAPlanetPerihelionAphelion::EarthK(Year);
}

+ (double)EarthPerihelion:(long)k barycentric:(BOOL)barycentric
{
    return CAAPlanetPerihelionAphelion::EarthPerihelion(k, barycentric);
}

+ (double)EarthAphelion:(long)k barycentric:(BOOL)barycentric
{
    return CAAPlanetPerihelionAphelion::EarthAphelion(k, barycentric);
}

+ (long)MarsK:(double)Year
{
    return CAAPlanetPerihelionAphelion::MarsK(Year);
}

+ (double)MarsPerihelion:(long)k
{
    return CAAPlanetPerihelionAphelion::MarsPerihelion(k);
}

+ (double)MarsAphelion:(long)k
{
    return CAAPlanetPerihelionAphelion::MarsAphelion(k);
}

+ (long)JupiterK:(double)Year
{
    return CAAPlanetPerihelionAphelion::JupiterK(Year);
}

+ (double)JupiterPerihelion:(long)k
{
    return CAAPlanetPerihelionAphelion::JupiterPerihelion(k);
}

+ (double)JupiterAphelion:(long)k
{
    return CAAPlanetPerihelionAphelion::JupiterAphelion(k);
}

+ (long)SaturnK:(double)Year
{
    return CAAPlanetPerihelionAphelion::SaturnK(Year);
}

+ (double)SaturnPerihelion:(long)k
{
    return CAAPlanetPerihelionAphelion::SaturnPerihelion(k);
}

+ (double)SaturnAphelion:(long)k
{
    return CAAPlanetPerihelionAphelion::SaturnAphelion(k);
}

+ (long)UranusK:(double)Year
{
    return CAAPlanetPerihelionAphelion::UranusK(Year);
}

+ (double)UranusPerihelion:(long)k
{
    return CAAPlanetPerihelionAphelion::UranusPerihelion(k);
}

+ (double)UranusAphelion:(long)k
{
    return CAAPlanetPerihelionAphelion::UranusAphelion(k);
}

+ (long)NeptuneK:(double)Year
{
    return CAAPlanetPerihelionAphelion::NeptuneK(Year);
}

+ (double)NeptunePerihelion:(long)k
{
    return CAAPlanetPerihelionAphelion::NeptunePerihelion(k);
}

+ (double)NeptuneAphelion:(long)k
{
    return CAAPlanetPerihelionAphelion::NeptuneAphelion(k);
}

@end
