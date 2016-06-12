//
//  KPCAAKepler.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 09/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import <Foundation/Foundation.h>

// Pass nIterations=0 to use default (53).
double KPCAAKeplerCalculate(double M, double e, int nIterations);

