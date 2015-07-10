//
//  KPCAARefraction.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 10/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import "KPCAARefraction.h"
#import "AARefraction.h"

@implementation KPCAARefraction

+ (double)RefractionFromApparentWithAltitude:(double)Altitude Pressure:(double)Pressure Temperature:(double)Temperature
{
    return CAARefraction::RefractionFromApparent(Altitude, Pressure, Temperature);
}

+ (double)RefractionFromTrueWithAltitude:(double)Altitude Pressure:(double)Pressure Temperature:(double)Temperature
{
    return CAARefraction::RefractionFromTrue(Altitude, Pressure, Temperature);
}

@end
