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

#ifdef __cplusplus
extern "C" {
#endif

typedef struct KPCAANodeObjectDetails {
    double t;
    double radius;
} KPCAANodeObjectDetails;

KPCAANodeObjectDetails KPCAANodes_PassageThroAscendingNodeForEllipticalElements(KPCAAEllipticalObjectElements *elements);
KPCAANodeObjectDetails KPCAANodes_PassageThroDescendingNodeForEllipticalElements(KPCAAEllipticalObjectElements *elements);

KPCAANodeObjectDetails KPCAANodes_PassageThroAscendingNodeForParabolicElements(KPCAAParabolicObjectElements *elements);
KPCAANodeObjectDetails KPCAANodes_PassageThroDescendingNodeForParabolicElements(KPCAAParabolicObjectElements *elements);

#if __cplusplus
}
#endif
