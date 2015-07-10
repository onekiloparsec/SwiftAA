//
//  KPCAASaturnMoons.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 10/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KPCAA3DCoordinate.h"

@interface KPCAASaturnMoonDetail : NSObject

@property(nonatomic, strong) KPCAA3DCoordinate *TrueRectangularCoordinates;
@property(nonatomic, strong) KPCAA3DCoordinate *ApparentRectangularCoordinates;
@property(nonatomic, assign) BOOL isInTransit;
@property(nonatomic, assign) BOOL isInOccultation;
@property(nonatomic, assign) BOOL isInEclipse;
@property(nonatomic, assign) BOOL isInShadowTransit;

@end


@interface KPCAASaturnMoonsDetails : NSObject

@property(nonatomic, strong) KPCAASaturnMoonDetail *Satellite1;
@property(nonatomic, strong) KPCAASaturnMoonDetail *Satellite2;
@property(nonatomic, strong) KPCAASaturnMoonDetail *Satellite3;
@property(nonatomic, strong) KPCAASaturnMoonDetail *Satellite4;
@property(nonatomic, strong) KPCAASaturnMoonDetail *Satellite5;
@property(nonatomic, strong) KPCAASaturnMoonDetail *Satellite6;
@property(nonatomic, strong) KPCAASaturnMoonDetail *Satellite7;
@property(nonatomic, strong) KPCAASaturnMoonDetail *Satellite8;

@end

@interface KPCAASaturnMoons : NSObject

+ (KPCAASaturnMoonsDetails *)Calculate:(double)JD;

@end
