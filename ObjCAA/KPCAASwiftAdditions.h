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
typedef NS_ENUM(NSInteger, KPCAAPlanetStrict) {
    mercury = MERCURY,
    venus = VENUS,
    earth = 99,
    mars = MARS,
    jupiter = JUPITER,
    saturn = SATURN,
    uranus = URANUS,
    neptune = NEPTUNE,
    undefined = -1
};


/**
 KPCAAPlanet is an enum for all planets, being "true" planets, as it was for a long time, 
 or not (like DwarfPlanet), that is, including Pluto.
 */

typedef NS_ENUM(NSInteger, KPCAAPlanet) {
    Mercury = mercury,
    Venus = venus,
    Earth = earth,
    Mars = mars,
    Jupiter = jupiter,
    Saturn = saturn,
    Uranus = uranus,
    Neptune = neptune,
    Pluto = 999,
    Undefined = -1
};

#endif /* KPCAASwiftAdditions_h */
