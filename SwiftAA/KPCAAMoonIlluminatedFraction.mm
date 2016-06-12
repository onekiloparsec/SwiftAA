//
//  KPCAAMoonIlluminatedFraction.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 09/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import "KPCAAMoonIlluminatedFraction.h"
#import "AAMoonIlluminatedFraction.h"

@implementation KPCAAMoonIlluminatedFraction

+ (double)GeocentricElongation:(double)ObjectAlpha ObjectDelta:(double)ObjectDelta SunAlpha:(double)SunAlpha SunDelta:(double)SunDelta
{
    return CAAMoonIlluminatedFraction::GeocentricElongation(ObjectAlpha, ObjectDelta, SunAlpha, SunDelta);
}

+ (double)PhaseAngle:(double)GeocentricElongation EarthObjectDistance:(double)EarthObjectDistance EarthSunDistance:(double)EarthSunDistance
{
    return CAAMoonIlluminatedFraction::PhaseAngle(GeocentricElongation, EarthObjectDistance, EarthSunDistance);
}

+ (double)IlluminatedFraction:(double)PhaseAngle
{
    return CAAMoonIlluminatedFraction::IlluminatedFraction(PhaseAngle);
}

+ (double)PositionAngle:(double)Alpha0 Delta0:(double)Delta0 Alpha:(double)Alpha Delta:(double)Delta
{
    return CAAMoonIlluminatedFraction::PositionAngle(Alpha0, Delta0, Alpha, Delta);
}

@end
