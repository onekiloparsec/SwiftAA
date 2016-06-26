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

typedef NS_ENUM(NSUInteger, KPCAAPlanet) {
    Mercury = MERCURY,
    Venus = VENUS,
    Earth = 99,
    Mars = MARS,
    Jupiter = JUPITER,
    Saturn = SATURN,
    Uranus = URANUS,
    Neptune = NEPTUNE,
    Pluto = 999
};

#endif /* KPCAASwiftAdditions_h */
