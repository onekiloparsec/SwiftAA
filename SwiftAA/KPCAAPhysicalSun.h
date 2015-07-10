//
//  KPCAAPhysicalSun.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 10/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KPCAAPhysicalSunDetails : NSObject

@property(nonatomic, assign) double P;
@property(nonatomic, assign) double B0;
@property(nonatomic, assign) double L0;

@end

@interface KPCAAPhysicalSun : NSObject

+ (KPCAAPhysicalSunDetails *)Calculate:(double)JD;
+ (double)TimeOfStartOfRotation:(long)C;

@end
