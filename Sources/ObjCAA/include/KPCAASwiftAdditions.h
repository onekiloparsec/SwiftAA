//
//  KPCAASwiftAdditions.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 26/06/16.
//  MIT Licence. See LICENCE file.
//

#ifndef KPCAASwiftAdditions_h
#define KPCAASwiftAdditions_h

#import "KPCAAPlanetaryPhenomena.h"

// SwiftAA Aditions
// The trick here is that CAPITALS are used in the C++ code for PlanetaryObject
// The Obj-C code respects that. To extend it here to include Earth and Pluto,
// We use the normal case.

/**
 KPCAAPlanetStrict is an enum for all true planets, that is, excluding the now official 
 Dwarf Planet category, that is, Pluto.
 */
typedef enum KPCAAPlanetStrict: NSInteger {
    KPCAAPlanetStrictMercury = KPCPlanetaryObjectMERCURY,
    KPCAAPlanetStrictVenus = KPCPlanetaryObjectVENUS,
    KPCAAPlanetStrictEarth = 99,
    KPCAAPlanetStrictMars = KPCPlanetaryObjectMARS,
    KPCAAPlanetStrictJupiter = KPCPlanetaryObjectJUPITER,
    KPCAAPlanetStrictSaturn = KPCPlanetaryObjectSATURN,
    KPCAAPlanetStrictUranus = KPCPlanetaryObjectURANUS,
    KPCAAPlanetStrictNeptune = KPCPlanetaryObjectNEPTUNE,
    KPCAAPlanetStrictUndefined = -1
} KPCAAPlanetStrict;


/**
 KPCAAPlanet is an enum for all planets, being "true" planets, as it was for a long time, 
 or not (like DwarfPlanet), that is, including Pluto.
 */

typedef enum KPCAAPlanet: NSInteger {
    KPCAAPlanetMercury = KPCAAPlanetStrictMercury,
    KPCAAPlanetVenus = KPCAAPlanetStrictVenus,
    KPCAAPlanetEarth = KPCAAPlanetStrictEarth,
    KPCAAPlanetMars = KPCAAPlanetStrictMars,
    KPCAAPlanetJupiter = KPCAAPlanetStrictJupiter,
    KPCAAPlanetSaturn = KPCAAPlanetStrictSaturn,
    KPCAAPlanetUranus = KPCAAPlanetStrictUranus,
    KPCAAPlanetNeptune = KPCAAPlanetStrictNeptune,
    KPCAAPlanetPluto = 999,
    KPCAAPlanetUndefined = -1
} KPCAAPlanet;

#endif /* KPCAASwiftAdditions_h */
