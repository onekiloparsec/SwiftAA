//
//  CAA2DCoordinate.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 03/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AA2DCoordinate.h"

@interface KPCAA2DCoordinate : NSObject

@property(nonatomic, assign) double X;
@property(nonatomic, assign) double Y;

+ (KPCAA2DCoordinate *)coordinateByWrapping:(CAA2DCoordinate)wrapped;

@end
