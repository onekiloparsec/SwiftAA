//
//  KPCAAEquinoxesAndSolstices.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 06/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import "KPCAAEquinoxesAndSolstices.h"
#import "AAEquinoxesAndSolstices.h"

double KPCAAEquinoxesAndSolsticesNorthwardEquinox(long Year, BOOL highPrecision)
{
    return CAAEquinoxesAndSolstices::NorthwardEquinox(Year, highPrecision);
}

double KPCAAEquinoxesAndSolsticesNorthernSolstice(long Year, BOOL highPrecision)
{
    return CAAEquinoxesAndSolstices::NorthernSolstice(Year, highPrecision);
}

double KPCAAEquinoxesAndSolsticesSouthwardEquinox(long Year, BOOL highPrecision)
{
    return CAAEquinoxesAndSolstices::SouthwardEquinox(Year, highPrecision);
}

double KPCAAEquinoxesAndSolsticesSouthernSolstice(long Year, BOOL highPrecision)
{
    return CAAEquinoxesAndSolstices::SouthernSolstice(Year, highPrecision);
}

double KPCAAEquinoxesAndSolsticesLengthOfSpring(long Year, BOOL northernHemisphere, BOOL highPrecision)
{
    return CAAEquinoxesAndSolstices::LengthOfSpring(Year, (bool)northernHemisphere, highPrecision);
}

double KPCAAEquinoxesAndSolsticesLengthOfSummer(long Year, BOOL northernHemisphere, BOOL highPrecision)
{
    return CAAEquinoxesAndSolstices::LengthOfSummer(Year, (bool)northernHemisphere, highPrecision);
}

double KPCAAEquinoxesAndSolsticesLengthOfAutumn(long Year, BOOL northernHemisphere, BOOL highPrecision)
{
    return CAAEquinoxesAndSolstices::LengthOfAutumn(Year, (bool)northernHemisphere, highPrecision);
}

double KPCAAEquinoxesAndSolsticesLengthOfWinter(long Year, BOOL northernHemisphere, BOOL highPrecision)
{
    return CAAEquinoxesAndSolstices::LengthOfWinter(Year, (bool)northernHemisphere, highPrecision);
}
