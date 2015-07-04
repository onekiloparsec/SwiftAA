//
//  KPCAAAberration.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 04/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KPCAA2DCoordinate.h"
#import "KPCAA3DCoordinate.h"

@interface KPCAAAberration : NSObject

+ (KPCAA3DCoordinate *)EarthVelocity:(double)JD;
+ (KPCAA2DCoordinate *)EclipticAberrationForAlpha:(double)Alpha delta:(double)Delta julianDay:(double)JD;
+ (KPCAA2DCoordinate *)EquatorialAberrationForLambda:(double)Lambda beta:(double)Beta julianDay:(double)JD;

@end
