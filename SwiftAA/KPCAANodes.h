//
//  KPCAANodes.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 09/07/15.
//  Licensed under the MIT License (see LICENSE file)
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
