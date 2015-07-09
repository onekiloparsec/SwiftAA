//
//  KPCAAKepler.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 09/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import "KPCAAKepler.h"
#import "AAKepler.h"

@implementation KPCAAKepler

+ (double)Calculate:(double)M  e:(double)e nIterations:(int)nIterations
{
    if (nIterations == 0) {
        nIterations = 53;
    }
    return CAAKepler::Calculate(M, e, nIterations);
}

@end
