//
//  KPCAAEquinoxesAndSolstices.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 06/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import "PlatformHelpers.h"

#ifdef __cplusplus
extern "C" {
#endif

double KPCAAEquinoxesAndSolstices_NorthwardEquinox(long Year, bool highPrecision);
double KPCAAEquinoxesAndSolstices_NorthernSolstice(long Year, bool highPrecision);
double KPCAAEquinoxesAndSolstices_SouthwardEquinox(long Year, bool highPrecision);
double KPCAAEquinoxesAndSolstices_SouthernSolstice(long Year, bool highPrecision);

double KPCAAEquinoxesAndSolstices_LengthOfSpring(long Year, bool northernHemisphere, bool highPrecision);
double KPCAAEquinoxesAndSolstices_LengthOfSummer(long Year, bool northernHemisphere, bool highPrecision);
double KPCAAEquinoxesAndSolstices_LengthOfAutumn(long Year, bool northernHemisphere, bool highPrecision);
double KPCAAEquinoxesAndSolstices_LengthOfWinter(long Year, bool northernHemisphere, bool highPrecision);

#if __cplusplus
}
#endif
