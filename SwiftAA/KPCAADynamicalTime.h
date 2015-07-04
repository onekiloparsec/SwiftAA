//
//  KPCAADynamicalTime.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 04/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KPCAADynamicalTime : NSObject

+ (double)DeltaT:(double)JD;
+ (double)CumulativeLeapSeconds:(double)JD;
+ (double)TT2UTC:(double)JD;
+ (double)UTC2TT:(double)JD;
+ (double)TT2TAI:(double)JD;
+ (double)TAI2TT:(double)JD;
+ (double)TT2UT1:(double)JD;
+ (double)UT12TT:(double)JD;
+ (double)UT1MinusUTC:(double)JD;

@end
