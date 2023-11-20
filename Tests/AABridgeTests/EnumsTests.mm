//
//  EnumsTests.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 17/02/2017.
//  Copyright © 2017 onekiloparsec. All rights reserved.
//

#import "PlatformHelpers.h"

#if IS_ON_APPLE_PLATFORM

#import <XCTest/XCTest.h>
#import "KPCAAPlanetaryPhenomena.h"
#import "AAPlanetaryPhenomena.h"

@interface EnumsTests : XCTestCase

@end

@implementation EnumsTests


- (void)testPlanetaryPhenomena
{
    XCTAssertEqual((NSUInteger)KPCPlanetaryObjectMERCURY, (NSUInteger)CAAPlanetaryPhenomena::Planet::MERCURY);
    XCTAssertEqual((NSUInteger)KPCPlanetaryObjectVENUS, (NSUInteger)CAAPlanetaryPhenomena::Planet::VENUS);
    XCTAssertEqual((NSUInteger)KPCPlanetaryObjectMARS, (NSUInteger)CAAPlanetaryPhenomena::Planet::MARS);
    XCTAssertEqual((NSUInteger)KPCPlanetaryObjectJUPITER, (NSUInteger)CAAPlanetaryPhenomena::Planet::JUPITER);
    XCTAssertEqual((NSUInteger)KPCPlanetaryObjectSATURN, (NSUInteger)CAAPlanetaryPhenomena::Planet::SATURN);
    XCTAssertEqual((NSUInteger)KPCPlanetaryObjectURANUS, (NSUInteger)CAAPlanetaryPhenomena::Planet::URANUS);
    XCTAssertEqual((NSUInteger)KPCPlanetaryObjectNEPTUNE, (NSUInteger)CAAPlanetaryPhenomena::Planet::NEPTUNE);
}


@end

#endif
