//
//  KPCAAEquinoxesAndSolstices.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 06/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import <Foundation/Foundation.h>

#ifdef __cplusplus
extern "C" {
#endif

double KPCAAEquinoxesAndSolstices_NorthwardEquinox(long Year, BOOL highPrecision);
double KPCAAEquinoxesAndSolstices_NorthernSolstice(long Year, BOOL highPrecision);
double KPCAAEquinoxesAndSolstices_SouthwardEquinox(long Year, BOOL highPrecision);
double KPCAAEquinoxesAndSolstices_SouthernSolstice(long Year, BOOL highPrecision);

double KPCAAEquinoxesAndSolstices_LengthOfSpring(long Year, BOOL northernHemisphere, BOOL highPrecision);
double KPCAAEquinoxesAndSolstices_LengthOfSummer(long Year, BOOL northernHemisphere, BOOL highPrecision);
double KPCAAEquinoxesAndSolstices_LengthOfAutumn(long Year, BOOL northernHemisphere, BOOL highPrecision);
double KPCAAEquinoxesAndSolstices_LengthOfWinter(long Year, BOOL northernHemisphere, BOOL highPrecision);

#if __cplusplus
}
#endif
