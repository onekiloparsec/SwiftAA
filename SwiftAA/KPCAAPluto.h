//
//  KPCAAPluto.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 10/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import <Foundation/Foundation.h>

@interface KPCAAPluto : NSObject

+ (double)EclipticLongitude:(double)JD;
+ (double)EclipticLatitude:(double)JD;
+ (double)RadiusVector:(double)JD;

@end
