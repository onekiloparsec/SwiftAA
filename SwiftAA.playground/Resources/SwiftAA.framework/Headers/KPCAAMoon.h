//
//  KPCAAMoon.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 09/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import <Foundation/Foundation.h>

#ifdef __cplusplus
extern "C" {
#endif

double KPCAAMoon_MeanLongitude(double JD);
double KPCAAMoon_MeanElongation(double JD);
double KPCAAMoon_MeanAnomaly(double JD);
double KPCAAMoon_ArgumentOfLatitude(double JD);
double KPCAAMoon_MeanLongitudeAscendingNode(double JD);
double KPCAAMoon_MeanLongitudePerigee(double JD);
double KPCAAMoon_TrueLongitudeAscendingNode(double JD);

double KPCAAMoon_EclipticLongitude(double JD);
double KPCAAMoon_EclipticLatitude(double JD);
double KPCAAMoon_RadiusVector(double JD);

double KPCAAMoon_RadiusVectorToHorizontalParallax(double RadiusVector);
double KPCAAMoon_HorizontalParallaxToRadiusVector(double Parallax);

#if __cplusplus
}
#endif
