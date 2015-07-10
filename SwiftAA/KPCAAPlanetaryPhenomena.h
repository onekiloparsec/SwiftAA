//
//  KPCAAPlanetaryPhenomena.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 10/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, KPCPlanetaryObject) {
    MERCURY,
    VENUS,
    MARS,
    JUPITER,
    SATURN,
    URANUS,
    NEPTUNE
};

typedef NS_ENUM(NSUInteger, KPCPlanetaryEventType) {
    INFERIOR_CONJUNCTION,
    SUPERIOR_CONJUNCTION,
    OPPOSITION,
    CONJUNCTION,
    EASTERN_ELONGATION,
    WESTERN_ELONGATION,
    STATION1,
    STATION2
};

@interface KPCAAPlanetaryPhenomena : NSObject

+ (double)K:(double)Year object:(KPCPlanetaryObject)object eventType:(KPCPlanetaryEventType)type;
+ (double)Mean:(double)k object:(KPCPlanetaryObject)object eventType:(KPCPlanetaryEventType)type;
+ (double)True:(double)k object:(KPCPlanetaryObject)object eventType:(KPCPlanetaryEventType)type;
+ (double)ElongationValue:(double)k object:(KPCPlanetaryObject)object eastern:(BOOL)eastern;

@end
