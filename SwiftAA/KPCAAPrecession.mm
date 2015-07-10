//
//  KPCAAPrecession.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 10/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import "KPCAAPrecession.h"
#import "AAPrecession.h"

@implementation KPCAAPrecession

+ (KPCAA2DCoordinate *)PrecessEquatorial:(double)Alpha Delta:(double)Delta JD0:(double)JD0 JD:(double)JD
{
    return [KPCAA2DCoordinate coordinateByWrapping:CAAPrecession::PrecessEquatorial(Alpha, Delta, JD0, JD)];
}

+ (KPCAA2DCoordinate *)PrecessEquatorialFK4:(double)Alpha Delta:(double)Delta JD0:(double)JD0 JD:(double)JD
{
    return [KPCAA2DCoordinate coordinateByWrapping:CAAPrecession::PrecessEquatorialFK4(Alpha, Delta, JD0, JD)];
}

+ (KPCAA2DCoordinate *)PrecessEcliptic:(double)Lambda Beta:(double)Beta JD0:(double)JD0 JD:(double)JD
{
    return [KPCAA2DCoordinate coordinateByWrapping:CAAPrecession::PrecessEcliptic(Lambda, Beta, JD0, JD)];
}

+ (KPCAA2DCoordinate *)EquatorialPMToEcliptic:(double)Alpha Delta:(double)Delta Beta:(double)Beta  PMAlpha:(double)PMAlpha PMDelta:(double)PMDelta Epsilon:(double)Epsilon
{
    return [KPCAA2DCoordinate coordinateByWrapping:CAAPrecession::EquatorialPMToEcliptic(Alpha, Delta, Beta, PMAlpha, PMDelta, Epsilon)];
}

+ (KPCAA2DCoordinate *)AdjustPositionUsingUniformProperMotion:(double)t Alpha:(double)Alpha Delta:(double)Delta PMAlpha:(double)PMAlpha PMDelta:(double)PMDelta
{
    return [KPCAA2DCoordinate coordinateByWrapping:CAAPrecession::AdjustPositionUsingUniformProperMotion(t, Alpha, Delta, PMAlpha, PMDelta)];
}

+ (KPCAA2DCoordinate *)AdjustPositionUsingMotionInSpace:(double)r deltar:(double)deltar t:(double)t  Alpha:(double)Alpha Delta:(double)Delta PMAlpha:(double)PMAlpha PMDelta:(double)PMDelta
{
    return [KPCAA2DCoordinate coordinateByWrapping:CAAPrecession::AdjustPositionUsingMotionInSpace(r, deltar, t, Alpha, Delta, PMAlpha, PMDelta)];
}
    
@end
