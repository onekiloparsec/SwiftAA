//
//  KPCAASaturn.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 10/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import "KPCAASaturn.h"
#import "AASaturn.h"

@implementation KPCAASaturn

+ (double)EclipticLongitude:(double)JD
{
    return CAASaturn::EclipticLongitude(JD);
}

+ (double)EclipticLatitude:(double)JD
{
    return CAASaturn::EclipticLatitude(JD);
}

+ (double)RadiusVector:(double)JD
{
    return CAASaturn::RadiusVector(JD);
}

//+ (double)EclipticLongitudeJ2000:(double)JD
//{
//    return CAASaturn::EclipticLongitudeJ2000(JD);
//}
//
//+ (double)EclipticLatitudeJ2000:(double)JD
//{
//    return CAASaturn::EclipticLatitudeJ2000(JD);
//}

@end
