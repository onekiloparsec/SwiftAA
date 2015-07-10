//
//  KPCAARiseTransitSet.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 10/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KPCAARiseTransitSetDetails : NSObject

@property(nonatomic, assign) BOOL   isRiseValid;
@property(nonatomic, assign) double Rise;
@property(nonatomic, assign) BOOL   isTransitAboveHorizon;
@property(nonatomic, assign) double Transit;
@property(nonatomic, assign) BOOL   isSetValid;
@property(nonatomic, assign) double Set;

@end

@interface KPCAARiseTransitSet : NSObject

+ (KPCAARiseTransitSetDetails *)Calculate:(double)JD Alpha1:(double)Alpha1 Delta1:(double)Delta1 Alpha2:(double)Alpha2 Delta2:(double)Delta2 Alpha3:(double)Alpha3 Delta3:(double)Delta3 Longitude:(double)Longitude Latitude:(double)Latitude h0:(double)h0;

@end
