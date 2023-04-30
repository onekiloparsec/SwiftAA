/*
Module : AAGlobe.cpp
Purpose: Implementation for the algorithms for the Earth's Globe
Created: PJN / 29-12-2003
History: PJN / 20-03-2016 1. Fixed a transcription error in the CAAGlobe::RhoSinThetaPrime and 
                          CAAGlobe::RhoCosThetaPrime functions. The value 6378149 was being used instead of 
                          the correct value 6378140. Thanks to "Pavel" for reporting this bug.
         PJN / 18-08-2019 1. Fixed some further compiler warnings when using VC 2019 Preview v16.3.0 Preview 2.0
         PJN / 23-06-2022 1. Updated all the code in AAGlobe.cpp to use C++ uniform initialization for all 
                          variable declarations.

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
#include "AAGlobe.h"
#include "AACoordinateTransformation.h"
#include <cmath>


//////////////////// Implementation ///////////////////////////////////////////

double CAAGlobe::RhoSinThetaPrime(double GeographicalLatitude, double Height) noexcept
{
  //Convert from degrees to radians
  GeographicalLatitude = CAACoordinateTransformation::DegreesToRadians(GeographicalLatitude);

  const double U{atan(0.99664719*tan(GeographicalLatitude))};
  return (0.99664719*sin(U)) + (Height/6378140*sin(GeographicalLatitude));
}

double CAAGlobe::RhoCosThetaPrime(double GeographicalLatitude, double Height) noexcept
{
  //Convert from degrees to radians
  GeographicalLatitude = CAACoordinateTransformation::DegreesToRadians(GeographicalLatitude);

  const double U{atan(0.99664719*tan(GeographicalLatitude))};
  return cos(U) + (Height/6378140*cos(GeographicalLatitude));
}

double CAAGlobe::RadiusOfParallelOfLatitude(double GeographicalLatitude) noexcept
{
  //Convert from degrees to radians
  GeographicalLatitude = CAACoordinateTransformation::DegreesToRadians(GeographicalLatitude);

  const double sinGeo{sin(GeographicalLatitude)};
  return (6378.14*cos(GeographicalLatitude)) / (sqrt(1 - (0.0066943847614084*sinGeo*sinGeo)));
}

double CAAGlobe::RadiusOfCurvature(double GeographicalLatitude) noexcept
{
  //Convert from degrees to radians
  GeographicalLatitude = CAACoordinateTransformation::DegreesToRadians(GeographicalLatitude);

  const double sinGeo{sin(GeographicalLatitude)};
  return (6378.14*(1 - 0.0066943847614084)) / pow((1 - (0.0066943847614084*sinGeo*sinGeo)), 1.5);
}

double CAAGlobe::DistanceBetweenPoints(double GeographicalLatitude1, double GeographicalLongitude1, double GeographicalLatitude2, double GeographicalLongitude2) noexcept
{
  //Convert from degrees to radians
  GeographicalLatitude1 = CAACoordinateTransformation::DegreesToRadians(GeographicalLatitude1);
  GeographicalLatitude2 = CAACoordinateTransformation::DegreesToRadians(GeographicalLatitude2);
  GeographicalLongitude1 = CAACoordinateTransformation::DegreesToRadians(GeographicalLongitude1);
  GeographicalLongitude2 = CAACoordinateTransformation::DegreesToRadians(GeographicalLongitude2);

  const double F{(GeographicalLatitude1 + GeographicalLatitude2)/2};
  const double G{(GeographicalLatitude1 - GeographicalLatitude2)/2};
  const double lambda{(GeographicalLongitude1 - GeographicalLongitude2)/2};
  const double sinG{sin(G)};
  const double cosG{cos(G)};
  const double cosF{cos(F)};
  const double sinF{sin(F)};
  const double sinLambda{sin(lambda)};
  const double cosLambda{cos(lambda)};
  const double S{(sinG*sinG*cosLambda*cosLambda) + (cosF*cosF*sinLambda*sinLambda)};
  const double C{(cosG*cosG*cosLambda*cosLambda) + (sinF*sinF*sinLambda*sinLambda)};
  const double w{atan(sqrt(S/C))};
  const double R{sqrt(S*C)/w};
  const double D{2*w*6378.14};
  const double Hprime{(3*R - 1)/(2*C)};
  const double Hprime2{(3*R + 1)/(2*S)};
  constexpr double f{0.0033528131778969144060323814696721};

  return D*(1 + (f*Hprime*sinF*sinF*cosG*cosG) - (f*Hprime2*cosF*cosF*sinG*sinG));
}
