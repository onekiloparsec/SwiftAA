/*
Module : AAEclipses.cpp
Purpose: Implementation for the algorithms which obtain the principal characteristics of an eclipse of the Sun or the Moon
Created: PJN / 21-01-2004
History: PJN / 25-02-2004 1. Calculation of semi durations is now calculated only when required
         PJN / 31-01-2005 1. Fixed a GCC compiler error related to missing include for memset. Thanks to Mika Heiskanen for 
                          reporting this problem.
         PJN / 27-03-2016 1. Updated CAAEclipses::Calculate to return a bitmask of attributes about the calculated solar 
                          eclipse in CAASolarEclipseDetails::Details. These attributes correspond to the values as discussed
                          in Meeus's book on Pages 381 & 382. Thanks to "Pavel" for providing this nice addition.
         PJN / 18-08-2019 1. Fixed some further compiler warnings when using VC 2019 Preview v16.3.0 Preview 2.0
         PJN / 18-06-2022 1. Updated all the code in AAEclipses.cpp to use C++ uniform initialization for all variable
                          declarations.

Copyright (c) 2004 - 2023 by PJ Naughter (Web: www.naughter.com, Email: pjna@naughter.com)

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
#include "AAEclipses.h"
#include "AAMoonPhases.h"
#include "AACoordinateTransformation.h"
#include <cmath>
#include <cassert>


//////////////////// Implementation ///////////////////////////////////////////

CAASolarEclipseDetails CAAEclipses::Calculate(double k, double& Mdash) noexcept
{
  //Are we looking for a solar or lunar eclipse
  double intp{0};
  const bool bSolarEclipse{modf(k, &intp) == 0};

  //What will be the return value
  CAASolarEclipseDetails details;

  //convert from K to T
  const double T{k/1236.85};
  const double T2{T * T};
  const double T3{T2*T};
  const double T4{T3 * T};

  const double E{1 - (0.002516*T) - (0.0000074*T2)};

  double M{CAACoordinateTransformation::MapTo0To360Range(2.5534 + (29.10535670*k) - (0.0000014*T2) - (0.00000011*T3))};
  M = CAACoordinateTransformation::DegreesToRadians(M);

  Mdash = CAACoordinateTransformation::MapTo0To360Range(201.5643 + (385.81693528*k) + (0.0107582*T2) + (0.00001238*T3) - (0.000000058*T4));
  Mdash = CAACoordinateTransformation::DegreesToRadians(Mdash);

  double omega{CAACoordinateTransformation::MapTo0To360Range(124.7746 - (1.56375588*k) + (0.0020672*T2) + (0.00000215*T3))};
  omega = CAACoordinateTransformation::DegreesToRadians(omega);

  double F{CAACoordinateTransformation::MapTo0To360Range(160.7108 + (390.67050284*k) - (0.0016118*T2) - (0.00000227*T3) + (0.00000001*T4))};
  details.F = F;
  double Fdash{F - (0.02665*sin(omega))};

  F = CAACoordinateTransformation::DegreesToRadians(F);
  Fdash = CAACoordinateTransformation::DegreesToRadians(Fdash);

  //Do the first check to see if we have an eclipse
  if (fabs(sin(F)) > 0.36)
    return details;

  double A1{CAACoordinateTransformation::MapTo0To360Range(299.77 + (0.107408*k) - (0.009173*T2))};
  A1 = CAACoordinateTransformation::DegreesToRadians(A1);

  details.TimeOfMaximumEclipse = CAAMoonPhases::MeanPhase(k);

  double DeltaJD{0};
  if (bSolarEclipse)
    DeltaJD += (-0.4075*sin(Mdash)) +
               (0.1721*E*sin(M));
  else
    DeltaJD += (-0.4065*sin(Mdash)) +
               (0.1727*E*sin(M));
  DeltaJD += (0.0161*sin(2*Mdash)) +
             (-0.0097*sin(2*Fdash)) +
             (0.0073*E*sin(Mdash - M)) +
             (-0.0050*E*sin(Mdash + M)) +
             (-0.0023*sin(Mdash - (2*Fdash))) +
             (0.0021*E*sin(2*M)) +
             (0.0012*sin(Mdash + (2*Fdash))) +
             (0.0006*E*sin((2*Mdash) + M)) +
             (-0.0004*sin(3*Mdash)) +
             (-0.0003*E*sin(M + (2*Fdash))) +
             (0.0003*sin(A1)) +
             (-0.0002*E*sin(M - (2*Fdash))) +
             (-0.0002*E*sin((2*Mdash) - M)) +
             (-0.0002*sin(omega));

  details.TimeOfMaximumEclipse += DeltaJD;

  const double P{(0.2070*E*sin(M)) +
                 (0.0024*E*sin(2*M)) +
                 (-0.0392*sin(Mdash)) +
                 (0.0116*sin(2*Mdash)) +
                 (-0.0073*E*sin(Mdash + M)) +
                 (0.0067*E*sin(Mdash - M)) +
                 (0.0118*sin(2*Fdash))};

  const double Q{5.2207 +
                 (-0.0048*E*cos(M)) +
                 (0.0020*E*cos(2*M)) +
                 (-0.3299*cos(Mdash)) +
                 (-0.0060*E*cos(Mdash + M)) +
                 (0.0041*E*cos(Mdash - M))};

  const double W{fabs(cos(Fdash))};

  details.gamma = (P*cos(Fdash) + Q*sin(Fdash))*(1 - 0.0048*W);

  details.u = 0.0059 +
              (0.0046*E*cos(M)) +
              (-0.0182*cos(Mdash)) +
              (0.0004*cos(2*Mdash)) +
              (-0.0005*cos(M + Mdash));

  //Check to see if the eclipse is visible from the Earth's surface
  const double fgamma{fabs(details.gamma)};
  if (fgamma > (1.5433 + details.u))
    return details;

  //We have an eclipse at this time, fill in the details
  if (fgamma < 0.9972)
  {
    if (details.u < 0)
      details.Flags = CAASolarEclipseDetails::TOTAL_ECLIPSE;
    else if (details.u > 0.0047)
      details.Flags = CAASolarEclipseDetails::ANNULAR_ECLIPSE;
    else if ((details.u >= 0) && (details.u <= 0.0047))
    {
      const double w{0.00464*sqrt(1 - (details.gamma*details.gamma))};
      if (details.u < w)
        details.Flags = CAASolarEclipseDetails::ANNULAR_TOTAL_ECLIPSE;
      else
        details.Flags = CAASolarEclipseDetails::ANNULAR_ECLIPSE;
    }

    details.Flags |= CAASolarEclipseDetails::CENTRAL_ECLIPSE;
  }
  else if ((fgamma > 0.9972) && (fgamma < (1.5433 + details.u)))
  {
    if ((fgamma > 0.9972) && (fgamma < (0.9972 + fabs(details.u))))
    {
      if (details.u < 0)
        details.Flags = CAASolarEclipseDetails::TOTAL_ECLIPSE;
      else if (details.u > 0.0047)
        details.Flags = CAASolarEclipseDetails::ANNULAR_ECLIPSE;
      else if (details.u >= 0 && details.u <= 0.0047)
      {
        const double w{0.00464*sqrt(1 - (details.gamma*details.gamma))};
        if (details.u < w)
          details.Flags = CAASolarEclipseDetails::ANNULAR_TOTAL_ECLIPSE;
        else
          details.Flags = CAASolarEclipseDetails::ANNULAR_ECLIPSE;
      }
    }
    else
    {
      details.Flags = CAASolarEclipseDetails::PARTIAL_ECLIPSE;
      details.GreatestMagnitude = (1.5433 + details.u - fgamma) / (0.5461 + (2*details.u));
    }

    details.Flags |= CAASolarEclipseDetails::NON_CENTRAL_ECLIPSE;
  }

  return details;
}

CAASolarEclipseDetails CAAEclipses::CalculateSolar(double k) noexcept
{
#ifdef _DEBUG
  double intp{0};
  const bool bSolarEclipse{modf(k, &intp) == 0};
  assert(bSolarEclipse);
#endif //#ifdef _DEBUG

  double Mdash{0};
  return Calculate(k, Mdash);
}

CAALunarEclipseDetails CAAEclipses::CalculateLunar(double k) noexcept
{
#ifdef _DEBUG
  double intp{0};
  const bool bSolarEclipse{modf(k, &intp) == 0};
  assert(!bSolarEclipse);
#endif //#ifdef _DEBUG

  double Mdash{0};
  const CAASolarEclipseDetails solarDetails{Calculate(k, Mdash)};

  //What will be the return value
  CAALunarEclipseDetails details;
  details.bEclipse = solarDetails.Flags != 0;
  details.F = solarDetails.F;
  details.gamma = solarDetails.gamma;
  details.TimeOfMaximumEclipse = solarDetails.TimeOfMaximumEclipse;
  details.u = solarDetails.u;

  if (details.bEclipse)
  {
    details.PenumbralRadii = 1.2848 + details.u;
    details.UmbralRadii = 0.7403 - details.u;
    const double fgamma{fabs(details.gamma)};
    details.PenumbralMagnitude = (1.5573 + details.u - fgamma) / 0.5450;
    details.UmbralMagnitude = (1.0128 - details.u - fgamma) / 0.5450;

    const double p{1.0128 - details.u};
    const double t{0.4678 - details.u};
    const double n{0.5458 + 0.0400 * cos(Mdash)};

    const double gamma2{details.gamma*details.gamma};
    const double p2{p*p};
    if (p2 >= gamma2)
      details.PartialPhaseSemiDuration = 60/n*sqrt(p2 - gamma2);

    const double t2{t*t};
    if (t2 >= gamma2)
      details.TotalPhaseSemiDuration = 60/n*sqrt(t2 - gamma2);

    const double h{1.5573 + details.u};
    const double h2{h*h};
    if (h2 >= gamma2)
      details.PartialPhasePenumbraSemiDuration = 60/n*sqrt(h2 - gamma2);
  }

  return details;
}
