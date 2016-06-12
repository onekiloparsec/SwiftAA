//
//  KPCAAMoonMaxDeclinations.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 09/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import <Foundation/Foundation.h>

@interface KPCAAMoonMaxDeclinations : NSObject

+ (double)K:(double)Year;
+ (double)MeanGreatestDeclination:(double)k northerly:(BOOL)northerly;
+ (double)MeanGreatestDeclinationValue:(double)k;
+ (double)TrueGreatestDeclination:(double)k northerly:(BOOL)northerly;
+ (double)TrueGreatestDeclinationValue:(double)k northerly:(BOOL)northerly;

@end
