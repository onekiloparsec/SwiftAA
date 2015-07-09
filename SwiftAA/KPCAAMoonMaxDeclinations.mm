//
//  KPCAAMoonMaxDeclinations.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 09/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import "KPCAAMoonMaxDeclinations.h"
#import "AAMoonMaxDeclinations.h"

@implementation KPCAAMoonMaxDeclinations

+ (double)K:(double)Year
{
    return CAAMoonMaxDeclinations::K(Year);
}

+ (double)MeanGreatestDeclination:(double)k northerly:(BOOL)northerly
{
    return CAAMoonMaxDeclinations::MeanGreatestDeclination(k, (bool)northerly);
}

+ (double)MeanGreatestDeclinationValue:(double)k
{
    return CAAMoonMaxDeclinations::MeanGreatestDeclinationValue(k);
}

+ (double)TrueGreatestDeclination:(double)k northerly:(BOOL)northerly
{
    return CAAMoonMaxDeclinations::TrueGreatestDeclination(k, northerly);
}

+ (double)TrueGreatestDeclinationValue:(double)k northerly:(BOOL)northerly
{
    return CAAMoonMaxDeclinations::TrueGreatestDeclinationValue(k, (BOOL)northerly);
}

@end
