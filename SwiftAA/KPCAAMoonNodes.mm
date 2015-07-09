//
//  KPCAAMoonNodes.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 09/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import "KPCAAMoonNodes.h"
#import "AAMoonNodes.h"

@implementation KPCAAMoonNodes

+ (double)K:(double)Year
{
    return CAAMoonNodes::K(Year);
}

+ (double)PassageThroNode:(double)k
{
    return CAAMoonNodes::PassageThroNode(k);
}

@end
