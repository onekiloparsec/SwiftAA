//
//  KPCAA3DCoordinate.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 04/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AA3DCoordinate.h"

@interface KPCAA3DCoordinate : NSObject

@property(nonatomic, assign) double X;
@property(nonatomic, assign) double Y;
@property(nonatomic, assign) double Z;

+ (KPCAA3DCoordinate *)coordinateByWrapping:(CAA3DCoordinate)wrappedCoord;
- (CAA3DCoordinate)wrappedCoord;

@end
