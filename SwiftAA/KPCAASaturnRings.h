//
//  KPCAASaturnRings.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 10/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KPCAASaturnRingDetails : NSObject

@property(nonatomic, assign) double B;
@property(nonatomic, assign) double Bdash;
@property(nonatomic, assign) double P;
@property(nonatomic, assign) double a;
@property(nonatomic, assign) double bb; // conflicting setter for 'b' and 'B'
@property(nonatomic, assign) double DeltaU;

@end

@interface KPCAASaturnRings : NSObject

+ (KPCAASaturnRingDetails *)Calculate:(double)JD;

@end
