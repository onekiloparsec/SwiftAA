//
//  KPCAAEclipticalElements.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 05/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KPCAAEclipticalElementDetails : NSObject

@property(nonatomic, assign) double i;
@property(nonatomic, assign) double w;
@property(nonatomic, assign) double omega;

@end

@interface KPCAAEclipticalElements : NSObject

+ (KPCAAEclipticalElementDetails *)CalculateForI0:(double)i0 w0:(double)w0 omega0:(double)omega0 JD0:(double)JD0 JD:(double)JD;
+ (KPCAAEclipticalElementDetails *)FK4B1950ToFK5J2000ForI0:(double)i0 w0:(double)w0 omega0:(double)omega0;

@end
