//
//  KPCAASidereal.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 10/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KPCAASidereal : NSObject

+ (double)MeanGreenwichSiderealTime:(double)JD;
+ (double)ApparentGreenwichSiderealTime:(double)JD;

@end
