//
//  KPCAAEquationOfTime.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 06/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import "KPCAAEquationOfTime.h"
#import "AAEquationOfTime.h"

@implementation KPCAAEquationOfTime

+ (double)Calculate:(double)JD
{
    return CAAEquationOfTime::Calculate(JD);
}

@end
