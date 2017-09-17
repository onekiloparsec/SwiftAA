//
//  KPCAAGalileanMoons.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 08/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import <Foundation/Foundation.h>
#import "KPCAA3DCoordinate.h"

#ifdef __cplusplus
extern "C" {
#endif

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

KPCAAGalileanMoonsDetails KPCAAGalileanMoons_CalculateDetails(double JD, BOOL highPrecision);

#if __cplusplus
}
#endif
