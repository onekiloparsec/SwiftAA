//
//  KPCAAEquinoxesAndSolstices.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 06/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import "KPCAAEquinoxesAndSolstices.h"
#import "AAEquinoxesAndSolstices.h"

double KPCAAEquinoxesAndSolstices_NorthwardEquinox(long Year, bool highPrecision)
{
    return CAAEquinoxesAndSolstices::NorthwardEquinox(Year, highPrecision);
}

double KPCAAEquinoxesAndSolstices_NorthernSolstice(long Year, bool highPrecision)
{
    return CAAEquinoxesAndSolstices::NorthernSolstice(Year, highPrecision);
}

double KPCAAEquinoxesAndSolstices_SouthwardEquinox(long Year, bool highPrecision)
{
    return CAAEquinoxesAndSolstices::SouthwardEquinox(Year, highPrecision);
}

double KPCAAEquinoxesAndSolstices_SouthernSolstice(long Year, bool highPrecision)
{
    return CAAEquinoxesAndSolstices::SouthernSolstice(Year, highPrecision);
}

double KPCAAEquinoxesAndSolstices_LengthOfSpring(long Year, bool northernHemisphere, bool highPrecision)
{
    return CAAEquinoxesAndSolstices::LengthOfSpring(Year, (bool)northernHemisphere, highPrecision);
}

double KPCAAEquinoxesAndSolstices_LengthOfSummer(long Year, bool northernHemisphere, bool highPrecision)
{
    return CAAEquinoxesAndSolstices::LengthOfSummer(Year, (bool)northernHemisphere, highPrecision);
}

double KPCAAEquinoxesAndSolstices_LengthOfAutumn(long Year, bool northernHemisphere, bool highPrecision)
{
    return CAAEquinoxesAndSolstices::LengthOfAutumn(Year, (bool)northernHemisphere, highPrecision);
}

double KPCAAEquinoxesAndSolstices_LengthOfWinter(long Year, bool northernHemisphere, bool highPrecision)
{
    return CAAEquinoxesAndSolstices::LengthOfWinter(Year, (bool)northernHemisphere, highPrecision);
}
