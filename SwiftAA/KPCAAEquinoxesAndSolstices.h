//
//  KPCAAEquinoxesAndSolstices.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 06/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import <Foundation/Foundation.h>

double KPCAAEquinoxesAndSolsticesNorthwardEquinox(long Year, BOOL highPrecision);
double KPCAAEquinoxesAndSolsticesNorthernSolstice(long Year, BOOL highPrecision);
double KPCAAEquinoxesAndSolsticesSouthwardEquinox(long Year, BOOL highPrecision);
double KPCAAEquinoxesAndSolsticesSouthernSolstice(long Year, BOOL highPrecision);

double KPCAAEquinoxesAndSolsticesLengthOfSpring(long Year, BOOL northernHemisphere, BOOL highPrecision);
double KPCAAEquinoxesAndSolsticesLengthOfSummer(long Year, BOOL northernHemisphere, BOOL highPrecision);
double KPCAAEquinoxesAndSolsticesLengthOfAutumn(long Year, BOOL northernHemisphere, BOOL highPrecision);
double KPCAAEquinoxesAndSolsticesLengthOfWinter(long Year, BOOL northernHemisphere, BOOL highPrecision);
