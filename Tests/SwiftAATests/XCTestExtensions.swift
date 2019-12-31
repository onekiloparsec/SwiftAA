//
//  XCTestExtensions.swift
//  SwiftAA
//
//  Created by Alexander Vasenin on 27/12/2016.
//  MIT Licence. See LICENCE file.
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


// See https://stackoverflow.com/questions/32873212/unit-test-fatalerror-in-swift?answertab=active#tab-top
// to make possible to unit test fatalError.
extension XCTestCase {
    func assertFatalError(expectedMessage: String, testcase: @escaping () -> Void) {
        
        // arrange
        let expectation = self.expectation(description: "expectingFatalError")
        var assertionMessage: String? = nil
        
        // override fatalError. This will pause forever when fatalError is called.
        FatalErrorUtil.replaceFatalError { message, _, _ in
            assertionMessage = message
            expectation.fulfill()
            unreachable()
        }
        
        // act, perform on separate thead because a call to fatalError pauses forever
        DispatchQueue.global(qos: .userInitiated).async(execute: testcase)
        
        waitForExpectations(timeout: 0.1) { _ in
            // assert
            XCTAssertEqual(assertionMessage, expectedMessage)
            
            // clean up
            FatalErrorUtil.restoreFatalError()
        }
    }
}
