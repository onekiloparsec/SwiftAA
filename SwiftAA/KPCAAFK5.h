//
//  KPCAAFK5.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 06/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import <Foundation/Foundation.h>
#import "KPCAA3DCoordinate.h"

#ifdef __cplusplus
extern "C" {
#endif

double KPCAAFK5_CorrectionInLongitude(double Longitude, double Latitude, double JD);
double KPCAAFK5_CorrectionInLatitude(double Longitude, double JD);

KPCAA3DCoordinateComponents KPCAAFK5_ConvertVSOPToFK5J2000(KPCAA3DCoordinateComponents components);
KPCAA3DCoordinateComponents KPCAAFK5_ConvertVSOPToFK5B1950(KPCAA3DCoordinateComponents components);
KPCAA3DCoordinateComponents KPCAAFK5_ConvertVSOPToFK5AnyEquinox(KPCAA3DCoordinateComponents components, double JDEquinox);

#if __cplusplus
}
#endif
