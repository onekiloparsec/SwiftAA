//
//  KPCAAVenus.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 10/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KPCAAVenus : NSObject

+ (double)EclipticLongitude:(double)JD;
+ (double)EclipticLatitude:(double)JD;
+ (double)RadiusVector:(double)JD;

@end
