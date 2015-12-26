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
KPCAA3DCoordinateComponents KPCEarthVelocityForJulianDay(double JD, BOOL highPrecision);

// 2D
KPCAA2DCoordinateComponents KPCEclipticAberrationForAlphaDeltaJulianDay(double Alpha, double Delta, double JD, BOOL highPrecision);
KPCAA2DCoordinateComponents KPCEquatorialAberrationForLambdaBetaJulianDay(double Lambda, double Beta, double JD, BOOL highPrecision);
