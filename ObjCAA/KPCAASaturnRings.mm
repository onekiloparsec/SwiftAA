//
//  KPCAASaturnRings.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 10/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import "KPCAASaturnRings.h"
#import "AASaturnRings.h"

KPCAASaturnRingDetails KPCAASaturnRings_Calculate(double JD, BOOL highPrecision)
{
    CAASaturnRingDetails details = CAASaturnRings::Calculate(JD, highPrecision);
    KPCAASaturnRingDetails results;
    results.B = details.B;
    results.Bdash = details.Bdash;
    results.P = details.P;
    results.a = details.a;
    results.b = details.b;
    results.DeltaU = details.DeltaU;
    return results;
}