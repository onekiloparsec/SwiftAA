//
//  KPCAANodes.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 09/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import "KPCAANodes.h"
#import "AANodes.h"

@interface KPCAANodeObjectDetails () {
    CAANodeObjectDetails _wrapped;
}
@end

@implementation KPCAANodeObjectDetails

- (instancetype)init
{
    self = [super init];
    if (self) {
        _wrapped = CAANodeObjectDetails();
    }
    return self;
}

- (instancetype)initWithWrappedDetails:(CAANodeObjectDetails)wrappedDetails
{
    self = [super init];
    if (self) {
        _wrapped = wrappedDetails;
    }
    return self;
}

+ (KPCAANodeObjectDetails *)detailsByWrapping:(CAANodeObjectDetails)wrappedDetails
{
    return [[KPCAANodeObjectDetails alloc] initWithWrappedDetails:wrappedDetails];
}

- (double)t
{
    return _wrapped.t;
}

- (void)setT:(double)t
{
    _wrapped.t = t;
}

- (double)radius
{
    return _wrapped.radius;
}

- (void)setRadius:(double)radius
{
    _wrapped.radius = radius;
}

@end





/**
 *  Redeclaration of private interface. See KPCElliptical.mm
 */
@interface KPCAAEllipticalObjectElements () 
- (CAAEllipticalObjectElements)wrappedElements;
@end

/**
 *  Redeclaration of private interface. See KPCParabolic.mm
 */
@interface KPCAAParabolicObjectElements ()
- (CAAParabolicObjectElements)wrappedElements;
@end


@implementation KPCAANodes


+ (KPCAANodeObjectDetails *)PassageThroAscendingNodeForEllipticalElements:(KPCAAEllipticalObjectElements *)elements
{
    return [KPCAANodeObjectDetails detailsByWrapping:CAANodes::PassageThroAscendingNode(elements.wrappedElements)];
}

+ (KPCAANodeObjectDetails *)PassageThroDescendingNodeForEllipticalElements:(KPCAAEllipticalObjectElements *)elements
{
    return [KPCAANodeObjectDetails detailsByWrapping:CAANodes::PassageThroDescendingNode(elements.wrappedElements)];
}

+ (KPCAANodeObjectDetails *)PassageThroAscendingNodeForParabolicElements:(KPCAAParabolicObjectElements *)elements
{
    return [KPCAANodeObjectDetails detailsByWrapping:CAANodes::PassageThroAscendingNode(elements.wrappedElements)];
}

+ (KPCAANodeObjectDetails *)PassageThroDescendingNodeForParabolicElements:(KPCAAParabolicObjectElements *)elements
{
    return [KPCAANodeObjectDetails detailsByWrapping:CAANodes::PassageThroDescendingNode(elements.wrappedElements)];   
}

            
@end
