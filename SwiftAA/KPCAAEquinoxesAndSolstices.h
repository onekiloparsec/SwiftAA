//
//  KPCAAEquinoxesAndSolstices.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 06/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KPCAAEquinoxesAndSolstices : NSObject

+ (double)NorthwardEquinox:(long)Year;
+ (double)NorthernSolstice:(long)Year;
+ (double)SouthwardEquinox:(long)Year;
+ (double)SouthernSolstice:(long)Year;

+ (double)LengthOfSpring:(long)Year northernHemisphere:(BOOL)north;
+ (double)LengthOfSummer:(long)Year northernHemisphere:(BOOL)north;
+ (double)LengthOfAutumn:(long)Year northernHemisphere:(BOOL)north;
+ (double)LengthOfWinter:(long)Year northernHemisphere:(BOOL)north;

@end
