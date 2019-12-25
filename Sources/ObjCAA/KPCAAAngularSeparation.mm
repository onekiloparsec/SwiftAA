//
//  KPCAAAngularSeparation.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 04/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import "KPCAAAngularSeparation.h"
#import "AAAngularSeparation.h"

double KPCAAAngularSeparation_Separation(double Alpha1, double Delta1, double Alpha2, double Delta2)
{
    return CAAAngularSeparation::Separation(Alpha1, Delta1, Alpha2, Delta2);
}

double KPCAAAngularSeparation_PositionAngle(double Alpha1, double Delta1, double Alpha2, double Delta2)
{
    return CAAAngularSeparation::PositionAngle(Alpha1, Delta1, Alpha2, Delta2);
}

double KPCAAAngularSeparation_DistanceFromGreatArc(double Alpha1, double Delta1, double Alpha2, double Delta2, double Alpha3, double Delta3)
{
    return CAAAngularSeparation::DistanceFromGreatArc(Alpha1, Delta1, Alpha2, Delta2, Alpha3, Delta3);
}

double KPCAAAngularSeparation_SmallestCircle(double Alpha1, double Delta1, double Alpha2, double Delta2, double Alpha3, double Delta3, bool *bType1)
{
    return CAAAngularSeparation::SmallestCircle(Alpha1, Delta1, Alpha2, Delta2, Alpha3, Delta3, *bType1);
}
