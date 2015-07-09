//
//  KPCAAEclipses.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 04/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KPCAASolarEclipseDetails : NSObject

@property(nonatomic, assign) BOOL eclipse;
@property(nonatomic, assign) double TimeOfMaximumEclipse;
@property(nonatomic, assign) double F;
@property(nonatomic, assign) double u;
@property(nonatomic, assign) double gamma;
@property(nonatomic, assign) double GreatestMagnitude;

@end

@interface KPCAALunarEclipseDetails : NSObject

@property(nonatomic, assign) BOOL eclipse;
@property(nonatomic, assign) double TimeOfMaximumEclipse;
@property(nonatomic, assign) double F;
@property(nonatomic, assign) double u;
@property(nonatomic, assign) double gamma;
@property(nonatomic, assign) double PenumbralRadii;
@property(nonatomic, assign) double UmbralRadii;
@property(nonatomic, assign) double PenumbralMagnitude;
@property(nonatomic, assign) double UmbralMagnitude;
@property(nonatomic, assign) double PartialPhaseSemiDuration;
@property(nonatomic, assign) double TotalPhaseSemiDuration;
@property(nonatomic, assign) double PartialPhasePenumbraSemiDuration;

@end

@interface KPCAAEclipses : NSObject

+ (KPCAASolarEclipseDetails *)CalculateSolar:(double)k;
+ (KPCAALunarEclipseDetails *)CalculateLunar:(double)k;

@end