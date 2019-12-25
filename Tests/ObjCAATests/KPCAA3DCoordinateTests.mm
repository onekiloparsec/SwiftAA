//
//  KPCAA3DCoordinateTests.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 18/06/16.
//  MIT Licence. See LICENCE file.
//

#import <XCTest/XCTest.h>
#import "KPCAA3DCoordinate.h"

@interface KPCAA3DCoordinateTests : XCTestCase

@end

@implementation KPCAA3DCoordinateTests

- (void)test3DCoordinatesMake
{
    KPCAA3DCoordinateComponents coords = KPCAA3DCoordinateComponentsMake(1.0, 2.0, 3.0);
    XCTAssertTrue(coords.X == 1.0);
    XCTAssertTrue(coords.Y == 2.0);
    XCTAssertTrue(coords.Z == 3.0);
}
    
- (void)test3DCoordinatesInitialisation
{
    KPCAA3DCoordinateComponents coords = KPCAA3DCoordinateComponents();
    XCTAssertTrue(coords.X == 0.0);
    XCTAssertTrue(coords.Y == 0.0);
    XCTAssertTrue(coords.Z == 0.0);
}

@end
