//
//  KPCAAAberration.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 04/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KPCAA2DCoordinate.h"
#import "KPCAA3DCoordinate.h"

// 3D
KPCAA3DCoordinateComponents EarthVelocity(double JD);

// 2D
KPCAA2DCoordinateComponents EclipticAberrationForAlpha(double Alpha, double Delta, double JD);
KPCAA2DCoordinateComponents EquatorialAberrationForLambda(double Lambda, double Beta, double JD);

