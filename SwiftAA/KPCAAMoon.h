//
//  KPCAAMoon.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 09/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import <Foundation/Foundation.h>

double KPCAAMoonMeanLongitude(double JD);
double KPCAAMoonMeanElongation(double JD);
double KPCAAMoonMeanAnomaly(double JD);
double KPCAAMoonArgumentOfLatitude(double JD);
double KPCAAMoonMeanLongitudeAscendingNode(double JD);
double KPCAAMoonMeanLongitudePerigee(double JD);
double KPCAAMoonTrueLongitudeAscendingNode(double JD);

double KPCAAMoonEclipticLongitude(double JD);
double KPCAAMoonEclipticLatitude(double JD);
double KPCAAMoonRadiusVector(double JD);

double KPCAAMoonRadiusVectorToHorizontalParallax(double RadiusVector);
double KPCAAMoonHorizontalParallaxToRadiusVector(double Parallax);

