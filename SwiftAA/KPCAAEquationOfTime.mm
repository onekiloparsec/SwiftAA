//
//  KPCAAEquationOfTime.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 06/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import "KPCAAEquationOfTime.h"
#import "AAEquationOfTime.h"

double KPCAAEquationOfTime_Calculate(double JD, BOOL highPrecision)
{
    return CAAEquationOfTime::Calculate(JD, highPrecision);
}