//
//  KPCAAKepler.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 09/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import "KPCAAKepler.h"
#import "AAKepler.h"

double KPCAAKepler_Calculate(double M, double e, int nIterations)
{
    if (nIterations == 0) {
        nIterations = 53;
    }
    return CAAKepler::Calculate(M, e, nIterations);
}
