//
//  KPCAAKepler.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 09/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KPCAAKepler : NSObject

// Pass nIterations=0 to use default (53).
+ (double)Calculate:(double)M  e:(double)e nIterations:(int)nIterations;

@end
