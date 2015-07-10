//
//  KPCAAPlanetPerihelionAphelion.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 10/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KPCAAPlanetPerihelionAphelion : NSObject

+ (long)MercuryK:(double)Year;
+ (double)MercuryPerihelion:(long)k;
+ (double)MercuryAphelion:(long)k;

+ (long)VenusK:(double)Year;
+ (double)VenusPerihelion:(long)k;
+ (double)VenusAphelion:(long)k;

+ (long)EarthK:(double)Year;
+ (double)EarthPerihelion:(long)k barycentric:(BOOL)barycentric;
+ (double)EarthAphelion:(long)k barycentric:(BOOL)barycentric;

+ (long)MarsK:(double)Year;
+ (double)MarsPerihelion:(long)k;
+ (double)MarsAphelion:(long)k;

+ (long)JupiterK:(double)Year;
+ (double)JupiterPerihelion:(long)k;
+ (double)JupiterAphelion:(long)k;

+ (long)SaturnK:(double)Year;
+ (double)SaturnPerihelion:(long)k;
+ (double)SaturnAphelion:(long)k;

+ (long)UranusK:(double)Year;
+ (double)UranusPerihelion:(long)k;
+ (double)UranusAphelion:(long)k;

+ (long)NeptuneK:(double)Year;
+ (double)NeptunePerihelion:(long)k;
+ (double)NeptuneAphelion:(long)k;

@end
