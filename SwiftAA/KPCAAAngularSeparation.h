//
//  KPCAAAngularSeparation.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 04/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KPCAAAngularSeparation : NSObject

+ (double)SeparationForAlpha1:(double)Alpha1 delta1:(double)Delta1 alpha2:(double)Alpha2 delta2:(double)Delta2;

+ (double)PositionAngleForAlpha1:(double)Alpha1 delta1:(double)Delta1 alpha2:(double)Alpha2 delta2:(double)Delta2;

+ (double)DistanceFromGreatArcForAlpha1:(double)Alpha1 delta1:(double)Delta1 alpha2:(double)Alpha2 delta2:(double)Delta2 alpha3:(double)Alpha3 delta3:(double)Delta3;

+ (double)SmallestCircleForAlpha1:(double)Alpha1 delta1:(double)Delta1 alpha2:(double)Alpha2 delta2:(double)Delta2 alpha3:(double)Alpha3 delta3:(double)Delta3 bType1:(bool *)bType1;

@end
