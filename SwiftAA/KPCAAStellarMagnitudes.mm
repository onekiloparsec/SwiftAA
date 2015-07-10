//
//  KPCAAStellarMagnitudes.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 10/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import "KPCAAStellarMagnitudes.h"
#import "AAStellarMagnitudes.h"

@implementation KPCAAStellarMagnitudes

+ (double)CombinedMagnitude:(double)m1 m2:(double)m2
{
    return CAAStellarMagnitudes::CombinedMagnitude(m1, m2);
}

+ (double)BrightnessRatio:(double)m1 m2:(double)m2
{
    return CAAStellarMagnitudes::BrightnessRatio(m1, m2);
}

+ (double)MagnitudeDifference:(double)brightnessRatio
{
    return CAAStellarMagnitudes::MagnitudeDifference(brightnessRatio);
}

@end
