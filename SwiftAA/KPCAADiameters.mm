//
//  KPCAADiameters.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 04/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import "KPCAADiameters.h"
#import "AADiameters.h"

double KPCAASunSemidiameterA(double Delta)
{
    return CAADiameters::SunSemidiameterA(Delta);
}

double KPCAAMercurySemidiameterA(double Delta)
{
    return CAADiameters::MercurySemidiameterA(Delta);
}

double KPCAAVenusSemidiameterA(double Delta)
{
    return CAADiameters::VenusSemidiameterA(Delta);
}

double KPCAAMarsSemidiameterA(double Delta)
{
    return CAADiameters::MarsSemidiameterA(Delta);
}

double KPCAAJupiterEquatorialSemidiameterA(double Delta)
{
    return CAADiameters::JupiterEquatorialSemidiameterA(Delta);
}

double KPCAAJupiterPolarSemidiameterA(double Delta)
{
    return CAADiameters::JupiterPolarSemidiameterA(Delta);
}

double KPCAASaturnEquatorialSemidiameterA(double Delta)
{
    return CAADiameters::SaturnEquatorialSemidiameterA(Delta);
}

double KPCAASaturnPolarSemidiameterA(double Delta)
{
    return CAADiameters::SaturnPolarSemidiameterA(Delta);
}

double KPCAAApparentSaturnPolarSemidiameterA(double Delta, double B)
{
    return CAADiameters::ApparentSaturnPolarSemidiameterA(Delta, B);
}

double KPCAAUranusSemidiameterA(double Delta)
{
    return CAADiameters::UranusSemidiameterA(Delta);
}

double KPCAANeptuneSemidiameterA(double Delta)
{
    return CAADiameters::NeptuneSemidiameterA(Delta);
}

// Bs

double KPCAAMercurySemidiameterB(double Delta)
{
    return CAADiameters::MercurySemidiameterB(Delta);
}

double KPCAAVenusSemidiameterB(double Delta)
{
    return CAADiameters::VenusSemidiameterB(Delta);
}

double KPCAAMarsSemidiameterB(double Delta)
{
    return CAADiameters::MarsSemidiameterB(Delta);
}

double KPCAAJupiterEquatorialSemidiameterB(double Delta)
{
    return CAADiameters::JupiterEquatorialSemidiameterB(Delta);
}

double KPCAAJupiterPolarSemidiameterB(double Delta)
{
    return CAADiameters::JupiterPolarSemidiameterB(Delta);
}

double KPCAASaturnEquatorialSemidiameterB(double Delta)
{
    return CAADiameters::SaturnEquatorialSemidiameterB(Delta);
}

double KPCAASaturnPolarSemidiameterB(double Delta)
{
    return CAADiameters::SaturnPolarSemidiameterB(Delta);
}

double KPCAAApparentSaturnPolarSemidiameterB(double Delta, double B)
{
    return CAADiameters::ApparentSaturnPolarSemidiameterB(Delta, B);
}

double KPCAAUranusSemidiameterB(double Delta)
{
    return CAADiameters::UranusSemidiameterB(Delta);
}

double KPCAANeptuneSemidiameterB(double Delta)
{
    return CAADiameters::NeptuneSemidiameterB(Delta);
}

double KPCAAPlutoSemidiameterB(double Delta)
{
    return CAADiameters::PlutoSemidiameterB(Delta);
}

// Others

double KPCAAGeocentricMoonSemidiameter(double Delta)
{
    return CAADiameters::GeocentricMoonSemidiameter(Delta);
}

double KPCAATopocentricMoonSemidiameter(double DistanceDelta, double Delta, double H, double Latitude, double Height)
{
    return CAADiameters::TopocentricMoonSemidiameter(DistanceDelta, Delta, H, Latitude, Height);
}

double KPCAAAsteroidDiameter(double H, double A)
{
    return CAADiameters::AsteroidDiameter(H, A);
}

double KPCAAApparentAsteroidDiameter(double H, double A)
{
    return CAADiameters::ApparentAsteroidDiameter(H, A);
}

