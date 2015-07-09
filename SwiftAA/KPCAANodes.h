//
//  KPCAANodes.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 09/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KPCAAElliptical.h"
#import "KPCAAParabolic.h"

@interface KPCAANodeObjectDetails : NSObject

@property(nonatomic, assign) double t;
@property(nonatomic, assign) double radius;

@end

@interface KPCAANodes : NSObject

+ (KPCAANodeObjectDetails *)PassageThroAscendingNodeForEllipticalElements:(KPCAAEllipticalObjectElements *)elements;
+ (KPCAANodeObjectDetails *)PassageThroDescendingNodeForEllipticalElements:(KPCAAEllipticalObjectElements *)elements;

+ (KPCAANodeObjectDetails *)PassageThroAscendingNodeForParabolicElements:(KPCAAParabolicObjectElements *)elements;
+ (KPCAANodeObjectDetails *)PassageThroDescendingNodeForParabolicElements:(KPCAAParabolicObjectElements *)elements;

@end
