//
//  KPCAADynamicalTime.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 04/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import <Foundation/Foundation.h>

double KPCAADynamicalTimeDeltaT(double JD);
double KPCAADynamicalTimeCumulativeLeapSeconds(double JD);
double KPCAADynamicalTimeTT2UTC(double JD);
double KPCAADynamicalTimeUTC2TT(double JD);
double KPCAADynamicalTimeTT2TAI(double JD);
double KPCAADynamicalTimeTAI2TT(double JD);
double KPCAADynamicalTimeTT2UT1(double JD);
double KPCAADynamicalTimeUT12TT(double JD);
double KPCAADynamicalTimeUT1MinusUTC(double JD);

