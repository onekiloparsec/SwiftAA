//
//  KPCAAFK5.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 06/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KPCAA3DCoordinate.h"

@interface KPCAAFK5 : NSObject

+ (double)CorrectionInLongitude:(double)Longitude latitude:(double)Latitude JD:(double)JD;
+ (double)CorrectionInLatitude:(double)Longitude JD:(double)JD;
+ (KPCAA3DCoordinate *)ConvertVSOPToFK5J2000:(KPCAA3DCoordinate * __autoreleasing *)value;
+ (KPCAA3DCoordinate *)ConvertVSOPToFK5B1950:(KPCAA3DCoordinate * __autoreleasing *)value;
+ (KPCAA3DCoordinate *)ConvertVSOPToFK5AnyEquinox:(KPCAA3DCoordinate * __autoreleasing *)value JDEquinox:(double)JDEquinox;

@end
