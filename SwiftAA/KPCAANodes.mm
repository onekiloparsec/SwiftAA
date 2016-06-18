//
//  KPCAANodes.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 09/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import "KPCAANodes.h"
#import "AANodes.h"

KPCAANodeObjectDetails KPCAANodeObjectDetailsMake(CAANodeObjectDetails detailsPlus);
KPCAANodeObjectDetails KPCAANodeObjectDetailsMake(CAANodeObjectDetails detailsPlus)
{
    struct KPCAANodeObjectDetails details;
    details.t = detailsPlus.t;
    details.radius = detailsPlus.radius;
    return details;
}

CAAEllipticalObjectElements CAAEllipticalObjectElementsMake(KPCAAEllipticalObjectElements *elements);
CAAEllipticalObjectElements CAAEllipticalObjectElementsMake(KPCAAEllipticalObjectElements *elements)
{
    CAAEllipticalObjectElements elementsPlus = CAAEllipticalObjectElements();
    elementsPlus.a = (*elements).a;
    elementsPlus.e = (*elements).e;
    elementsPlus.i = (*elements).i;
    elementsPlus.w = (*elements).w;
    elementsPlus.omega = (*elements).omega;
    elementsPlus.JDEquinox = (*elements).JDEquinox;
    elementsPlus.T = (*elements).T;
    return elementsPlus;
}

CAAParabolicObjectElements CAAParabolicObjectElementsMake(KPCAAParabolicObjectElements *elements);
CAAParabolicObjectElements CAAParabolicObjectElementsMake(KPCAAParabolicObjectElements *elements)
{
    CAAParabolicObjectElements elementsPlus = CAAParabolicObjectElements();
    elementsPlus.q = (*elements).q;
    elementsPlus.i = (*elements).i;
    elementsPlus.w = (*elements).w;
    elementsPlus.omega = (*elements).omega;
    elementsPlus.JDEquinox = (*elements).JDEquinox;
    elementsPlus.T = (*elements).T;
    return elementsPlus;
}


KPCAANodeObjectDetails KPCAANodes_PassageThroAscendingNodeForEllipticalElements(KPCAAEllipticalObjectElements *elements)
{
    CAAEllipticalObjectElements elementsPlus = CAAEllipticalObjectElementsMake(elements);
    return KPCAANodeObjectDetailsMake(CAANodes::PassageThroAscendingNode(elementsPlus));
}

KPCAANodeObjectDetails KPCAANodes_PassageThroDescendingNodeForEllipticalElements(KPCAAEllipticalObjectElements *elements)
{
    CAAEllipticalObjectElements elementsPlus = CAAEllipticalObjectElementsMake(elements);
    return KPCAANodeObjectDetailsMake(CAANodes::PassageThroDescendingNode(elementsPlus));
}

KPCAANodeObjectDetails KPCAANodes_PassageThroAscendingNodeForParabolicElements(KPCAAParabolicObjectElements *elements)
{
    CAAParabolicObjectElements elementsPlus = CAAParabolicObjectElementsMake(elements);
    return KPCAANodeObjectDetailsMake(CAANodes::PassageThroAscendingNode(elementsPlus));
}

KPCAANodeObjectDetails KPCAANodes_PassageThroDescendingNodeForParabolicElements(KPCAAParabolicObjectElements *elements)
{
    CAAParabolicObjectElements elementsPlus = CAAParabolicObjectElementsMake(elements);
    return KPCAANodeObjectDetailsMake(CAANodes::PassageThroDescendingNode(elementsPlus));
}

