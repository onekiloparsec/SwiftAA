//
//  KPCAAEquationOfTime.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 06/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import "KPCAAEquationOfTime.h"
#import "AAEquationOfTime.h"

double KPCAAEquationOfTime(double JD, BOOL highPrecision)
{
    return CAAEquationOfTime::Calculate(JD, highPrecision);
}