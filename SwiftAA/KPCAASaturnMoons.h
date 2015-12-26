//
//  KPCAASaturnMoons.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 10/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KPCAA3DCoordinate.h"

typedef struct KPCAASaturnMoonDetails {
    KPCAA3DCoordinateComponents TrueRectangularCoordinateComponents;
    KPCAA3DCoordinateComponents ApparentRectangularCoordinateComponents;
    BOOL isInTransit;
    BOOL isInOccultation;
    BOOL isInEclipse;
    BOOL isInShadowTransit;
} KPCAASaturnMoonDetails;


typedef struct KPCAASaturnMoonsDetails {
    KPCAASaturnMoonDetails Satellite1;
    KPCAASaturnMoonDetails Satellite2;
    KPCAASaturnMoonDetails Satellite3;
    KPCAASaturnMoonDetails Satellite4;
    KPCAASaturnMoonDetails Satellite5;
    KPCAASaturnMoonDetails Satellite6;
    KPCAASaturnMoonDetails Satellite7;
    KPCAASaturnMoonDetails Satellite8;
} KPCAASaturnMoonsDetails;

KPCAASaturnMoonsDetails KPCAASaturnMoonsDetailsCalculate(double JD, BOOL highPrecision);

