/*
Module : AADiameters.h
Purpose: Implementation for the algorithms for the semi diameters of the Sun, Moon, Planets, and Asteroids
Created: PJN / 15-01-2004

Copyright (c) 2004 - 2019 by PJ Naughter (Web: www.naughter.com, Email: pjna@naughter.com)

All rights reserved.

Copyright / Usage Details:

You are allowed to include the source code in any product (commercial, shareware, freeware or otherwise) 
when your product is released in binary form. You are allowed to modify the source code in any way you want 
except you cannot modify the copyright details at the top of each module. If you want to distribute source 
code with your application, then you are only allowed to distribute versions released by the author. This is 
to maintain a single distribution point for the source code. 

*/


/////////////////////// Macros / Defines //////////////////////////////////////

#if _MSC_VER > 1000
#pragma once
#endif //#if _MSC_VER > 1000

#ifndef __AADIAMETERS_H__
#define __AADIAMETERS_H__

#ifndef AAPLUS_EXT_CLASS
#define AAPLUS_EXT_CLASS
#endif //#ifndef AAPLUS_EXT_CLASS


/////////////////////// Includes //////////////////////////////////////////////

#include "AACoordinateTransformation.h"


/////////////////////// Classes ///////////////////////////////////////////////

class AAPLUS_EXT_CLASS CAADiameters
{
public:
//Static methods
  constexpr static double SunSemidiameterA(double Delta)
  {
    return 959.63 / Delta;
  }

  constexpr static double MercurySemidiameterA(double Delta)
  {
    return 3.34 / Delta;
  }

  constexpr static double VenusSemidiameterA(double Delta)
  {
    return 8.41 / Delta;
  }

  constexpr static double MarsSemidiameterA(double Delta)
  {
    return 4.68 / Delta;
  }

  constexpr static double JupiterEquatorialSemidiameterA(double Delta)
  {
    return 98.47 / Delta;
  }

  constexpr static double JupiterPolarSemidiameterA(double Delta)
  {
    return 91.91 / Delta;
  }

  constexpr static double SaturnEquatorialSemidiameterA(double Delta)
  {
    return 83.33 / Delta;
  }

  constexpr static double SaturnPolarSemidiameterA(double Delta)
  {
    return 74.57 / Delta;
  }

  constexpr static double UranusSemidiameterA(double Delta)
  {
    return 34.28/Delta;
  }

  constexpr static double NeptuneSemidiameterA(double Delta)
  {
    return 36.56/Delta;
  }

  constexpr static double MercurySemidiameterB(double Delta)
  {
    return 3.36/Delta;
  }

  constexpr static double VenusSemidiameterB(double Delta)
  {
    return 8.34/Delta;
  }

  constexpr static double MarsSemidiameterB(double Delta)
  {
    return 4.68/Delta;
  }

  constexpr static double JupiterEquatorialSemidiameterB(double Delta)
  {
    return 98.44/Delta;
  }

  constexpr static double JupiterPolarSemidiameterB(double Delta)
  {
    return 92.06/Delta;
  }

  constexpr static double SaturnEquatorialSemidiameterB(double Delta)
  {
    return 82.73/Delta;
  }

  constexpr static double SaturnPolarSemidiameterB(double Delta)
  {
    return 73.82/Delta;
  }

  constexpr static double UranusSemidiameterB(double Delta)
  {
    return 35.02 / Delta;
  }

  constexpr static double NeptuneSemidiameterB(double Delta)
  {
    return 33.50 / Delta;
  }

  constexpr static double PlutoSemidiameterB(double Delta)
  {
    return 2.07 / Delta;
  }

  constexpr static double GeocentricMoonSemidiameter(double Delta)
  {
    return CAACoordinateTransformation::RadiansToDegrees(0.272481*6378.14 / Delta) * 3600;
  }

  constexpr static double ApparentAsteroidDiameter(double Delta, double d)
  {
    return 0.0013788*d / Delta;
  }

  static double ApparentSaturnPolarSemidiameterA(double Delta, double B) noexcept;
  static double ApparentSaturnPolarSemidiameterB(double Delta, double B) noexcept;
  static double TopocentricMoonSemidiameter(double DistanceDelta, double Delta, double H, double Latitude, double Height) noexcept;
  static double AsteroidDiameter(double H, double A) noexcept;
};


#endif //#ifndef __AADIAMETERS_H__
