//
//  KPCAAPrecession.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 10/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import "KPCAAPrecession.h"
#import "AAPrecession.h"

KPCAA2DCoordinateComponents KPCAAPrecessEquatorial(double Alpha, double Delta, double JD0, double JD)
{
    CAA2DCoordinate coords = CAAPrecession::PrecessEquatorial(Alpha, Delta, JD0, JD);
    return KPCAA2DCoordinateComponentsMake(coords.X, coords.Y);
}

KPCAA2DCoordinateComponents KPCAAPrecessEquatorialFK4(double Alpha, double Delta, double JD0, double JD)
{
    CAA2DCoordinate coords = CAAPrecession::PrecessEquatorialFK4(Alpha, Delta, JD0, JD);
    return KPCAA2DCoordinateComponentsMake(coords.X, coords.Y);
}

KPCAA2DCoordinateComponents KPCAAPrecessEcliptic(double Lambda, double Beta, double JD0, double JD)
{
    CAA2DCoordinate coords = CAAPrecession::PrecessEcliptic(Lambda, Beta, JD0, JD);
    return KPCAA2DCoordinateComponentsMake(coords.X, coords.Y);
}

KPCAA2DCoordinateComponents KPCAAEquatorialPMToEcliptic(double Alpha, double Delta, double Beta, double PMAlpha, double PMDelta, double Epsilon)
{
    CAA2DCoordinate coords = CAAPrecession::EquatorialPMToEcliptic(Alpha, Delta, Beta, PMAlpha, PMDelta, Epsilon);
    return KPCAA2DCoordinateComponentsMake(coords.X, coords.Y);
}

KPCAA2DCoordinateComponents KPCAAAdjustPositionUsingUniformProperMotion(double t, double Alpha, double Delta, double PMAlpha, double PMDelta)
{
    CAA2DCoordinate coords = CAAPrecession::AdjustPositionUsingUniformProperMotion(t, Alpha, Delta, PMAlpha, PMDelta);
    return KPCAA2DCoordinateComponentsMake(coords.X, coords.Y);
}

KPCAA2DCoordinateComponents KPCAAAdjustPositionUsingMotionInSpace(double r, double deltar, double t, double Alpha, double Delta, double PMAlpha, double PMDelta)
{
    CAA2DCoordinate coords = CAAPrecession::AdjustPositionUsingMotionInSpace(r, deltar, t, Alpha, Delta, PMAlpha, PMDelta);
    return KPCAA2DCoordinateComponentsMake(coords.X, coords.Y);
}
    
