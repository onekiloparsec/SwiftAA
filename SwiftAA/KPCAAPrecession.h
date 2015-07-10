//
//  KPCAAPrecession.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 10/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KPCAA2DCoordinate.h"

@interface KPCAAPrecession : NSObject

+ (KPCAA2DCoordinate *)PrecessEquatorial:(double)Alpha Delta:(double)Delta JD0:(double)JD0 JD:(double)JD;
+ (KPCAA2DCoordinate *)PrecessEquatorialFK4:(double)Alpha Delta:(double)Delta JD0:(double)JD0 JD:(double)JD;
+ (KPCAA2DCoordinate *)PrecessEcliptic:(double)Lambda Beta:(double)Beta JD0:(double)JD0 JD:(double)JD;

+ (KPCAA2DCoordinate *)EquatorialPMToEcliptic:(double)Alpha Delta:(double)Delta Beta:(double)Beta  PMAlpha:(double)PMAlpha PMDelta:(double)PMDelta Epsilon:(double)Epsilon;

+ (KPCAA2DCoordinate *)AdjustPositionUsingUniformProperMotion:(double)t Alpha:(double)Alpha Delta:(double)Delta PMAlpha:(double)PMAlpha PMDelta:(double)PMDelta;

+ (KPCAA2DCoordinate *)AdjustPositionUsingMotionInSpace:(double)r deltar:(double)deltar t:(double)t  Alpha:(double)Alpha Delta:(double)Delta PMAlpha:(double)PMAlpha PMDelta:(double)PMDelta;

@end
