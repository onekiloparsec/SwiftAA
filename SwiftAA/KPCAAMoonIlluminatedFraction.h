//
//  KPCAAMoonIlluminatedFraction.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 09/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KPCAAMoonIlluminatedFraction : NSObject

+ (double)GeocentricElongation:(double)ObjectAlpha ObjectDelta:(double)ObjectDelta SunAlpha:(double)SunAlpha SunDelta:(double)SunDelta;

+ (double)PhaseAngle:(double)GeocentricElongation EarthObjectDistance:(double)EarthObjectDistance EarthSunDistance:(double)EarthSunDistance;

+ (double)IlluminatedFraction:(double)PhaseAngle;

+ (double)PositionAngle:(double)Alpha0 Delta0:(double)Delta0 Alpha:(double)Alpha Delta:(double)Delta;

@end
