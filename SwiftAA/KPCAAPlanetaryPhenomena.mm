//
//  KPCAAPlanetaryPhenomena.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 10/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import "KPCAAPlanetaryPhenomena.h"
#import "AAPlanetaryPhenomena.h"

double KPCAAPlanetaryPhenomena_K(double Year, KPCPlanetaryObject object, KPCPlanetaryEventType type)
{
    return CAAPlanetaryPhenomena::K(Year, (CAAPlanetaryPhenomena::PlanetaryObject)object, (CAAPlanetaryPhenomena::EventType)type);
}

double KPCAAPlanetaryPhenomena_Mean(double k, KPCPlanetaryObject object, KPCPlanetaryEventType type)
{
    return CAAPlanetaryPhenomena::Mean(k, (CAAPlanetaryPhenomena::PlanetaryObject)object, (CAAPlanetaryPhenomena::EventType)type);
}

double KPCAAPlanetaryPhenomena_True(double k, KPCPlanetaryObject object, KPCPlanetaryEventType type)
{
    return CAAPlanetaryPhenomena::True(k, (CAAPlanetaryPhenomena::PlanetaryObject)object, (CAAPlanetaryPhenomena::EventType)type);
}

double KPCAAPlanetaryPhenomena_ElongationValue(double k, KPCPlanetaryObject object, BOOL eastern)
{
    return CAAPlanetaryPhenomena::ElongationValue(k, (CAAPlanetaryPhenomena::PlanetaryObject)object, (bool)eastern);
}

double KPCAAPlanetaryPhenomena(BOOL mean, double Year, KPCPlanetaryObject object, KPCPlanetaryEventType type)
{
    double k = KPCAAPlanetaryPhenomena_K(Year, object, type);
    if (mean) {
        return KPCAAPlanetaryPhenomena_Mean(k, object, type);
    }
    else {
        return KPCAAPlanetaryPhenomena_True(k, object, type);
    }
}
