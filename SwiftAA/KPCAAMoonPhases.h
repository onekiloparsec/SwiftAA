//
//  KPCAAMoonPhases.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 09/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KPCAAMoonPhases : NSObject

+ (double)K:(double)Year;
+ (double)MeanPhase:(double)k;
+ (double)TruePhase:(double)k;

@end
