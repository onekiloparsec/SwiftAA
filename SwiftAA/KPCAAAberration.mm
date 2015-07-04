//
//  KPCAAAberration.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 04/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import "KPCAAAberration.h"
#import "AAAberration.h"

@implementation KPCAAAberration

+ (KPCAA3DCoordinate *)EarthVelocity:(double)JD
{
    return [KPCAA3DCoordinate coordinateByWrapping:CAAAberration::EarthVelocity(JD)];
}

+ (KPCAA2DCoordinate *)EclipticAberrationForAlpha:(double)Alpha delta:(double)Delta julianDay:(double)JD
{
    return [KPCAA2DCoordinate coordinateByWrapping:CAAAberration::EclipticAberration(Alpha, Delta, JD)];
}

+ (KPCAA2DCoordinate *)EquatorialAberrationForLambda:(double)Lambda beta:(double)Beta julianDay:(double)JD
{
    return [KPCAA2DCoordinate coordinateByWrapping:CAAAberration::EquatorialAberration(Lambda, Beta, JD)];
}

@end
