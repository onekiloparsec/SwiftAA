//
//  KPCAAAngularSeparation.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 04/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import "KPCAAAngularSeparation.h"
#import "AAAngularSeparation.h"

@implementation KPCAAAngularSeparation

+ (double)SeparationForAlpha1:(double)Alpha1 delta1:(double)Delta1 alpha2:(double)Alpha2 delta2:(double)Delta2
{
    return CAAAngularSeparation::Separation(Alpha1, Delta1, Alpha2, Delta2);
}

+ (double)PositionAngleForAlpha1:(double)Alpha1 delta1:(double)Delta1 alpha2:(double)Alpha2 delta2:(double)Delta2
{
    return CAAAngularSeparation::PositionAngle(Alpha1, Delta1, Alpha2, Delta2);
}

+ (double)DistanceFromGreatArcForAlpha1:(double)Alpha1 delta1:(double)Delta1 alpha2:(double)Alpha2 delta2:(double)Delta2 alpha3:(double)Alpha3 delta3:(double)Delta3
{
    return CAAAngularSeparation::DistanceFromGreatArc(Alpha1, Delta1, Alpha2, Delta2, Alpha3, Delta3);
}

+ (double)SmallestCircleForAlpha1:(double)Alpha1 delta1:(double)Delta1 alpha2:(double)Alpha2 delta2:(double)Delta2 alpha3:(double)Alpha3 delta3:(double)Delta3 bType1:(bool *)bType1
{
    return CAAAngularSeparation::SmallestCircle(Alpha1, Delta1, Alpha2, Delta2, Alpha3, Delta3, *bType1);
}

@end
