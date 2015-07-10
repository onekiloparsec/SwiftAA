//
//  KPCAARefraction.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 10/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KPCAARefraction : NSObject

// Standard Pressure = 1010
// Standard Temperature = 10

+ (double)RefractionFromApparentWithAltitude:(double)Altitude Pressure:(double)Pressure Temperature:(double)Temperature;
+ (double)RefractionFromTrueWithAltitude:(double)Altitude Pressure:(double)Pressure Temperature:(double)Temperature;

@end
