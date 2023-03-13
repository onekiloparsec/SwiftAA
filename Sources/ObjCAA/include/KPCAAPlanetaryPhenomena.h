//
//  KPCAAPlanetaryPhenomena.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 10/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import "PlatformHelpers.h"

#ifdef __cplusplus
extern "C" {
#endif

typedef enum KPCPlanetaryObject: NSUInteger {
    KPCPlanetaryObjectMERCURY,
    KPCPlanetaryObjectVENUS,
    KPCPlanetaryObjectMARS,
    KPCPlanetaryObjectJUPITER,
    KPCPlanetaryObjectSATURN,
    KPCPlanetaryObjectURANUS,
    KPCPlanetaryObjectNEPTUNE,
    KPCPlanetaryObjectUNDEFINED = 999 // Swift Addition
} KPCPlanetaryObject;

typedef enum KPCPlanetaryEventType: NSUInteger {
    KPCPlanetaryEventTypeINFERIOR_CONJUNCTION,
    KPCPlanetaryEventTypeSUPERIOR_CONJUNCTION,
    KPCPlanetaryEventTypeOPPOSITION,
    KPCPlanetaryEventTypeCONJUNCTION,
    KPCPlanetaryEventTypeEASTERN_ELONGATION,
    KPCPlanetaryEventTypeWESTERN_ELONGATION,
    KPCPlanetaryEventTypeSTATION1,
    KPCPlanetaryEventTypeSTATION2
} KPCPlanetaryEventType;


double KPCAAPlanetaryPhenomena_K(double Year, KPCPlanetaryObject object, KPCPlanetaryEventType type);
double KPCAAPlanetaryPhenomena_Mean(double k, KPCPlanetaryObject object, KPCPlanetaryEventType type);
double KPCAAPlanetaryPhenomena_True(double k, KPCPlanetaryObject object, KPCPlanetaryEventType type);
double KPCAAPlanetaryPhenomena_ElongationValue(double k, KPCPlanetaryObject object, BOOL eastern);

    
    
/* SwiftAA Aditions */
    
double KPCAAPlanetaryPhenomena(BOOL mean, double Year, KPCPlanetaryObject object, KPCPlanetaryEventType type);
    
#if __cplusplus
}
#endif
