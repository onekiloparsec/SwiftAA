//
//  KPCAAMoonPerigeeApogee.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 09/07/15.
//  Licensed under the MIT License (see LICENSE file)
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
