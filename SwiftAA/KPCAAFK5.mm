//
//  KPCAAFK5.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 06/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import "KPCAAFK5.h"
#import "AAFK5.h"

@implementation KPCAAFK5

+ (double)CorrectionInLongitude:(double)Longitude latitude:(double)Latitude JD:(double)JD
{
    return CAAFK5::CorrectionInLongitude(Longitude, Latitude, JD);
}

+ (double)CorrectionInLatitude:(double)Longitude JD:(double)JD
{
    return CAAFK5::CorrectionInLatitude(Longitude, JD);
}

+ (KPCAA3DCoordinate *)ConvertVSOPToFK5J2000:(KPCAA3DCoordinate * __autoreleasing *)value
{
    CAA3DCoordinate wrappedCoord = (*value).wrappedCoord;
    return [KPCAA3DCoordinate coordinateByWrapping:CAAFK5::ConvertVSOPToFK5J2000(wrappedCoord)];
}

+ (KPCAA3DCoordinate *)ConvertVSOPToFK5B1950:(KPCAA3DCoordinate * __autoreleasing *)value
{
    CAA3DCoordinate wrappedCoord = (*value).wrappedCoord;
    return [KPCAA3DCoordinate coordinateByWrapping:CAAFK5::ConvertVSOPToFK5B1950(wrappedCoord)];
}

+ (KPCAA3DCoordinate *)ConvertVSOPToFK5AnyEquinox:(KPCAA3DCoordinate * __autoreleasing *)value JDEquinox:(double)JDEquinox
{
    CAA3DCoordinate wrappedCoord = (*value).wrappedCoord;
    return [KPCAA3DCoordinate coordinateByWrapping:CAAFK5::ConvertVSOPToFK5AnyEquinox(wrappedCoord, JDEquinox)];
}

@end
