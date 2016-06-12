//
//  KPCAAPrecession.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 10/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import <Foundation/Foundation.h>
#import "KPCAA2DCoordinate.h"

KPCAA2DCoordinateComponents KPCAAPrecessEquatorial(double Alpha, double Delta, double JD0, double JD);
KPCAA2DCoordinateComponents KPCAAPrecessEquatorialFK4(double Alpha, double Delta, double JD0, double JD);
KPCAA2DCoordinateComponents KPCAAPrecessEcliptic(double Lambda, double Beta, double JD0, double JD);

KPCAA2DCoordinateComponents KPCAAEquatorialPMToEcliptic(double Alpha, double Delta, double Beta, double PMAlpha, double PMDelta, double Epsilon);

KPCAA2DCoordinateComponents KPCAAAdjustPositionUsingUniformProperMotion(double t, double Alpha, double Delta, double PMAlpha, double PMDelta);

KPCAA2DCoordinateComponents KPCAAAdjustPositionUsingMotionInSpace(double r, double deltar, double t, double Alpha, double Delta, double PMAlpha, double PMDelta);
