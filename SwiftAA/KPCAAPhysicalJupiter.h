//
//  KPCAAPhysicalJupiter.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 10/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KPCAAPhysicalJupiterDetails : NSObject

@property(nonatomic, assign) double DE;
@property(nonatomic, assign) double DS;
@property(nonatomic, assign) double Geometricw1;
@property(nonatomic, assign) double Geometricw2;
@property(nonatomic, assign) double Apparentw1;
@property(nonatomic, assign) double Apparentw2;
@property(nonatomic, assign) double P;

@end

@interface KPCAAPhysicalJupiter : NSObject

+ (KPCAAPhysicalJupiterDetails *)Calculate:(double)JD;

@end
