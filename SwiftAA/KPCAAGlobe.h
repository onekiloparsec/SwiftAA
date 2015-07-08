//
//  KPCAAGlobe.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 08/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KPCAAGlobe : NSObject

+ (double)RhoSinThetaPrime:(double)GeographicalLatitude height:(double)Height;
+ (double)RhoCosThetaPrime:(double)GeographicalLatitude height:(double)Height;
+ (double)RadiusOfParallelOfLatitude:(double)GeographicalLatitude;
+ (double)RadiusOfCurvature:(double)GeographicalLatitude;

+ (double)DistanceBetweenPointsWithGeographicalLatitude1:(double)GeographicalLatitude1 GeographicalLongitude1:(double)GeographicalLongitude1 GeographicalLatitude2:(double)GeographicalLatitude2 GeographicalLongitude2:(double)GeographicalLongitude2;

@end
