//
//  KPCAAGalileanMoons.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 08/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KPCAA3DCoordinate.h"

@interface KPCAAGalileanMoonDetail : NSObject

@property(nonatomic, assign) double MeanLongitude;
@property(nonatomic, assign) double TrueLongitude;
@property(nonatomic, assign) double TropicalLongitude;
@property(nonatomic, assign) double EquatorialLatitude;
@property(nonatomic, assign) double r;
@property(nonatomic, strong) KPCAA3DCoordinate *TrueRectangularCoordinates;
@property(nonatomic, strong) KPCAA3DCoordinate *ApparentRectangularCoordinates;
@property(nonatomic, assign) BOOL inTransit;
@property(nonatomic, assign) BOOL inOccultation;
@property(nonatomic, assign) BOOL inEclipse;
@property(nonatomic, assign) BOOL inShadowTransit;

@end

@interface KPCAAGalileanMoonsDetails : NSObject

@property(nonatomic, strong) KPCAAGalileanMoonDetail *Satellite1;
@property(nonatomic, strong) KPCAAGalileanMoonDetail *Satellite2;
@property(nonatomic, strong) KPCAAGalileanMoonDetail *Satellite3;
@property(nonatomic, strong) KPCAAGalileanMoonDetail *Satellite4;

@end

@interface KPCAAGalileanMoons : NSObject

+ (KPCAAGalileanMoonsDetails *)Calculate:(double)JD;

@end
