//
//  KPCAAMoonPhases.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 09/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import <Foundation/Foundation.h>

@interface KPCAAMoonPhases : NSObject

+ (double)K:(double)Year;
+ (double)MeanPhase:(double)k;
+ (double)TruePhase:(double)k;

@end
