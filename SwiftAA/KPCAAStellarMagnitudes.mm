//
//  KPCAAStellarMagnitudes.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 10/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import "KPCAAStellarMagnitudes.h"
#import "AAStellarMagnitudes.h"

double KPCAAStellarMagnitudesCombinedMagnitude(double m1, double m2)
{
    return CAAStellarMagnitudes::CombinedMagnitude(m1, m2);
}

double KPCAAStellarMagnitudesBrightnessRatio(double m1, double m2)
{
    return CAAStellarMagnitudes::BrightnessRatio(m1, m2);
}

double KPCAAStellarMagnitudesMagnitudeDifference(double brightnessRatio)
{
    return CAAStellarMagnitudes::MagnitudeDifference(brightnessRatio);
}

