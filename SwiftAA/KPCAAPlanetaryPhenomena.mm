//
//  KPCAAPlanetaryPhenomena.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 10/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import "KPCAAPlanetaryPhenomena.h"
#import "AAPlanetaryPhenomena.h"

@implementation KPCAAPlanetaryPhenomena

+ (double)K:(double)Year object:(KPCPlanetaryObject)object eventType:(KPCPlanetaryEventType)type
{
    return CAAPlanetaryPhenomena::K(Year, (CAAPlanetaryPhenomena::PlanetaryObject)object, (CAAPlanetaryPhenomena::EventType)type);
}

+ (double)Mean:(double)k object:(KPCPlanetaryObject)object eventType:(KPCPlanetaryEventType)type
{
    return CAAPlanetaryPhenomena::Mean(k, (CAAPlanetaryPhenomena::PlanetaryObject)object, (CAAPlanetaryPhenomena::EventType)type);
}

+ (double)True:(double)k object:(KPCPlanetaryObject)object eventType:(KPCPlanetaryEventType)type
{
    return CAAPlanetaryPhenomena::True(k, (CAAPlanetaryPhenomena::PlanetaryObject)object, (CAAPlanetaryPhenomena::EventType)type);
}

+ (double)ElongationValue:(double)k object:(KPCPlanetaryObject)object eastern:(BOOL)eastern
{
    return CAAPlanetaryPhenomena::ElongationValue(k, (CAAPlanetaryPhenomena::PlanetaryObject)object, (bool)eastern);
}

@end
