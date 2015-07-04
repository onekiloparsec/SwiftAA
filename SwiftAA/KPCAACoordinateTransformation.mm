//
//  KPCAACoordinateTransformation.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 04/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import "KPCAACoordinateTransformation.h"
#import "AACoordinateTransformation.h"

@implementation KPCAACoordinateTransformation

+ (KPCAA2DCoordinate *)Equatorial2EclipticForRightAscension:(double)Alpha declination:(double)Delta epoch:(double)Epsilon
{
    return [KPCAA2DCoordinate coordinateByWrapping:CAACoordinateTransformation::Equatorial2Ecliptic(Alpha, Delta, Epsilon)];
}

+ (KPCAA2DCoordinate *)Ecliptic2EquatorialForCelestialLongitude:(double)Lambda celestialLatitude:(double)Beta epoch:(double)Epsilon
{
    return [KPCAA2DCoordinate coordinateByWrapping:CAACoordinateTransformation::Ecliptic2Equatorial(Lambda, Beta, Epsilon)];
}

+ (KPCAA2DCoordinate *)Equatorial2HorizontalForLocalHourAngle:(double)lha declination:(double)Delta latitude:(double)latitude
{
    return [KPCAA2DCoordinate coordinateByWrapping:CAACoordinateTransformation::Equatorial2Horizontal(lha, Delta, latitude)];
}

+ (KPCAA2DCoordinate *)Horizontal2EquatorialForAzimuth:(double)A altitude:(double)h latitude:(double)latitude
{
    return [KPCAA2DCoordinate coordinateByWrapping:CAACoordinateTransformation::Horizontal2Equatorial(A, h, latitude)];
}

+ (KPCAA2DCoordinate *)Equatorial2GalacticForRightAscension:(double)Alpha declination:(double)Delta
{
    return [KPCAA2DCoordinate coordinateByWrapping:CAACoordinateTransformation::Equatorial2Galactic(Alpha, Delta)];
}

+ (KPCAA2DCoordinate *)Galactic2EquatorialForGalacticLongitude:(double)l galacticLatitude:(double)b
{
    return [KPCAA2DCoordinate coordinateByWrapping:CAACoordinateTransformation::Galactic2Equatorial(l, b)];
}

@end
