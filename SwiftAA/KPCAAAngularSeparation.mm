//
//  KPCAAAngularSeparation.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 04/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import "KPCAAAngularSeparation.h"
#import "AAAngularSeparation.h"

double KPCSeparation(double Alpha1, double Delta1, double Alpha2, double Delta2)
{
    return CAAAngularSeparation::Separation(Alpha1, Delta1, Alpha2, Delta2);
}

double KPCPositionAngle(double Alpha1, double Delta1, double Alpha2, double Delta2)
{
    return CAAAngularSeparation::PositionAngle(Alpha1, Delta1, Alpha2, Delta2);
}

double KPCDistanceFromGreatArc(double Alpha1, double Delta1, double Alpha2, double Delta2, double Alpha3, double Delta3)
{
    return CAAAngularSeparation::DistanceFromGreatArc(Alpha1, Delta1, Alpha2, Delta2, Alpha3, Delta3);
}

double KPCSmallestCircle(double Alpha1, double Delta1, double Alpha2, double Delta2, double Alpha3, double Delta3, bool *bType1)
{
    return CAAAngularSeparation::SmallestCircle(Alpha1, Delta1, Alpha2, Delta2, Alpha3, Delta3, *bType1);
}
