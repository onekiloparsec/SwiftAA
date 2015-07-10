//
//  KPCAASun.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 10/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import "KPCAASun.h"
#import "AASun.h"

@interface KPCAA3DCoordinate ()
+ (KPCAA3DCoordinate *)coordinateByWrapping:(CAA3DCoordinate)wrappedCoord;
- (CAA3DCoordinate)wrappedCoord;
@end

@implementation KPCAASun

+ (double)GeometricEclipticLongitude:(double)JD
{
    return CAASun::GeometricEclipticLongitude(JD);
}

+ (double)GeometricEclipticLatitude:(double)JD
{
    return CAASun::GeometricEclipticLatitude(JD);
}

+ (double)GeometricEclipticLongitudeJ2000:(double)JD
{
    return CAASun::GeometricEclipticLongitudeJ2000(JD);
}

+ (double)GeometricEclipticLatitudeJ2000:(double)JD
{
    return CAASun::GeometricEclipticLatitudeJ2000(JD);
}

+ (double)GeometricFK5EclipticLongitude:(double)JD
{
    return CAASun::GeometricFK5EclipticLongitude(JD);
}

+ (double)GeometricFK5EclipticLatitude:(double)JD
{
    return CAASun::GeometricFK5EclipticLatitude(JD);
}

+ (double)ApparentEclipticLongitude:(double)JD
{
    return CAASun::ApparentEclipticLongitude(JD);
}

+ (double)ApparentEclipticLatitude:(double)JD
{
    return CAASun::ApparentEclipticLatitude(JD);
}

+ (KPCAA3DCoordinate *)EquatorialRectangularCoordinatesMeanEquinox:(double)JD
{
    return [KPCAA3DCoordinate coordinateByWrapping:CAASun::EquatorialRectangularCoordinatesMeanEquinox(JD)];
}

+ (KPCAA3DCoordinate *)EclipticRectangularCoordinatesJ2000:(double)JD
{
    return [KPCAA3DCoordinate coordinateByWrapping:CAASun::EclipticRectangularCoordinatesJ2000(JD)];
}

+ (KPCAA3DCoordinate *)EquatorialRectangularCoordinatesJ2000:(double)JD
{
    return [KPCAA3DCoordinate coordinateByWrapping:CAASun::EquatorialRectangularCoordinatesJ2000(JD)];
}

+ (KPCAA3DCoordinate *)EquatorialRectangularCoordinatesB1950:(double)JD
{
    return [KPCAA3DCoordinate coordinateByWrapping:CAASun::EquatorialRectangularCoordinatesB1950(JD)];
}

+ (KPCAA3DCoordinate *)EquatorialRectangularCoordinatesAnyEquinox:(double)JD JDEquinox:(double)JDEquinox
{
    return [KPCAA3DCoordinate coordinateByWrapping:CAASun::EquatorialRectangularCoordinatesAnyEquinox(JD, JDEquinox)];
}

@end
