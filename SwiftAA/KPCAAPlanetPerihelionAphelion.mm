//
//  KPCAAPlanetPerihelionAphelion.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 10/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import "KPCAAPlanetPerihelionAphelion.h"
#import "AAPlanetPerihelionAphelion.h"


long KPCAAPlanetPerihelionAphelion_MercuryK(double Year)
{
    return CAAPlanetPerihelionAphelion::MercuryK(Year);
}

double KPCAAPlanetPerihelionAphelion_MercuryPerihelion(long k)
{
    return CAAPlanetPerihelionAphelion::MercuryPerihelion(k);
}

double KPCAAPlanetPerihelionAphelion_MercuryAphelion(long k)
{
    return CAAPlanetPerihelionAphelion::MercuryAphelion(k);
}


long KPCAAPlanetPerihelionAphelion_VenusK(double Year)
{
    return CAAPlanetPerihelionAphelion::VenusK(Year);
}

double KPCAAPlanetPerihelionAphelion_VenusPerihelion(long k)
{
    return CAAPlanetPerihelionAphelion::VenusPerihelion(k);
}

double KPCAAPlanetPerihelionAphelion_VenusAphelion(long k)
{
    return CAAPlanetPerihelionAphelion::VenusAphelion(k);
}


long KPCAAPlanetPerihelionAphelion_EarthK(double Year)
{
    return CAAPlanetPerihelionAphelion::EarthK(Year);
}

double KPCAAPlanetPerihelionAphelion_EarthPerihelion(long k, BOOL barycentric)
{
    return CAAPlanetPerihelionAphelion::EarthPerihelion(k, barycentric);
}

double KPCAAPlanetPerihelionAphelion_EarthAphelion(long k, BOOL barycentric)
{
    return CAAPlanetPerihelionAphelion::EarthAphelion(k, barycentric);
}


long KPCAAPlanetPerihelionAphelion_MarsK(double Year)
{
    return CAAPlanetPerihelionAphelion::MarsK(Year);
}

double KPCAAPlanetPerihelionAphelion_MarsPerihelion(long k)
{
    return CAAPlanetPerihelionAphelion::MarsPerihelion(k);
}

double KPCAAPlanetPerihelionAphelion_MarsAphelion(long k)
{
    return CAAPlanetPerihelionAphelion::MarsAphelion(k);
}


long KPCAAPlanetPerihelionAphelion_JupiterK(double Year)
{
    return CAAPlanetPerihelionAphelion::JupiterK(Year);
}

double KPCAAPlanetPerihelionAphelion_JupiterPerihelion(long k)
{
    return CAAPlanetPerihelionAphelion::JupiterPerihelion(k);
}

double KPCAAPlanetPerihelionAphelion_JupiterAphelion(long k)
{
    return CAAPlanetPerihelionAphelion::JupiterAphelion(k);
}


long KPCAAPlanetPerihelionAphelion_SaturnK(double Year)
{
    return CAAPlanetPerihelionAphelion::SaturnK(Year);
}

double KPCAAPlanetPerihelionAphelion_SaturnPerihelion(long k)
{
    return CAAPlanetPerihelionAphelion::SaturnPerihelion(k);
}

double KPCAAPlanetPerihelionAphelion_SaturnAphelion(long k)
{
    return CAAPlanetPerihelionAphelion::SaturnAphelion(k);
}


long KPCAAPlanetPerihelionAphelion_UranusK(double Year)
{
    return CAAPlanetPerihelionAphelion::UranusK(Year);
}

double KPCAAPlanetPerihelionAphelion_UranusPerihelion(long k)
{
    return CAAPlanetPerihelionAphelion::UranusPerihelion(k);
}

double KPCAAPlanetPerihelionAphelion_UranusAphelion(long k)
{
    return CAAPlanetPerihelionAphelion::UranusAphelion(k);
}


long KPCAAPlanetPerihelionAphelion_NeptuneK(double Year)
{
    return CAAPlanetPerihelionAphelion::NeptuneK(Year);
}

double KPCAAPlanetPerihelionAphelion_NeptunePerihelion(long k)
{
    return CAAPlanetPerihelionAphelion::NeptunePerihelion(k);
}

double KPCAAPlanetPerihelionAphelion_NeptuneAphelion(long k)
{
    return CAAPlanetPerihelionAphelion::NeptuneAphelion(k);
}
