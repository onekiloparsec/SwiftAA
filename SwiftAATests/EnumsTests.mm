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
    XCTAssertEqual((NSUInteger)MERCURY, (NSUInteger)CAAPlanetaryPhenomena::PlanetaryObject::MERCURY);
    XCTAssertEqual((NSUInteger)VENUS, (NSUInteger)CAAPlanetaryPhenomena::PlanetaryObject::VENUS);
    XCTAssertEqual((NSUInteger)MARS, (NSUInteger)CAAPlanetaryPhenomena::PlanetaryObject::MARS);
    XCTAssertEqual((NSUInteger)JUPITER, (NSUInteger)CAAPlanetaryPhenomena::PlanetaryObject::JUPITER);
    XCTAssertEqual((NSUInteger)SATURN, (NSUInteger)CAAPlanetaryPhenomena::PlanetaryObject::SATURN);
    XCTAssertEqual((NSUInteger)URANUS, (NSUInteger)CAAPlanetaryPhenomena::PlanetaryObject::URANUS);
    XCTAssertEqual((NSUInteger)NEPTUNE, (NSUInteger)CAAPlanetaryPhenomena::PlanetaryObject::NEPTUNE);
}


@end
