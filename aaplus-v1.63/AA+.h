/*
Module : AA+.H
Purpose: Main include file for AA+ framework
Created: PJN / 30-1-2005

Copyright (c) 2003 - 2015 by PJ Naughter (Web: www.naughter.com, Email: pjna@naughter.com)

All rights reserved.

Copyright / Usage Details:

You are allowed to include the source code in any product (commercial, shareware, freeware or otherwise) 
when your product is released in binary form. You are allowed to modify the source code in any way you want 
except you cannot modify the copyright details at the top of each module. If you want to distribute source 
code with your application, then you are only allowed to distribute versions released by the author. This is 
to maintain a single distribution point for the source code. 

*/


/////////////////////////////// Macros / Defines //////////////////////////////

#if _MSC_VER > 1000
#pragma once
#endif //#if _MSC_VER > 1000

#ifndef __AAPLUS_H__
#define __AAPLUS_H__

#ifndef AAPLUS_EXT_CLASS
#define AAPLUS_EXT_CLASS
#endif //#ifndef AAPLUS_EXT_CLASS


/////////////////////////////// Includes //////////////////////////////////////

#include "AA2DCoordinate.h"
#include "AA3DCoordinate.h"
#include "AAAberration.h"
#include "AAAngularSeparation.h"
#include "AABinaryStar.h"
#include "AACoordinateTransformation.h"
#include "AADate.h"
#include "AADiameters.h"
#include "AADynamicalTime.h"
#include "AAEarth.h"
#include "AAEaster.h"
#include "AAEclipses.h"
#include "AAEclipticalElements.h"
#include "AAElementsPlanetaryOrbit.h"
#include "AAElliptical.h"
#include "AAEquationOfTime.h"
#include "AAEquinoxesAndSolstices.h"
#include "AAFK5.h"
#include "AAGalileanMoons.h"
#include "AAGlobe.h"
#include "AAIlluminatedFraction.h"
#include "AAInterpolate.h"
#include "AAJewishCalendar.h"
#include "AAJupiter.h"
#include "AAKepler.h"
#include "AAMars.h"
#include "AAMercury.h"
#include "AAMoon.h"
#include "AAMoonIlluminatedFraction.h"
#include "AAMoonMaxDeclinations.h"
#include "AAMoonNodes.h"
#include "AAMoonPerigeeApogee.h"
#include "AAMoonPhases.h"
#include "AAMoslemCalendar.h"
#include "AANearParabolic.h"
#include "AANeptune.h"
#include "AANodes.h"
#include "AANutation.h"
#include "AAParabolic.h"
#include "AAParallactic.h"
#include "AAParallax.h"
#include "AAPhysicalJupiter.h"
#include "AAPhysicalMars.h"
#include "AAPhysicalMoon.h"
#include "AAPhysicalSun.h"
#include "AAPlanetaryPhenomena.h"
#include "AAPlanetPerihelionAphelion.h"
#include "AAPluto.h"
#include "AAPrecession.h"
#include "AARefraction.h"
#include "AARiseTransitSet.h"
#include "AASaturn.h"
#include "AASaturnMoons.h"
#include "AASaturnRings.h"
#include "AASidereal.h"
#include "AAStellarMagnitudes.h"
#include "AASun.h"
#include "AAUranus.h"
#include "AAVenus.h"
#ifndef AAPLUS_VSOP87_NO_HIGH_PRECISION
#include "AAVSOP87.h"
#include "AAVSOP87_EMB.h"
#include "AAVSOP87_JUP.h"
#include "AAVSOP87_MAR.h"
#include "AAVSOP87_MER.h"
#include "AAVSOP87_NEP.h"
#include "AAVSOP87_SAT.h"
#include "AAVSOP87_URA.h"
#include "AAVSOP87_VEN.h"
#include "AAVSOP87A_EAR.h"
#include "AAVSOP87A_EMB.h"
#include "AAVSOP87A_JUP.h"
#include "AAVSOP87A_MAR.h"
#include "AAVSOP87A_MER.h"
#include "AAVSOP87A_NEP.h"
#include "AAVSOP87A_SAT.h"
#include "AAVSOP87A_URA.h"
#include "AAVSOP87A_VEN.h"
#include "AAVSOP87B_EAR.h"
#include "AAVSOP87B_JUP.h"
#include "AAVSOP87B_MAR.h"
#include "AAVSOP87B_MER.h"
#include "AAVSOP87B_NEP.h"
#include "AAVSOP87B_SAT.h"
#include "AAVSOP87B_URA.h"
#include "AAVSOP87B_VEN.h"
#include "AAVSOP87C_EAR.h"
#include "AAVSOP87C_JUP.h"
#include "AAVSOP87C_MAR.h"
#include "AAVSOP87C_MER.h"
#include "AAVSOP87C_NEP.h"
#include "AAVSOP87C_SAT.h"
#include "AAVSOP87C_URA.h"
#include "AAVSOP87C_VEN.h"
#include "AAVSOP87D_EAR.h"
#include "AAVSOP87D_JUP.h"
#include "AAVSOP87D_MAR.h"
#include "AAVSOP87D_MER.h"
#include "AAVSOP87D_NEP.h"
#include "AAVSOP87D_SAT.h"
#include "AAVSOP87D_URA.h"
#include "AAVSOP87D_VEN.h"
#include "AAVSOP87E_EAR.h"
#include "AAVSOP87E_JUP.h"
#include "AAVSOP87E_MAR.h"
#include "AAVSOP87E_MER.h"
#include "AAVSOP87E_NEP.h"
#include "AAVSOP87E_SAT.h"
#include "AAVSOP87E_SUN.h"
#include "AAVSOP87E_URA.h"
#include "AAVSOP87E_VEN.h"
#endif //#ifndef AAPLUS_VSOP87_NO_HIGH_PRECISION

#endif //#ifndef __AAPLUS_H__
