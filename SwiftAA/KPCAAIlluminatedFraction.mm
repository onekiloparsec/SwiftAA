//
//  KPCAAIlluminatedFraction.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 09/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import "KPCAAIlluminatedFraction.h"
#import "AAIlluminatedFraction.h"


double KPCAAIlluminatedFraction_PhaseAngle(double r, double R, double Delta)
{
    return CAAIlluminatedFraction::PhaseAngle(r, R, Delta);
}

double KPCAAIlluminatedFraction_PhaseAngle_bis(double R, double R0, double B, double L, double L0, double Delta)
{
    return CAAIlluminatedFraction::PhaseAngle(R, R0, B, L, L0, Delta);
}

double KPCAAIlluminatedFraction_PhaseAngleRectangular(double x, double y, double z, double B, double L, double Delta)
{
    return CAAIlluminatedFraction::PhaseAngleRectangular(x, y, z, B, L, Delta);
}

double KPCAAIlluminatedFraction_IlluminatedFraction(double PhaseAngle)
{
    return CAAIlluminatedFraction::IlluminatedFraction(PhaseAngle);
}

double KPCAAIlluminatedFraction_IlluminatedFraction_bis(double r, double R, double Delta)
{
    return CAAIlluminatedFraction::IlluminatedFraction(r, R, Delta);
}


double KPCAAIlluminatedFraction_MercuryMagnitudeMuller(double r, double Delta, double i)
{
    return CAAIlluminatedFraction::MercuryMagnitudeMuller(r, Delta, i);
}

double KPCAAIlluminatedFraction_VenusMagnitudeMuller(double r, double Delta, double i)
{
    return CAAIlluminatedFraction::VenusMagnitudeMuller(r, Delta, i);
}

double KPCAAIlluminatedFraction_MarsMagnitudeMuller(double r, double Delta, double i)
{
    return CAAIlluminatedFraction::MarsMagnitudeMuller(r, Delta, i);
}

double KPCAAIlluminatedFraction_JupiterMagnitudeMuller(double r, double Delta)
{
    return CAAIlluminatedFraction::JupiterMagnitudeMuller(r, Delta);
}

double KPCAAIlluminatedFraction_SaturnMagnitudeMuller(double r, double Delta, double DeltaU, double B)
{
    return CAAIlluminatedFraction::SaturnMagnitudeMuller(r, Delta, DeltaU, B);
}

double KPCAAIlluminatedFraction_UranusMagnitudeMuller(double r, double Delta)
{
    return CAAIlluminatedFraction::UranusMagnitudeMuller(r, Delta);
}

double KPCAAIlluminatedFraction_NeptuneMagnitudeMuller(double r, double Delta)
{
    return CAAIlluminatedFraction::NeptuneMagnitudeMuller(r, Delta);
}


double KPCAAIlluminatedFraction_MercuryMagnitudeAA(double r, double Delta, double i)
{
    return CAAIlluminatedFraction::MercuryMagnitudeAA(r, Delta, i);
}

double KPCAAIlluminatedFraction_VenusMagnitudeAA(double r, double Delta, double i)
{
    return CAAIlluminatedFraction::VenusMagnitudeAA(r, Delta, i);
}

double KPCAAIlluminatedFraction_MarsMagnitudeAA(double r, double Delta, double i)
{
    return CAAIlluminatedFraction::MarsMagnitudeAA(r, Delta, i);
}

double KPCAAIlluminatedFraction_JupiterMagnitudeAA(double r, double Delta, double i)
{
    return CAAIlluminatedFraction::JupiterMagnitudeAA(r, Delta, i);
}

double KPCAAIlluminatedFraction_SaturnMagnitudeAA(double r, double Delta, double DeltaU, double B)
{
    return CAAIlluminatedFraction::SaturnMagnitudeAA(r, Delta, DeltaU, B);
}

double KPCAAIlluminatedFraction_UranusMagnitudeAA(double r, double Delta)
{
    return CAAIlluminatedFraction::UranusMagnitudeAA(r, Delta);
}

double KPCAAIlluminatedFraction_NeptuneMagnitudeAA(double r, double Delta)
{
    return CAAIlluminatedFraction::NeptuneMagnitudeAA(r, Delta);
}


double KPCAAIlluminatedFraction_MagnitudeMuller(KPCPlanetaryObject planet, double r, double Delta, double i)
{
    switch (planet) {
        case MERCURY:
            return KPCAAIlluminatedFraction_MercuryMagnitudeMuller(r, Delta, i);
            break;
        case VENUS:
            return KPCAAIlluminatedFraction_VenusMagnitudeMuller(r, Delta, i);
            break;
        case MARS:
            return KPCAAIlluminatedFraction_MarsMagnitudeMuller(r, Delta, i);
            break;
        case JUPITER:
            return KPCAAIlluminatedFraction_JupiterMagnitudeMuller(r, Delta);
            break;
        case SATURN:
            return NAN;
            break;
        case URANUS:
            return KPCAAIlluminatedFraction_UranusMagnitudeMuller(r, Delta);
            break;
        case NEPTUNE:
            return KPCAAIlluminatedFraction_NeptuneMagnitudeMuller(r, Delta);
            break;
        default:
            return NAN;
    }
}

double KPCAAIlluminatedFraction_MagnitudeAA(KPCPlanetaryObject planet, double r, double Delta, double i)
{
    switch (planet) {
        case MERCURY:
            return KPCAAIlluminatedFraction_MercuryMagnitudeAA(r, Delta, i);
            break;
        case VENUS:
            return KPCAAIlluminatedFraction_VenusMagnitudeAA(r, Delta, i);
            break;
        case MARS:
            return KPCAAIlluminatedFraction_MarsMagnitudeAA(r, Delta, i);
            break;
        case JUPITER:
            return KPCAAIlluminatedFraction_JupiterMagnitudeAA(r, Delta, i);
            break;
        case SATURN:
            return NAN;
            break;
        case URANUS:
            return KPCAAIlluminatedFraction_UranusMagnitudeAA(r, Delta);
            break;
        case NEPTUNE:
            return KPCAAIlluminatedFraction_NeptuneMagnitudeAA(r, Delta);
            break;
        default:
            return NAN;
    }
}

