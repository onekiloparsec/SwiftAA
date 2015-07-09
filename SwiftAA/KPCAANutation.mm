//
//  KPCAANutation.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 09/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import "KPCAANutation.h"
#import "AANutation.h"

@implementation KPCAANutation

+ (double)NutationInLongitude:(double)JD
{
    return CAANutation::NutationInLongitude(JD);
}
+ (double)NutationInObliquity:(double)JD
{
    return CAANutation::NutationInObliquity(JD);
}

+ (double)NutationInRightAscension:(double)Alpha Delta:(double)Delta Obliquity:(double)Obliquity NutationInLongitude:(double)NutationInLongitude NutationInObliquity:(double)NutationInObliquity
{
    return CAANutation::NutationInRightAscension(Alpha, Delta, Obliquity, NutationInLongitude, NutationInObliquity);
}
+ (double)NutationInDeclination:(double)Alpha Obliquity:(double)Obliquity NutationInLongitude:(double)NutationInLongitude NutationInObliquity:(double)NutationInObliquity
{
    return CAANutation::NutationInDeclination(Alpha, Obliquity, NutationInLongitude, NutationInObliquity);
}

+ (double)MeanObliquityOfEcliptic:(double)JD
{
    return CAANutation::MeanObliquityOfEcliptic(JD);
}

+ (double)TrueObliquityOfEcliptic:(double)JD
{
    return CAANutation::TrueObliquityOfEcliptic(JD);
}

@end
