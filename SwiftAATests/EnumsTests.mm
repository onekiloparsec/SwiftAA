//
//  EnumsTests.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 17/02/2017.
//  Copyright © 2017 onekiloparsec. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SwiftAA.h"
#import "KPCAAPlanetaryPhenomena.h"
#import "AAPlanetaryPhenomena.h"

@interface EnumsTests : XCTestCase

@end

@implementation EnumsTests


- (void)testPlanetaryPhenomena
{
    XCTAssertEqual((NSUInteger)_MERCURY, (NSUInteger)CAAPlanetaryPhenomena::PlanetaryObject::MERCURY);
    XCTAssertEqual((NSUInteger)_VENUS, (NSUInteger)CAAPlanetaryPhenomena::PlanetaryObject::VENUS);
    XCTAssertEqual((NSUInteger)_MARS, (NSUInteger)CAAPlanetaryPhenomena::PlanetaryObject::MARS);
    XCTAssertEqual((NSUInteger)_JUPITER, (NSUInteger)CAAPlanetaryPhenomena::PlanetaryObject::JUPITER);
    XCTAssertEqual((NSUInteger)_SATURN, (NSUInteger)CAAPlanetaryPhenomena::PlanetaryObject::SATURN);
    XCTAssertEqual((NSUInteger)_URANUS, (NSUInteger)CAAPlanetaryPhenomena::PlanetaryObject::URANUS);
    XCTAssertEqual((NSUInteger)_NEPTUNE, (NSUInteger)CAAPlanetaryPhenomena::PlanetaryObject::NEPTUNE);
}


@end
