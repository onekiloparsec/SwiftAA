//
//  KPCAASwiftAdditions.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 26/06/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

#ifndef KPCAASwiftAdditions_h
#define KPCAASwiftAdditions_h

#import "KPCAAPlanetaryPhenomena.h"

// SwiftAA Aditions
// The trick here is that CAPITALS are used in the C++ code for PlanetaryObject
// The Obj-C code respects that. To extend it here to include Earth and Pluto,
// We use the normal case.

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
