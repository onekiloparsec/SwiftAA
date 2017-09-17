//
//  KPCAADiameters.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 04/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import "KPCAADiameters.h"
#import "AADiameters.h"

double KPCAADiameters_SunSemidiameterA(double Delta)
{
    return CAADiameters::SunSemidiameterA(Delta);
}

double KPCAADiameters_MercurySemidiameterA(double Delta)
{
    return CAADiameters::MercurySemidiameterA(Delta);
}

double KPCAADiameters_VenusSemidiameterA(double Delta)
{
    return CAADiameters::VenusSemidiameterA(Delta);
}

double KPCAADiameters_MarsSemidiameterA(double Delta)
{
    return CAADiameters::MarsSemidiameterA(Delta);
}

double KPCAADiameters_JupiterEquatorialSemidiameterA(double Delta)
{
    return CAADiameters::JupiterEquatorialSemidiameterA(Delta);
}

double KPCAADiameters_JupiterPolarSemidiameterA(double Delta)
{
    return CAADiameters::JupiterPolarSemidiameterA(Delta);
}

double KPCAADiameters_SaturnEquatorialSemidiameterA(double Delta)
{
    return CAADiameters::SaturnEquatorialSemidiameterA(Delta);
}

double KPCAADiameters_SaturnPolarSemidiameterA(double Delta)
{
    return CAADiameters::SaturnPolarSemidiameterA(Delta);
}

double KPCAADiameters_ApparentSaturnPolarSemidiameterA(double Delta, double B)
{
    return CAADiameters::ApparentSaturnPolarSemidiameterA(Delta, B);
}

double KPCAADiameters_UranusSemidiameterA(double Delta)
{
    return CAADiameters::UranusSemidiameterA(Delta);
}

double KPCAADiameters_NeptuneSemidiameterA(double Delta)
{
    return CAADiameters::NeptuneSemidiameterA(Delta);
}

// Bs

double KPCAADiameters_MercurySemidiameterB(double Delta)
{
    return CAADiameters::MercurySemidiameterB(Delta);
}

double KPCAADiameters_VenusSemidiameterB(double Delta)
{
    return CAADiameters::VenusSemidiameterB(Delta);
}

double KPCAADiameters_MarsSemidiameterB(double Delta)
{
    return CAADiameters::MarsSemidiameterB(Delta);
}

double KPCAADiameters_JupiterEquatorialSemidiameterB(double Delta)
{
    return CAADiameters::JupiterEquatorialSemidiameterB(Delta);
}

double KPCAADiameters_JupiterPolarSemidiameterB(double Delta)
{
    return CAADiameters::JupiterPolarSemidiameterB(Delta);
}

double KPCAADiameters_SaturnEquatorialSemidiameterB(double Delta)
{
    return CAADiameters::SaturnEquatorialSemidiameterB(Delta);
}

double KPCAADiameters_SaturnPolarSemidiameterB(double Delta)
{
    return CAADiameters::SaturnPolarSemidiameterB(Delta);
}

double KPCAADiameters_ApparentSaturnPolarSemidiameterB(double Delta, double B)
{
    return CAADiameters::ApparentSaturnPolarSemidiameterB(Delta, B);
}

double KPCAADiameters_UranusSemidiameterB(double Delta)
{
    return CAADiameters::UranusSemidiameterB(Delta);
}

double KPCAADiameters_NeptuneSemidiameterB(double Delta)
{
    return CAADiameters::NeptuneSemidiameterB(Delta);
}

double KPCAADiameters_PlutoSemidiameterB(double Delta)
{
    return CAADiameters::PlutoSemidiameterB(Delta);
}

// Others

double KPCAADiameters_GeocentricMoonSemidiameter(double Delta)
{
    return CAADiameters::GeocentricMoonSemidiameter(Delta);
}

double KPCAADiameters_TopocentricMoonSemidiameter(double DistanceDelta, double Delta, double H, double Latitude, double Height)
{
    return CAADiameters::TopocentricMoonSemidiameter(DistanceDelta, Delta, H, Latitude, Height);
}

double KPCAADiameters_AsteroidDiameter(double H, double A)
{
    return CAADiameters::AsteroidDiameter(H, A);
}

double KPCAADiameters_ApparentAsteroidDiameter(double H, double A)
{
    return CAADiameters::ApparentAsteroidDiameter(H, A);
}

double KPCAADiameters_EquatorialSemiDiameterB(KPCAAPlanet planet, double Delta)
{
    switch (planet) {
        case Mercury: {
            return KPCAADiameters_MercurySemidiameterB(Delta);
            break;
        }
        case Venus: {
            return KPCAADiameters_VenusSemidiameterB(Delta);
            break;
        }
        case Mars: {
            return KPCAADiameters_MarsSemidiameterB(Delta);
            break;
        }
        case Jupiter: {
            return KPCAADiameters_JupiterEquatorialSemidiameterB(Delta);
            break;
        }
        case Saturn: {
            return KPCAADiameters_SaturnEquatorialSemidiameterB(Delta);
            break;
        }
        case Uranus: {
            return KPCAADiameters_UranusSemidiameterB(Delta);
            break;
        }
        case Neptune: {
            return KPCAADiameters_NeptuneSemidiameterB(Delta);
            break;
        }
        case Pluto: {
            return KPCAADiameters_PlutoSemidiameterB(Delta);
            break;
        }
        default:
            [NSException raise:NSInvalidArgumentException format:@"Invalid planet type %li", (long)planet];
            return 0.0;
            break;
    }
}

double KPCAADiameters_PolarSemiDiameterB(KPCAAPlanet planet, double Delta)
{
    switch (planet) {
        case Mercury: {
            return KPCAADiameters_MercurySemidiameterB(Delta);
            break;
        }
        case Venus: {
            return KPCAADiameters_VenusSemidiameterB(Delta);
            break;
        }
        case Mars: {
            return KPCAADiameters_MarsSemidiameterB(Delta);
            break;
        }
        case Jupiter: {
            return KPCAADiameters_JupiterPolarSemidiameterB(Delta);
            break;
        }
        case Saturn: {
            return KPCAADiameters_SaturnPolarSemidiameterB(Delta);
            break;
        }
        case Uranus: {
            return KPCAADiameters_UranusSemidiameterB(Delta);
            break;
        }
        case Neptune: {
            return KPCAADiameters_NeptuneSemidiameterB(Delta);
            break;
        }
        case Pluto: {
            return KPCAADiameters_PlutoSemidiameterB(Delta);
            break;
        }
        default:
            [NSException raise:NSInvalidArgumentException format:@"Invalid planet type %li", (long)planet];
            return 0.0;
            break;
    }
}
