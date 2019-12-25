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

#ifdef __cplusplus
extern "C" {
#endif

// 3D
KPCAA3DCoordinateComponents KPCAAAberration_EarthVelocity(double JD, BOOL highPrecision);

// 2D
KPCAA2DCoordinateComponents KPCAAAberration_EquatorialAberration(double Alpha, double Delta, double JD, BOOL highPrecision);
KPCAA2DCoordinateComponents KPCAAAberration_EclipticAberration(double Lambda, double Beta, double JD, BOOL highPrecision);

#if __cplusplus
}
#endif
