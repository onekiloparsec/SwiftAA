//
//  KPCAAMoonMaxDeclinations.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 09/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KPCAAMoonMaxDeclinations : NSObject

+ (double)K:(double)Year;
+ (double)MeanGreatestDeclination:(double)k northerly:(BOOL)northerly;
+ (double)MeanGreatestDeclinationValue:(double)k;
+ (double)TrueGreatestDeclination:(double)k northerly:(BOOL)northerly;
+ (double)TrueGreatestDeclinationValue:(double)k northerly:(BOOL)northerly;

@end
