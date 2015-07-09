//
//  KPCAANutation.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 09/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KPCAANutation : NSObject

+ (double)NutationInLongitude:(double)JD;
+ (double)NutationInObliquity:(double)JD;
+ (double)NutationInRightAscension:(double)Alpha Delta:(double)Delta Obliquity:(double)Obliquity NutationInLongitude:(double)NutationInLongitude NutationInObliquity:(double)NutationInObliquity;
+ (double)NutationInDeclination:(double)Alpha Obliquity:(double)Obliquity NutationInLongitude:(double)NutationInLongitude NutationInObliquity:(double)NutationInObliquity;
+ (double)MeanObliquityOfEcliptic:(double)JD;
+ (double)TrueObliquityOfEcliptic:(double)JD;

@end
