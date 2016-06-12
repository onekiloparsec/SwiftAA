//
//  KPCAARefraction.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 10/07/15.
//  Licensed under the MIT License (see LICENSE file)
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
