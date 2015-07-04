//
//  KPCAACoordinateTransformation.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 04/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KPCAA2DCoordinate.h"

@interface KPCAACoordinateTransformation : NSObject

+ (KPCAA2DCoordinate *)Equatorial2EclipticForRightAscension:(double)Alpha declination:(double)Delta epoch:(double)Epsilon;

+ (KPCAA2DCoordinate *)Ecliptic2EquatorialForCelestialLongitude:(double)Lambda celestialLatitude:(double)Beta epoch:(double)Epsilon;

+ (KPCAA2DCoordinate *)Equatorial2HorizontalForLocalHourAngle:(double)lha declination:(double)Delta latitude:(double)latitude;

+ (KPCAA2DCoordinate *)Horizontal2EquatorialForAzimuth:(double)A altitude:(double)h latitude:(double)latitude;

+ (KPCAA2DCoordinate *)Equatorial2GalacticForRightAscension:(double)Alpha declination:(double)Delta;

+ (KPCAA2DCoordinate *)Galactic2EquatorialForGalacticLongitude:(double)l galacticLatitude:(double)b;

@end
