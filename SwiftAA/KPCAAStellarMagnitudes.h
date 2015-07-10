//
//  KPCAAStellarMagnitudes.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 10/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KPCAAStellarMagnitudes : NSObject

+ (double)CombinedMagnitude:(double)m1 m2:(double)m2;
+ (double)BrightnessRatio:(double)m1 m2:(double)m2;
+ (double)MagnitudeDifference:(double)brightnessRatio;

@end
