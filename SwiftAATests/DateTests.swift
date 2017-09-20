//
//  DateTests.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 2017-09-19.
//  Copyright © 2017 onekiloparsec. All rights reserved.
//

import XCTest
@testable import SwiftAA

class DateTests: XCTestCase {

    func testDateSettingHour() {
        var components = DateComponents()
        components.year = 1916
        components.month = 9
        components.day = 17
        components.hour = 2
        components.minute = 3
        components.second = 4
        components.nanosecond = 500000000
        let date = Calendar.gregorianGMT.date(from: components)!
        let newDate = Calendar.gregorianGMT.date(bySettingHour: 3.45678, of: date)
        
        XCTAssertEqual(Calendar.gregorianGMT.component(.hour, from: newDate), 3)
        XCTAssertEqual(Calendar.gregorianGMT.component(.minute, from: newDate), 27)
        XCTAssertEqual(Calendar.gregorianGMT.component(.second, from: newDate), 23)
        XCTAssertEqual(Calendar.gregorianGMT.component(.nanosecond, from: newDate), 999911785)
    }


}
