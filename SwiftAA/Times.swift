//
//  Times.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 17/12/2016.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

public struct Hour: NumericType {
    public var value: Double
    public init(_ value: Double) {
        self.value = value
    }
    
    public var minute: Double { return self.value * 60.0 }
    public var second: Double { return self.value * 3600.0 }
    public var degree: Degree { return Degree(self.value * 15.0) }
}

extension Hour: ExpressibleByIntegerLiteral {
    public init(integerLiteral: IntegerLiteralType) {
        self.init(Double(integerLiteral))
    }
}

extension Hour: ExpressibleByFloatLiteral {
    public init(floatLiteral: FloatLiteralType) {
        self.init(Double(floatLiteral))
    }
}
