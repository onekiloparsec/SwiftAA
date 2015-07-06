//
//  KPCAAEquinoxesAndSolstices.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 06/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import "KPCAAEquinoxesAndSolstices.h"
#import "AAEquinoxesAndSolstices.h"

@implementation KPCAAEquinoxesAndSolstices

+ (double)NorthwardEquinox:(long)Year
{
    return CAAEquinoxesAndSolstices::NorthwardEquinox(Year);
}

+ (double)NorthernSolstice:(long)Year
{
    return CAAEquinoxesAndSolstices::NorthernSolstice(Year);
}

+ (double)SouthwardEquinox:(long)Year
{
    return CAAEquinoxesAndSolstices::SouthwardEquinox(Year);
}

+ (double)SouthernSolstice:(long)Year
{
    return CAAEquinoxesAndSolstices::SouthernSolstice(Year);
}

+ (double)LengthOfSpring:(long)Year northernHemisphere:(BOOL)north
{
    return CAAEquinoxesAndSolstices::LengthOfSpring(Year, (bool)north);
}

+ (double)LengthOfSummer:(long)Year northernHemisphere:(BOOL)north
{
    return CAAEquinoxesAndSolstices::LengthOfSummer(Year, (bool)north);
}

+ (double)LengthOfAutumn:(long)Year northernHemisphere:(BOOL)north
{
    return CAAEquinoxesAndSolstices::LengthOfAutumn(Year, (bool)north);
}

+ (double)LengthOfWinter:(long)Year northernHemisphere:(BOOL)north
{
    return CAAEquinoxesAndSolstices::LengthOfWinter(Year, (bool)north);
}

@end
