//
//  KPCAANutation.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 09/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import "KPCAANutation.h"
#import "AANutation.h"


double KPCAANutation_NutationInLongitude(double JD)
{
    return CAANutation::NutationInLongitude(JD);
}

double KPCAANutation_NutationInObliquity(double JD)
{
    return CAANutation::NutationInObliquity(JD);
}

double KPCAANutation_NutationInRightAscension(double Alpha, double Delta, double Obliquity, double NutationInLongitude, double NutationInObliquity)
{
    return CAANutation::NutationInRightAscension(Alpha, Delta, Obliquity, NutationInLongitude, NutationInObliquity);
}
double KPCAANutation_NutationInDeclination(double Alpha, double Obliquity, double NutationInLongitude, double NutationInObliquity)
{
    return CAANutation::NutationInDeclination(Alpha, Obliquity, NutationInLongitude, NutationInObliquity);
}

double KPCAANutation_MeanObliquityOfEcliptic(double JD)
{
    return CAANutation::MeanObliquityOfEcliptic(JD);
}

double KPCAANutation_TrueObliquityOfEcliptic(double JD)
{
    return CAANutation::TrueObliquityOfEcliptic(JD);
}

double KPCAANutation_ObliquityOfEcliptic(BOOL mean, double JD)
{
    if (mean) {
        return CAANutation::MeanObliquityOfEcliptic(JD);
    }
    else {
        return CAANutation::TrueObliquityOfEcliptic(JD);
    }
}

