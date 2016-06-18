//
//  KPCAAPlanetaryPhenomena.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 10/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import <Foundation/Foundation.h>

#ifdef __cplusplus
extern "C" {
#endif

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


double KPCAAPlanetaryPhenomena_K(double Year, KPCPlanetaryObject object, KPCPlanetaryEventType type);
double KPCAAPlanetaryPhenomena_Mean(double k, KPCPlanetaryObject object, KPCPlanetaryEventType type);
double KPCAAPlanetaryPhenomena_True(double k, KPCPlanetaryObject object, KPCPlanetaryEventType type);
double KPCAAPlanetaryPhenomena_ElongationValue(double k, KPCPlanetaryObject object, BOOL eastern);

#if __cplusplus
}
#endif
