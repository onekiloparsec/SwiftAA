//
//  KPCAAMoonPerigeeApogee.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 09/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KPCAAMoonPerigeeApogee : NSObject

+ (double)K:(double)Year;
+ (double)MeanPerigee:(double)k;
+ (double)MeanApogee:(double)k;
+ (double)TruePerigee:(double)k;
+ (double)TrueApogee:(double)k;
+ (double)PerigeeParallax:(double)k;
+ (double)ApogeeParallax:(double)k;

@end
