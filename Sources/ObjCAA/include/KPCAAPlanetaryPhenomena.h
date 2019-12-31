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
    NEPTUNE,
    UNDEFINED = 999 // Swift Addition
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

    
    
/* SwiftAA Aditions */
    
double KPCAAPlanetaryPhenomena(BOOL mean, double Year, KPCPlanetaryObject object, KPCPlanetaryEventType type);
    
#if __cplusplus
}
#endif
