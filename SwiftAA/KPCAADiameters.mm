//
//  KPCAADiameters.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 04/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import "KPCAADiameters.h"
#import "AADiameters.h"

@implementation KPCAADiameters

+ (double)SunSemidiameterA:(double)Delta
{
    return CAADiameters::SunSemidiameterA(Delta);
}

+ (double)MercurySemidiameterA:(double)Delta
{
    return CAADiameters::MercurySemidiameterA(Delta);
}

+ (double)VenusSemidiameterA:(double)Delta
{
    return CAADiameters::VenusSemidiameterA(Delta);
}

+ (double)MarsSemidiameterA:(double)Delta
{
    return CAADiameters::MarsSemidiameterA(Delta);
}

+ (double)JupiterEquatorialSemidiameterA:(double)Delta
{
    return CAADiameters::JupiterEquatorialSemidiameterA(Delta);
}
+ (double)JupiterPolarSemidiameterA:(double)Delta
{
    return CAADiameters::JupiterPolarSemidiameterA(Delta);
}

+ (double)SaturnEquatorialSemidiameterA:(double)Delta
{
    return CAADiameters::SaturnEquatorialSemidiameterA(Delta);
}

+ (double)SaturnPolarSemidiameterA:(double)Delta
{
    return CAADiameters::SaturnPolarSemidiameterA(Delta);
}

+ (double)ApparentSaturnPolarSemidiameterA:(double)Delta B:(double)B
{
    return CAADiameters::ApparentSaturnPolarSemidiameterA(Delta, B);
}

+ (double)UranusSemidiameterA:(double)Delta
{
    return CAADiameters::UranusSemidiameterA(Delta);
}

+ (double)NeptuneSemidiameterA:(double)Delta
{
    return CAADiameters::NeptuneSemidiameterA(Delta);
}

// Bs

+ (double)MercurySemidiameterB:(double)Delta
{
    return CAADiameters::MercurySemidiameterB(Delta);
}

+ (double)VenusSemidiameterB:(double)Delta
{
    return CAADiameters::VenusSemidiameterB(Delta);
}

+ (double)MarsSemidiameterB:(double)Delta
{
    return CAADiameters::MarsSemidiameterB(Delta);
}

+ (double)JupiterEquatorialSemidiameterB:(double)Delta
{
    return CAADiameters::JupiterEquatorialSemidiameterB(Delta);
}

+ (double)JupiterPolarSemidiameterB:(double)Delta
{
    return CAADiameters::JupiterPolarSemidiameterB(Delta);
}

+ (double)SaturnEquatorialSemidiameterB:(double)Delta
{
    return CAADiameters::SaturnEquatorialSemidiameterB(Delta);
}

+ (double)SaturnPolarSemidiameterB:(double)Delta
{
    return CAADiameters::SaturnPolarSemidiameterB(Delta);
}

+ (double)ApparentSaturnPolarSemidiameterB:(double)Delta B:(double)B
{
    return CAADiameters::ApparentSaturnPolarSemidiameterB(Delta, B);
}

+ (double)UranusSemidiameterB:(double)Delta
{
    return CAADiameters::UranusSemidiameterB(Delta);
}

+ (double)NeptuneSemidiameterB:(double)Delta
{
    return CAADiameters::NeptuneSemidiameterB(Delta);
}

+ (double)PlutoSemidiameterB:(double)Delta
{
    return CAADiameters::PlutoSemidiameterB(Delta);
}

// Others

+ (double)GeocentricMoonSemidiameter:(double)Delta
{
    return CAADiameters::GeocentricMoonSemidiameter(Delta);
}

+ (double)TopocentricMoonSemidiameter:(double)DistanceDelta Delta:(double)Delta H:(double)H latitude:(double)Latitude height:(double)Height
{
    return CAADiameters::TopocentricMoonSemidiameter(DistanceDelta, Delta, H, Latitude, Height);
}

+ (double)AsteroidDiameter:(double)H A:(double)A
{
    return CAADiameters::AsteroidDiameter(H, A);
}

+ (double)ApparentAsteroidDiameter:(double)H A:(double)A
{
    return CAADiameters::ApparentAsteroidDiameter(H, A);
}

@end
