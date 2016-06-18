//
//  KPCAAGalileanMoons.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 08/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import "KPCAAGalileanMoons.h"
#import "AAGalileanMoons.h"

KPCAAGalileanMoonDetails KPCAAGalileanMoonDetailsMake(CAAGalileanMoonDetail detailsPlus);
KPCAAGalileanMoonDetails KPCAAGalileanMoonDetailsMake(CAAGalileanMoonDetail detailsPlus)
{
    struct KPCAAGalileanMoonDetails details;
    details.MeanLongitude = detailsPlus.MeanLongitude;
    details.TrueLongitude = detailsPlus.TrueLongitude;
    details.TropicalLongitude = detailsPlus.TropicalLongitude;
    details.EquatorialLatitude = detailsPlus.EquatorialLatitude;
    details.r = detailsPlus.r;

    details.TrueRectangularCoordinateComponents = KPCAA3DCoordinateComponentsMake(detailsPlus.TrueRectangularCoordinates.X,
                                                                                  detailsPlus.TrueRectangularCoordinates.Y,
                                                                                  detailsPlus.TrueRectangularCoordinates.Z);

    details.ApparentRectangularCoordinateComponents = KPCAA3DCoordinateComponentsMake(detailsPlus.ApparentRectangularCoordinates.X,
                                                                                      detailsPlus.ApparentRectangularCoordinates.Y,
                                                                                      detailsPlus.ApparentRectangularCoordinates.Z);

    details.inTransit = detailsPlus.bInTransit;
    details.inOccultation = detailsPlus.bInOccultation;;
    details.inEclipse = detailsPlus.bInEclipse;
    details.inShadowTransit = detailsPlus.bInShadowTransit;
    
    return details;
}


KPCAAGalileanMoonsDetails KPCAAGalileanMoons_CalculateDetails(double JD, BOOL highPrecision)
{
    CAAGalileanMoonsDetails detailsPlus = CAAGalileanMoons::Calculate(JD, highPrecision);
    
    struct KPCAAGalileanMoonsDetails details;
    details.Satellite1 = KPCAAGalileanMoonDetailsMake(detailsPlus.Satellite1);
    details.Satellite2 = KPCAAGalileanMoonDetailsMake(detailsPlus.Satellite2);
    details.Satellite3 = KPCAAGalileanMoonDetailsMake(detailsPlus.Satellite3);
    details.Satellite4 = KPCAAGalileanMoonDetailsMake(detailsPlus.Satellite4);
    
    return details;
}

