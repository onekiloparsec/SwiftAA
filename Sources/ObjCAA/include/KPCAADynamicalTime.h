//
//  KPCAADynamicalTime.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 04/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import <Foundation/Foundation.h>

#ifdef __cplusplus
extern "C" {
#endif

double KPCAADynamicalTime_DeltaT(double JD);
double KPCAADynamicalTime_CumulativeLeapSeconds(double JD);
double KPCAADynamicalTime_TT2UTC(double JD);
double KPCAADynamicalTime_UTC2TT(double JD);
double KPCAADynamicalTime_TT2TAI(double JD);
double KPCAADynamicalTime_TAI2TT(double JD);
double KPCAADynamicalTime_TT2UT1(double JD);
double KPCAADynamicalTime_UT12TT(double JD);
double KPCAADynamicalTime_UT1MinusUTC(double JD);

#if __cplusplus
}
#endif
