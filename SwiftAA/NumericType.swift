//
//  Constants.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 18/06/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

// Imported from the excellent Gist https://gist.github.com/fcanas/6f02fc92e3ae0b2f9ce7

import Foundation

public protocol NumericType: Comparable, ExpressibleByFloatLiteral, ExpressibleByIntegerLiteral, SignedNumber {
    var value: Double { get }
    init(_ value: Double)
}

public func + <T: NumericType> (lhs: T, rhs: T) -> T {
    return T(lhs.value + rhs.value)
}

public func - <T: NumericType> (lhs: T, rhs: T) -> T {
    return T(lhs.value - rhs.value)
}

public func < <T: NumericType> (lhs: T, rhs: T) -> Bool {
    return lhs.value < rhs.value
}

public func == <T: NumericType> (lhs: T, rhs: T) -> Bool {
    return lhs.value == rhs.value
}

public prefix func - <T: NumericType> (number: T) -> T {
    return T(-number.value)
}


