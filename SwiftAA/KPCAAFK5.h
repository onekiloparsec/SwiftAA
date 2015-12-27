//
//  KPCAAFK5.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 06/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KPCAA3DCoordinate.h"

double KPCAAFK5CorrectionInLongitude(double Longitude, double Latitude, double JD);
double KPCAAFK5CorrectionInLatitude(double Longitude, double JD);

KPCAA3DCoordinateComponents KPCAAFK5ConvertVSOPToFK5J2000(KPCAA3DCoordinateComponents components);
KPCAA3DCoordinateComponents KPCAAFK5ConvertVSOPToFK5B1950(KPCAA3DCoordinateComponents components);
KPCAA3DCoordinateComponents KPCAAFK5ConvertVSOPToFK5AnyEquinox(KPCAA3DCoordinateComponents components, double JDEquinox);

