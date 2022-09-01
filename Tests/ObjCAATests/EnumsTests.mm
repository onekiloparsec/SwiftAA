//
//  EnumsTests.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 17/02/2017.
//  Copyright © 2017 onekiloparsec. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "KPCAAPlanetaryPhenomena.h"
#import "AAPlanetaryPhenomena.h"

@interface EnumsTests : XCTestCase

@end

@implementation EnumsTests


- (void)testPlanetaryPhenomena
{
    XCTAssertEqual((NSUInteger)MERCURY, (NSUInteger)CAAPlanetaryPhenomena::Planet::MERCURY);
    XCTAssertEqual((NSUInteger)VENUS, (NSUInteger)CAAPlanetaryPhenomena::Planet::VENUS);
    XCTAssertEqual((NSUInteger)MARS, (NSUInteger)CAAPlanetaryPhenomena::Planet::MARS);
    XCTAssertEqual((NSUInteger)JUPITER, (NSUInteger)CAAPlanetaryPhenomena::Planet::JUPITER);
    XCTAssertEqual((NSUInteger)SATURN, (NSUInteger)CAAPlanetaryPhenomena::Planet::SATURN);
    XCTAssertEqual((NSUInteger)URANUS, (NSUInteger)CAAPlanetaryPhenomena::Planet::URANUS);
    XCTAssertEqual((NSUInteger)NEPTUNE, (NSUInteger)CAAPlanetaryPhenomena::Planet::NEPTUNE);
}


@end
