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

typedef struct KPCAANodeObjectDetails {
    double t;
    double radius;
} KPCAANodeObjectDetails;

KPCAANodeObjectDetails KPCAANodesPassageThroAscendingNodeForEllipticalElements(KPCAAEllipticalObjectElements *elements);
KPCAANodeObjectDetails KPCAANodesPassageThroDescendingNodeForEllipticalElements(KPCAAEllipticalObjectElements *elements);

KPCAANodeObjectDetails KPCAANodesPassageThroAscendingNodeForParabolicElements(KPCAAParabolicObjectElements *elements);
KPCAANodeObjectDetails KPCAANodesPassageThroDescendingNodeForParabolicElements(KPCAAParabolicObjectElements *elements);
