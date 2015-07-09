//
//  KPCAAIlluminatedFraction.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 09/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import "KPCAAIlluminatedFraction.h"
#import "AAIlluminatedFraction.h"

@implementation KPCAAIlluminatedFraction

+ (double)PhaseAngle:(double)r R:(double)R Delta:(double)Delta
{
    return CAAIlluminatedFraction::PhaseAngle(r, R, Delta);
}

+ (double)PhaseAngle:(double)R R0:(double)R0 B:(double)B L:(double)L L:(double)L0 Delta:(double)Delta
{
    return CAAIlluminatedFraction::PhaseAngle(R, R0, B, L, L0, Delta);
}

+ (double)PhaseAngleRectangular:(double)x y:(double)y z:(double)z B:(double)B L:(double)L Delta:(double)Delta
{
    return CAAIlluminatedFraction::PhaseAngleRectangular(x, y, z, B, L, Delta);
}

+ (double)IlluminatedFraction:(double)PhaseAngle
{
    return CAAIlluminatedFraction::IlluminatedFraction(PhaseAngle);
}

+ (double)IlluminatedFraction:(double)r R:(double)R Delta:(double)Delta
{
    return CAAIlluminatedFraction::IlluminatedFraction(r, R, Delta);
}

+ (double)MercuryMagnitudeMuller:(double)r Delta:(double)Delta i:(double)i
{
    return CAAIlluminatedFraction::MercuryMagnitudeMuller(r, Delta, i);
}

+ (double)VenusMagnitudeMuller:(double)r Delta:(double)Delta i:(double)i
{
    return CAAIlluminatedFraction::VenusMagnitudeMuller(r, Delta, i);
}

+ (double)MarsMagnitudeMuller:(double)r Delta:(double)Delta i:(double)i
{
    return CAAIlluminatedFraction::MarsMagnitudeMuller(r, Delta, i);
}

+ (double)JupiterMagnitudeMuller:(double)r Delta:(double)Delta
{
    return CAAIlluminatedFraction::JupiterMagnitudeMuller(r, Delta);
}

+ (double)SaturnMagnitudeMuller:(double)r Delta:(double)Delta DeltaU:(double)DeltaU B:(double)B
{
    return CAAIlluminatedFraction::SaturnMagnitudeMuller(r, Delta, DeltaU, B);
}

+ (double)UranusMagnitudeMuller:(double)r Delta:(double)Delta
{
    return CAAIlluminatedFraction::UranusMagnitudeMuller(r, Delta);
}

+ (double)NeptuneMagnitudeMuller:(double)r Delta:(double)Delta
{
    return CAAIlluminatedFraction::NeptuneMagnitudeMuller(r, Delta);
}

+ (double)MercuryMagnitudeAA:(double)r Delta:(double)Delta i:(double)i
{
    return CAAIlluminatedFraction::MercuryMagnitudeAA(r, Delta, i);
}

+ (double)VenusMagnitudeAA:(double)r Delta:(double)Delta i:(double)i
{
    return CAAIlluminatedFraction::VenusMagnitudeAA(r, Delta, i);
}

+ (double)MarsMagnitudeAA:(double)r Delta:(double)Delta i:(double)i
{
    return CAAIlluminatedFraction::MarsMagnitudeAA(r, Delta, i);
}

+ (double)JupiterMagnitudeAA:(double)r Delta:(double)Delta i:(double)i
{
    return CAAIlluminatedFraction::JupiterMagnitudeAA(r, Delta, i);
}

+ (double)SaturnMagnitudeAA:(double)r Delta:(double)Delta DeltaU:(double)DeltaU B:(double)B
{
    return CAAIlluminatedFraction::SaturnMagnitudeAA(r, Delta, DeltaU, B);
}

+ (double)UranusMagnitudeAA:(double)r Delta:(double)Delta
{
    return CAAIlluminatedFraction::UranusMagnitudeAA(r, Delta);
}

+ (double)NeptuneMagnitudeAA:(double)r Delta:(double)Delta
{
    return CAAIlluminatedFraction::NeptuneMagnitudeAA(r, Delta);
}

+ (double)PlutoMagnitudeAA:(double)r Delta:(double)Delta
{
    return CAAIlluminatedFraction::PlutoMagnitudeAA(r, Delta);
}


@end
