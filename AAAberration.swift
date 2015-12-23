//
//  AAAberration.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 23/12/15.
//  Copyright © 2015 onekiloparsec. All rights reserved.
//

import Foundation

func EarthVelocity(JD: Double) -> AA3DCoordinates {
    return AA3DCoordinates(components: EarthVelocity(JD))
}

func EclipticAberrationForAlpha(Alpha: Double, Delta: Double, JD: Double) -> AA2DCoordinates {
    return AA2DCoordinates(components: EclipticAberrationForAlpha(Alpha, Delta, JD))
}

func EquatorialAberrationForLambda(Lambda: Double, Beta: Double, JD: Double) -> AA2DCoordinates {
    return AA2DCoordinates(components: EquatorialAberrationForLambda(Lambda, Beta, JD))
}

