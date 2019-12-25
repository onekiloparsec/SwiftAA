//
//  SwiftAATests.swift
//  SwiftAATests
//
//  Created by Cédric Foellmi on 18/06/16.
//  MIT Licence. See LICENCE file.
//

#import <XCTest/XCTest.h>
#import "KPCAA2DCoordinate.h"

@interface KPCAA2DCoordinateTests : XCTestCase

@end

@implementation KPCAA2DCoordinateTests
    
- (void)test2DCoordinatesMaker
{
    KPCAA2DCoordinateComponents coords = KPCAA2DCoordinateComponentsMake(1.0, 2.0);
    XCTAssertTrue(coords.X == 1.0);
    XCTAssertTrue(coords.Y == 2.0);
}

- (void)test2DCoordinatesInitialisation
{
    KPCAA2DCoordinateComponents coords = KPCAA2DCoordinateComponents();
    XCTAssertTrue(coords.X == 0.0);
    XCTAssertTrue(coords.Y == 0.0);
}

@end
