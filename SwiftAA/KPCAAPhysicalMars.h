//
//  KPCPhysicalMars.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 10/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KPCAAPhysicalMarsDetails : NSObject

@property(nonatomic, assign) double DE;
@property(nonatomic, assign) double DS;
@property(nonatomic, assign) double w;
@property(nonatomic, assign) double P;
@property(nonatomic, assign) double X;
@property(nonatomic, assign) double k;
@property(nonatomic, assign) double q;
@property(nonatomic, assign) double d;

@end

@interface KPCAAPhysicalMars : NSObject

+ (KPCAAPhysicalMarsDetails *)Calculate:(double)JD;

@end
