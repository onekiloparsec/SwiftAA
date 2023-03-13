//
//  KPCAAEquationOfTime.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 06/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import "PlatformHelpers.h"

#ifdef __cplusplus
extern "C" {
#endif

double KPCAAEquationOfTime_Calculate(double JD, bool highPrecision);

#if __cplusplus
}
#endif
