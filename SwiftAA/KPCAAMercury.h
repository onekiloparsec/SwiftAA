//
//  KPCAAMercury.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 09/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KPCAAMercury : NSObject

+ (double)EclipticLongitude:(double)JD highPrecision:(BOOL)highPrecision;
+ (double)EclipticLatitude:(double)JD highPrecision:(BOOL)highPrecision;
+ (double)RadiusVector:(double)JD highPrecision:(BOOL)highPrecision;

@end
