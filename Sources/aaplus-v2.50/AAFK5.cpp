/*
Module : AAFK5.cpp
Purpose: Implementation for the algorithms to convert to the FK5 standard reference frame
Created: PJN / 29-12-2003
History: PJN / 23-06-2022 1. Updated all the code in AAFK5.cpp to use C++ uniform initialization for
                          all variable declarations.

Copyright (c) 2003 - 2023 by PJ Naughter (Web: www.naughter.com, Email: pjna@naughter.com)

All rights reserved.

Copyright / Usage Details:

You are allowed to include the source code in any product (commercial, shareware, freeware or otherwise) 
when your product is released in binary form. You are allowed to modify the source code in any way you want 
except you cannot modify the copyright details at the top of each module. If you want to distribute source 
code with your application, then you are only allowed to distribute versions released by the author. This is 
to maintain a single distribution point for the source code.

*/


//////////////////// Includes /////////////////////////////////////////////////

#include "stdafx.h"
#include "AAFK5.h"
#include "AACoordinateTransformation.h"
#include "AAEarth.h"
#include <cmath>


//////////////////// Implementation ///////////////////////////////////////////

double CAAFK5::CorrectionInLongitude(double Longitude, double Latitude, double JD) noexcept
{
  const double T{(JD - 2451545)/36525};
  double Ldash{Longitude - (1.397*T) - (0.00031*T*T)};

  //Convert to radians
  Ldash = CAACoordinateTransformation::DegreesToRadians(Ldash);
  Latitude = CAACoordinateTransformation::DegreesToRadians(Latitude);

  const double value{-0.09033 + (0.03916*(cos(Ldash) + sin(Ldash)))*tan(Latitude)};
  return CAACoordinateTransformation::DMSToDegrees(0, 0, value);
}

double CAAFK5::CorrectionInLatitude(double Longitude, double JD) noexcept
{
  const double T{(JD - 2451545)/36525};
  double Ldash{Longitude - (1.397*T) - (0.00031*T*T)};

  //Convert to radians
  Ldash = CAACoordinateTransformation::DegreesToRadians(Ldash);

  const double value{0.03916*(cos(Ldash) - sin(Ldash))};
  return CAACoordinateTransformation::DMSToDegrees(0, 0, value);
}

CAA3DCoordinate CAAFK5::ConvertVSOPToFK5J2000(const CAA3DCoordinate& value) noexcept
{
  CAA3DCoordinate result;
  result.X = value.X + (0.000000440360*value.Y) - (0.000000190919*value.Z);
  result.Y = (-0.000000479966*value.X) + (0.917482137087*value.Y) - (0.397776982902*value.Z);
  result.Z = (0.397776982902*value.Y) + (0.917482137087*value.Z);

  return result;
}

CAA3DCoordinate CAAFK5::ConvertVSOPToFK5B1950(const CAA3DCoordinate& value) noexcept
{
  CAA3DCoordinate result;
  result.X = (0.999925702634*value.X) + (0.012189716217*value.Y) + (0.000011134016*value.Z);
  result.Y = (-0.011179418036*value.X) + (0.917413998946*value.Y) - (0.397777041885*value.Z);
  result.Z = (-0.004859003787*value.X) + (0.397747363646*value.Y) + (0.917482111428*value.Z);

  return result;
}

CAA3DCoordinate CAAFK5::ConvertVSOPToFK5AnyEquinox(const CAA3DCoordinate& value, double JDEquinox) noexcept
{
  const double t{(JDEquinox - 2451545)/36525};
  const double tsquared{t*t};
  const double tcubed{tsquared*t};

  double sigma{(2306.2181*t) + (0.30188*tsquared) + (0.017988*tcubed)};
  sigma = CAACoordinateTransformation::DegreesToRadians(CAACoordinateTransformation::DMSToDegrees(0, 0, sigma));

  double zeta{(2306.2181*t) + (1.09468*tsquared) + (0.018203*tcubed)};
  zeta = CAACoordinateTransformation::DegreesToRadians(CAACoordinateTransformation::DMSToDegrees(0, 0, zeta));

  double phi{(2004.3109*t) - (0.42665*tsquared) - (0.041833*tcubed)};
  phi = CAACoordinateTransformation::DegreesToRadians(CAACoordinateTransformation::DMSToDegrees(0, 0, phi));

  const double cossigma{cos(sigma)};
  const double coszeta{cos(zeta)};
  const double cosphi{cos(phi)};
  const double sinsigma{sin(sigma)};
  const double sinzeta{sin(zeta)};
  const double sinphi{sin(phi)};

  const double xx{(cossigma*coszeta*cosphi) - (sinsigma*sinzeta)};
  const double xy{(sinsigma*coszeta) + (cossigma*sinzeta*cosphi)};
  const double xz{cossigma*sinphi};
  const double yx{(-cossigma*sinzeta) - (sinsigma*coszeta*cosphi)};
  const double yy{(cossigma*coszeta) - (sinsigma*sinzeta*cosphi)};
  const double yz{-sinsigma*sinphi};
  const double zx{-coszeta*sinphi};
  const double zy{-sinzeta*sinphi};
  const double zz{cosphi};

  CAA3DCoordinate result;
  result.X = (xx*value.X) + (yx*value.Y) + (zx*value.Z);
  result.Y = (xy*value.X) + (yy*value.Y) + (zy*value.Z);
  result.Z = (xz*value.X) + (yz*value.Y) + (zz*value.Z);

  return result;
}
