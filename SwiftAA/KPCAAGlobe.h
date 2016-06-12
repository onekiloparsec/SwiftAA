//
//  KPCAAGlobe.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 08/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import <Foundation/Foundation.h>

double KPCAAGlobeRhoSinThetaPrime(double GeographicalLatitude, double Height);
double KPCAAGlobeRhoCosThetaPrime(double GeographicalLatitude, double Height);
double KPCAAGlobeRadiusOfParallelOfLatitude(double GeographicalLatitude);
double KPCAAGlobeRadiusOfCurvature(double GeographicalLatitude);

double KPCAAGlobeDistanceBetweenPoints(double GeographicalLatitude1,
                                       double GeographicalLongitude1,
                                       double GeographicalLatitude2,
                                       double GeographicalLongitude2);

