//
//  KPCAAAberration.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 04/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import <Foundation/Foundation.h>
#import "KPCAA2DCoordinate.h"
#import "KPCAA3DCoordinate.h"

// 3D
KPCAA3DCoordinateComponents KPCEarthVelocity(double JD, BOOL highPrecision);

// 2D
KPCAA2DCoordinateComponents KPCEclipticAberration(double Alpha, double Delta, double JD, BOOL highPrecision);
KPCAA2DCoordinateComponents KPCEquatorialAberration(double Lambda, double Beta, double JD, BOOL highPrecision);
