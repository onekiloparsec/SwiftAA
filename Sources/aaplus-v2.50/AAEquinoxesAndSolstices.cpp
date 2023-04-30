/*
Module : AAEquinoxesAndSolstices.cpp
Purpose: Implementation for the algorithms to calculate the dates of the Equinoxes and Solstices
Created: PJN / 29-12-2003
History: PJN / 28-10-2013 1. Renamed the method SpringEquinox to NorthwardEquinox to avoid the northern hemisphere
                          bias in the name. Thanks to Marius Gleeson for prompting this update.
                          2. Renamed the method AutumnEquinox to SouthwardEquinox to avoid the northern hemisphere
                          bias in the name. Thanks to Marius Gleeson for prompting this update.
                          3. Renamed the method SummerSolstice to NorthernSolstice to avoid the northern hemisphere
                          bias in the name. Thanks to Marius Gleeson for prompting this update.
                          4. Renamed the method WinterSolstice to SouthernSolstice to avoid the northern hemisphere
                          bias in the name. Thanks to Marius Gleeson for prompting this update.
                          5. The method LengthOfSpring now takes a boolean to indicate which hemisphere the observer
                          is located in as previously the code assumed a northern hemisphere bias. Thanks to Marius 
                          Gleeson for prompting this update.
                          6. The method LengthOfSummer now takes a boolean to indicate which hemisphere the observer
                          is located in as previously the code assumed a northern hemisphere bias. Thanks to Marius 
                          Gleeson for prompting this update.
                          7. The method LengthOfAutumn now takes a boolean to indicate which hemisphere the observer
                          is located in as previously the code assumed a northern hemisphere bias. Thanks to Marius 
                          Gleeson for prompting this update.
                          8. The method LengthOfWinter now takes a boolean to indicate which hemisphere the observer
                          is located in as previously the code assumed a northern hemisphere bias. Thanks to Marius 
                          Gleeson for prompting this update.
         PJN / 30-08-2015 1. All the methods in CAAEquinoxesAndSolstices now include a "bool bHighPrecision" parameter
                          which if set to true means the code uses the full VSOP87 theory rather than the truncated 
                          theory as presented in Meeus's book.
         PJN / 18-08-2019 1. Fixed some further compiler warnings when using VC 2019 Preview v16.3.0 Preview 2.0
         PJN / 22-06-2022 1. Updated all the code in AAEquinoxesAndSolstices.cpp to use C++ uniform initialization for
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
#include "AAEquinoxesAndSolstices.h"
#include "AACoordinateTransformation.h"
#include "AASun.h"
#include <cmath>


//////////////////// Implementation ///////////////////////////////////////////

double CAAEquinoxesAndSolstices::NorthwardEquinox(long Year, bool bHighPrecision) noexcept
{
  //calculate the approximate date
  double JDE{0};
  if (Year <= 1000)
  {
    const double Y{Year/1000.0};
    const double Ysquared{Y*Y};
    const double Ycubed{Ysquared*Y};
    const double Y4{Ycubed*Y};
    JDE = 1721139.29189 + (365242.13740*Y) + (0.06134*Ysquared) + (0.00111*Ycubed) - (0.00071*Y4);
  }
  else
  {
    const double Y{(Year - 2000.0)/1000.0};
    const double Ysquared{Y*Y};
    const double Ycubed{Ysquared*Y};
    const double Y4{Ycubed*Y};
    JDE = 2451623.80984 + (365242.37404*Y) + (0.05169*Ysquared) - (0.00411*Ycubed) - (0.00057*Y4);
  }

  double Correction{0};
  do
  {
    const double SunLongitude{CAASun::ApparentEclipticLongitude(JDE, bHighPrecision)};
    Correction = 58*sin(CAACoordinateTransformation::DegreesToRadians(-SunLongitude));
    JDE += Correction;
  }
  while (fabs(Correction) > 0.00001); //Corresponds to an error of 0.86 of a second

  return JDE;
}

double CAAEquinoxesAndSolstices::NorthernSolstice(long Year, bool bHighPrecision) noexcept
{
  //calculate the approximate date
  double JDE{0};
  if (Year <= 1000)
  {
    const double Y{Year/1000.0};
    const double Ysquared{Y*Y};
    const double Ycubed{Ysquared*Y};
    const double Y4{Ycubed*Y};
    JDE = 1721233.25401 + (365241.72562*Y) - (0.05323*Ysquared) + (0.00907*Ycubed) + (0.00025*Y4);
  }
  else
  {
    const double Y{(Year - 2000.0)/1000.0};
    const double Ysquared{Y*Y};
    const double Ycubed{Ysquared*Y};
    const double Y4{Ycubed*Y};
    JDE = 2451716.56767 + (365241.62603*Y) + (0.00325*Ysquared) + (0.00888*Ycubed) - (0.00030*Y4);
  }

  double Correction{0};
  do
  {
    const double SunLongitude{CAASun::ApparentEclipticLongitude(JDE, bHighPrecision)};
    Correction = 58*sin(CAACoordinateTransformation::DegreesToRadians(90 - SunLongitude));
    JDE += Correction;
  }
  while (fabs(Correction) > 0.00001); //Corresponds to an error of 0.86 of a second

  return JDE;
}

double CAAEquinoxesAndSolstices::SouthwardEquinox(long Year, bool bHighPrecision) noexcept
{
  //calculate the approximate date
  double JDE{0};
  if (Year <= 1000)
  {
    const double Y{Year/1000.0};
    const double Ysquared{Y*Y};
    const double Ycubed{Ysquared*Y};
    const double Y4{Ycubed*Y};
    JDE = 1721325.70455 + (365242.49558*Y) - (0.11677*Ysquared) - (0.00297*Ycubed) + (0.00074*Y4);
  }
  else
  {
    const double Y{(Year - 2000.0) / 1000.0};
    const double Ysquared{Y*Y};
    const double Ycubed{Ysquared*Y};
    const double Y4{Ycubed*Y};
    JDE = 2451810.21715 + (365242.01767*Y) - (0.11575*Ysquared) + (0.00337*Ycubed) + (0.00078*Y4);
  }

  double Correction{0};
  do
  {
    const double SunLongitude{CAASun::ApparentEclipticLongitude(JDE, bHighPrecision)};
    Correction = 58*sin(CAACoordinateTransformation::DegreesToRadians(180 - SunLongitude));
    JDE += Correction;
  }
  while (fabs(Correction) > 0.00001); //Corresponds to an error of 0.86 of a second

  return JDE;
}

double CAAEquinoxesAndSolstices::SouthernSolstice(long Year, bool bHighPrecision) noexcept
{
  //calculate the approximate date
  double JDE{0};
  if (Year <= 1000)
  {
    const double Y{Year/1000.0};
    const double Ysquared{Y*Y};
    const double Ycubed{Ysquared*Y};
    const double Y4{Ycubed*Y};
    JDE = 1721414.39987 + (365242.88257*Y) - (0.00769*Ysquared) - (0.00933*Ycubed) - (0.00006*Y4);
  }
  else
  {
    const double Y{(Year - 2000.0)/1000.0};
    const double Ysquared{Y*Y};
    const double Ycubed{Ysquared*Y};
    const double Y4{Ycubed*Y};
    JDE = 2451900.05952 + (365242.74049*Y) - (0.06223*Ysquared) - (0.00823*Ycubed) + (0.00032*Y4);
  }

  double Correction{0};
  do
  {
    const double SunLongitude{CAASun::ApparentEclipticLongitude(JDE, bHighPrecision)};
    Correction = 58*sin(CAACoordinateTransformation::DegreesToRadians(270 - SunLongitude));
    JDE += Correction;
  }
  while (fabs(Correction) > 0.00001); //Corresponds to an error of 0.86 of a second

  return JDE;
}

double CAAEquinoxesAndSolstices::LengthOfSpring(long Year, bool bNorthernHemisphere, bool bHighPrecision) noexcept
{
  if (bNorthernHemisphere)
    return NorthernSolstice(Year, bHighPrecision) - NorthwardEquinox(Year, bHighPrecision);
  else
    return SouthernSolstice(Year, bHighPrecision) - SouthwardEquinox(Year, bHighPrecision);
}

double CAAEquinoxesAndSolstices::LengthOfSummer(long Year, bool bNorthernHemisphere, bool bHighPrecision) noexcept
{
  if (bNorthernHemisphere)
    return SouthwardEquinox(Year, bHighPrecision) - NorthernSolstice(Year, bHighPrecision);
  else
  {
    //The Summer season wraps around into the following year for the southern hemisphere
    return NorthwardEquinox(Year + 1, bHighPrecision) - SouthernSolstice(Year, bHighPrecision);
  }
}

double CAAEquinoxesAndSolstices::LengthOfAutumn(long Year, bool bNorthernHemisphere, bool bHighPrecision) noexcept
{
  if (bNorthernHemisphere)
    return SouthernSolstice(Year, bHighPrecision) - SouthwardEquinox(Year, bHighPrecision);
  else
    return NorthernSolstice(Year, bHighPrecision) - NorthwardEquinox(Year, bHighPrecision);
}

double CAAEquinoxesAndSolstices::LengthOfWinter(long Year, bool bNorthernHemisphere, bool bHighPrecision) noexcept
{
  if (bNorthernHemisphere)
  {
    //The Winter season wraps around into the following year for the Northern hemisphere
    return NorthwardEquinox(Year + 1, bHighPrecision) - SouthernSolstice(Year, bHighPrecision);
  }
  else
    return SouthwardEquinox(Year, bHighPrecision) - NorthernSolstice(Year, bHighPrecision);
}
