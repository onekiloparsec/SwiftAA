//
//  AAAngularSeparation.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 23/12/15.
//  Copyright © 2015 onekiloparsec. All rights reserved.
//

import Foundation

func Separation(forRA1 Alpha1: Double, Dec1 Delta1: Double, RA2 Alpha2: Double, Dec2 Delta2: Double) -> Double {
    return KPCSeparation(Alpha1, Delta1, Alpha2, Delta2)
}

func PositionAngleFor(forRA1 Alpha1: Double, Dec1 Delta1: Double, RA2 Alpha2: Double, Dec2 Delta2: Double) -> Double {
    return KPCPositionAngle(Alpha1, Delta1, Alpha2, Delta2)
}

func DistanceFromGreatArc(forRA1 Alpha1: Double, Dec1 Delta1: Double, RA2 Alpha2: Double, Dec2 Delta2: Double, RA3 Alpha3: Double, Dec3 Delta3: Double) -> Double {
    return KPCDistanceFromGreatArc(Alpha1, Delta1, Alpha2, Delta2, Alpha3, Delta3)
}

func SmallestCircle(forRA1 Alpha1: Double, Dec1 Delta1: Double, RA2 Alpha2: Double, Dec2 Delta2: Double, RA3 Alpha3: Double, Dec3 Delta3: Double, inout bType1: Bool) -> Double {
    return KPCSmallestCircle(Alpha1, Delta1, Alpha2, Delta2, Alpha3, Delta3, &bType1);
}
