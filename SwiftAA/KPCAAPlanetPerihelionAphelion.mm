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

long KPCAAPlanetPerihelionAphelion_K(double Year, KPCAAPlanetStrict planet)
{
    switch (planet) {
        case Mercury:
            return KPCAAPlanetPerihelionAphelion_MercuryK(Year);
            break;
        case Venus:
            return KPCAAPlanetPerihelionAphelion_VenusK(Year);
            break;
        case Earth:
            return KPCAAPlanetPerihelionAphelion_EarthK(Year);
            break;
        case Mars:
            return KPCAAPlanetPerihelionAphelion_MarsK(Year);
            break;
        case Jupiter:
            return KPCAAPlanetPerihelionAphelion_JupiterK(Year);
            break;
        case Saturn:
            return KPCAAPlanetPerihelionAphelion_SaturnK(Year);
            break;
        case Uranus:
            return KPCAAPlanetPerihelionAphelion_UranusK(Year);
            break;
        case Neptune:
            return KPCAAPlanetPerihelionAphelion_NeptuneK(Year);
            break;
        default:
            return 0;
            break;
    }
}

double KPCAAPlanetPerihelionAphelion_Perihelion(long k, KPCAAPlanetStrict planet)
{
    switch (planet) {
        case Mercury:
            return KPCAAPlanetPerihelionAphelion_MercuryPerihelion(k);
            break;
        case Venus:
            return KPCAAPlanetPerihelionAphelion_VenusPerihelion(k);
            break;
        case Earth:
            return KPCAAPlanetPerihelionAphelion_EarthPerihelion(k, YES);
            break;
        case Mars:
            return KPCAAPlanetPerihelionAphelion_MarsPerihelion(k);
            break;
        case Jupiter:
            return KPCAAPlanetPerihelionAphelion_JupiterPerihelion(k);
            break;
        case Saturn:
            return KPCAAPlanetPerihelionAphelion_SaturnPerihelion(k);
            break;
        case Uranus:
            return KPCAAPlanetPerihelionAphelion_UranusPerihelion(k);
            break;
        case Neptune:
            return KPCAAPlanetPerihelionAphelion_NeptunePerihelion(k);
            break;
        default:
            return 0;
            break;
    }
}

double KPCAAPlanetPerihelionAphelion_Aphelion(long k, KPCAAPlanetStrict planet)
{
    switch (planet) {
        case Mercury:
            return KPCAAPlanetPerihelionAphelion_MercuryAphelion(k);
            break;
        case Venus:
            return KPCAAPlanetPerihelionAphelion_VenusAphelion(k);
            break;
        case Earth:
            return KPCAAPlanetPerihelionAphelion_EarthAphelion(k, YES);
            break;
        case Mars:
            return KPCAAPlanetPerihelionAphelion_MarsAphelion(k);
            break;
        case Jupiter:
            return KPCAAPlanetPerihelionAphelion_JupiterAphelion(k);
            break;
        case Saturn:
            return KPCAAPlanetPerihelionAphelion_SaturnAphelion(k);
            break;
        case Uranus:
            return KPCAAPlanetPerihelionAphelion_UranusAphelion(k);
            break;
        case Neptune:
            return KPCAAPlanetPerihelionAphelion_NeptuneAphelion(k);
            break;
        default:
            return 0;
            break;
    }
}

