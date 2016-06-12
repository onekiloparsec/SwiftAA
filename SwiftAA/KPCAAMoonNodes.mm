//
//  KPCAAMoonNodes.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 09/07/15.
//  Licensed under the MIT License (see LICENSE file)
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
