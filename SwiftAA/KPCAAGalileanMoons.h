//
//  KPCAAGalileanMoons.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 08/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KPCAA3DCoordinate.h"

typedef struct KPCAAGalileanMoonDetails {
    double MeanLongitude;
    double TrueLongitude;
    double TropicalLongitude;
    double EquatorialLatitude;
    double r;
    KPCAA3DCoordinateComponents TrueRectangularCoordinateComponents;
    KPCAA3DCoordinateComponents ApparentRectangularCoordinateComponents;
    BOOL inTransit;
    BOOL inOccultation;
    BOOL inEclipse;
    BOOL inShadowTransit;
} KPCAAGalileanMoonDetails;

typedef struct KPCAAGalileanMoonsDetails {
    KPCAAGalileanMoonDetails Satellite1;
    KPCAAGalileanMoonDetails Satellite2;
    KPCAAGalileanMoonDetails Satellite3;
    KPCAAGalileanMoonDetails Satellite4;
} KPCAAGalileanMoonsDetails;

KPCAAGalileanMoonsDetails KPCAAGalileanMoonsCalculateDetails(double JD, BOOL highPrecision);
