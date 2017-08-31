//
//  XCTestExtensions.swift
//  SwiftAA
//
//  Created by Alexander Vasenin on 27/12/2016.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import XCTest
@testable import SwiftAA

/// This function is a type-safe way to test NumericType's equality
func AssertEqual<T : NumericType>(_ value1: T, _ value2: T, accuracy: T? = nil, _ message: String = "", file: StaticString = #file, line: UInt = #line) {
    if let _accuracy = accuracy {
        XCTAssertEqual(value1.value, value2.value, accuracy: _accuracy.value, message, file: file, line: line)
    } else {
        XCTAssertEqual(value1.value, value2.value, message, file: file, line: line)
    }
}


