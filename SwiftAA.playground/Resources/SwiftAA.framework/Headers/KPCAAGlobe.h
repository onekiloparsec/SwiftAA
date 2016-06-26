//
//  KPCAAGlobe.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 08/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import <Foundation/Foundation.h>

#ifdef __cplusplus
extern "C" {
#endif

double KPCAAGlobe_RhoSinThetaPrime(double GeographicalLatitude, double Height);
double KPCAAGlobe_RhoCosThetaPrime(double GeographicalLatitude, double Height);
double KPCAAGlobe_RadiusOfParallelOfLatitude(double GeographicalLatitude);
double KPCAAGlobe_RadiusOfCurvature(double GeographicalLatitude);

double KPCAAGlobe_DistanceBetweenPoints(double GeographicalLatitude1,
                                        double GeographicalLongitude1,
                                        double GeographicalLatitude2,
                                        double GeographicalLongitude2);


#if __cplusplus
}
#endif
