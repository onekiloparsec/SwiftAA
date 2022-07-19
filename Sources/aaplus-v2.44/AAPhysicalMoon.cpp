/*
Module : AAPhysicalMoon.cpp
Purpose: Implementation for the algorithms which obtain the physical parameters of the Moon
Created: PJN / 17-01-2004
History: PJN / 19-02-2004 1. The optical libration in longitude is now returned in the range -180 - 180 degrees
         PJN / 10-05-2010 1. Minor update to CAAPhysicalMoon::CalculateTopocentric to put a value in a variable 
                          for easier debugging 
         PJN / 30-08-2015 1. CAAPhysicalMoon::CalculateSelenographicPositionOfSun, AltitudeOfSun, TimeOfSunrise
                          and TimeOfSunset methods now include a "bool bHighPrecision" parameter which if set 
                          to true means the code uses the full VSOP87 theory rather than the truncated theory 
                          as presented in Meeus's book.
         PJN / 18-08-2019 1. Fixed some further compiler warnings when using VC 2019 Preview v16.3.0 Preview 2.0
         PJN / 06-11-2021 1. Fixed a bug in CAAPhysicalMoon::CalculateOpticalLibration where the value of the
                          variable "W" was being calculated incorrectly. Thanks to Don Cross for reporting this
                          issue.
         PJN / 03-07-2022 1. Updated all the code in AAPhysicalMoon.cpp to use C++ uniform initialization for
                          all variable declarations.

Copyright (c) 2004 - 2022 by PJ Naughter (Web: www.naughter.com, Email: pjna@naughter.com)

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
#include "AAPhysicalMoon.h"
#include "AASun.h"
#include "AAMoon.h"
#include "AAEarth.h"
#include "AANutation.h"
#include "AASidereal.h"
#include <cmath>
using namespace std;


//////////////////// Implementation ///////////////////////////////////////////

void CAAPhysicalMoon::CalculateOpticalLibration(double JD, double Lambda, double Beta, double& ldash, double& bdash, double& ldash2, double& bdash2, double& epsilon, double& omega, double& DeltaU, double& sigma, double& I, double& rho) noexcept
{
  //Calculate the initial quantities
  const double Lambdarad{CAACoordinateTransformation::DegreesToRadians(Lambda)};
  const double Betarad{CAACoordinateTransformation::DegreesToRadians(Beta)};
  const double cosBetarad{cos(Betarad)};
  const double sinBetarad{sin(Betarad)};
  I = CAACoordinateTransformation::DegreesToRadians(1.54242);
  const double cosI{cos(I)};
  const double sinI{sin(I)};
  DeltaU = CAACoordinateTransformation::DegreesToRadians(CAANutation::NutationInLongitude(JD)/3600);
  const double F{CAACoordinateTransformation::DegreesToRadians(CAAMoon::ArgumentOfLatitude(JD))};
  const double twoF{2*F};
  omega = CAACoordinateTransformation::DegreesToRadians(CAAMoon::MeanLongitudeAscendingNode(JD));
  epsilon = CAANutation::MeanObliquityOfEcliptic(JD) + (CAANutation::NutationInObliquity(JD)/3600);

  //Calculate the optical librations
  const double W{Lambdarad - DeltaU - omega};
  const double sinW{sin(W)};
  const double A{atan2((sinW*cosBetarad*cosI) - (sinBetarad*sinI), cos(W)*cosBetarad)};
  const double cosA{cos(A)};
  const double sinA{sin(A)};
  ldash = CAACoordinateTransformation::MapTo0To360Range(CAACoordinateTransformation::RadiansToDegrees(A) - CAACoordinateTransformation::RadiansToDegrees(F));
  if (ldash > 180)
    ldash -= 360;
  bdash = asin(-(sinW*cosBetarad*sinI) - (sinBetarad*cosI));

  //Calculate the physical librations
  const double T{(JD - 2451545)/36525};
  double K1{119.75 + (131.849*T)};
  K1 = CAACoordinateTransformation::DegreesToRadians(K1);
  double K2{72.56 + (20.186*T)};
  K2 = CAACoordinateTransformation::DegreesToRadians(K2);

  double M{CAAEarth::SunMeanAnomaly(JD)};
  M = CAACoordinateTransformation::DegreesToRadians(M);
  double Mdash{CAAMoon::MeanAnomaly(JD)};
  Mdash = CAACoordinateTransformation::DegreesToRadians(Mdash);
  const double twoMdash{2*Mdash};
  double D{CAAMoon::MeanElongation(JD)};
  D = CAACoordinateTransformation::DegreesToRadians(D);
  const double twoD{2*D};
  const double E{CAAEarth::Eccentricity(JD)};

  rho = (-0.02752*cos(Mdash)) +
        (-0.02245*sin(F)) +
        ( 0.00684*cos(Mdash - twoF)) +
        (-0.00293*cos(twoF)) +
        (-0.00085*cos(twoF - twoD)) +
        (-0.00054*cos(Mdash - twoD)) +
        (-0.00020*sin(Mdash + F)) +
        (-0.00020*cos(Mdash + twoF)) +
        (-0.00020*cos(Mdash - F)) +
        ( 0.00014*cos(Mdash + twoF - twoD));

  sigma = (-0.02816*sin(Mdash)) +
          ( 0.02244*cos(F)) +
          (-0.00682*sin(Mdash - twoF)) +
          (-0.00279*sin(twoF)) +
          (-0.00083*sin(twoF - twoD)) +
          ( 0.00069*sin(Mdash - twoD)) +
          ( 0.00040*cos(Mdash + F)) +
          (-0.00025*sin(twoMdash)) +
          (-0.00023*sin(Mdash + twoF)) +
          ( 0.00020*cos(Mdash - F)) +
          ( 0.00019*sin(Mdash - F)) +
          ( 0.00013*sin(Mdash + twoF - twoD)) +
          (-0.00010*cos(Mdash - 3*F));

  const double tau{( 0.02520*E*sin(M)) +
                   ( 0.00473*sin(twoMdash - twoF)) +
                   (-0.00467*sin(Mdash)) +
                   ( 0.00396*sin(K1)) +
                   ( 0.00276*sin(twoMdash - twoD)) +
                   ( 0.00196*sin(omega)) +
                   (-0.00183*cos(Mdash - F)) +
                   ( 0.00115*sin(Mdash - twoD)) +
                   (-0.00096*sin(Mdash - D)) +
                   ( 0.00046*sin(twoF - twoD)) +
                   (-0.00039*sin(Mdash - F)) +
                   (-0.00032*sin(Mdash - M - D)) +
                   ( 0.00027*sin(twoMdash - M - twoD)) +
                   ( 0.00023*sin(K2)) +
                   (-0.00014*sin(twoD)) +
                   ( 0.00014*cos(twoMdash - twoF)) +
                   (-0.00012*sin(Mdash - twoF)) +
                   (-0.00012*sin(twoMdash)) +
                   ( 0.00011*sin(twoMdash - 2*M - twoD))};

  ldash2 = -tau + (rho*cosA) + (sigma*sinA*tan(bdash));
  bdash = CAACoordinateTransformation::RadiansToDegrees(bdash);
  bdash2 = (sigma*cosA) - (rho*sinA);
}

CAAPhysicalMoonDetails CAAPhysicalMoon::CalculateHelper(double JD, double& Lambda, double& Beta, double& epsilon, CAA2DCoordinate& Equatorial) noexcept
{
  //What will be the return value
  CAAPhysicalMoonDetails details;

  //Calculate the initial quantities
  Lambda = CAAMoon::EclipticLongitude(JD);
  Beta = CAAMoon::EclipticLatitude(JD);

  //Calculate the optical libration
  double omega{0};
  double DeltaU{0};
  double sigma{0};
  double I{0};
  double rho{0};
  CalculateOpticalLibration(JD, Lambda, Beta, details.ldash, details.bdash, details.ldash2, details.bdash2, epsilon, omega, DeltaU, sigma, I, rho);
  const double epsilonrad{CAACoordinateTransformation::DegreesToRadians(epsilon)};

  //Calculate the total libration
  details.l = details.ldash + details.ldash2;
  details.b = details.bdash + details.bdash2;
  const double b{CAACoordinateTransformation::DegreesToRadians(details.b)};

  //Calculate the position angle
  const double V{omega + DeltaU + CAACoordinateTransformation::DegreesToRadians(sigma)/sin(I)};
  const double I_rho{I + CAACoordinateTransformation::DegreesToRadians(rho)};
  const double sinI_rho{sin(I_rho)};
  const double X{sinI_rho*sin(V)};
  const double Y{sinI_rho*cos(V)*cos(epsilonrad) - cos(I_rho)*sin(epsilonrad)};
  const double w{atan2(X, Y)};

  Equatorial = CAACoordinateTransformation::Ecliptic2Equatorial(Lambda, Beta, epsilon);
#ifdef _MSC_VER
  #pragma warning(suppress : 26489)
#endif //#ifdef _MSC_VER
  const double Alpha{CAACoordinateTransformation::HoursToRadians(Equatorial.X)};
  details.P = CAACoordinateTransformation::RadiansToDegrees(asin(sqrt((X*X) + (Y*Y))*cos(Alpha - w)/(cos(b))));
  return details;
}

CAAPhysicalMoonDetails CAAPhysicalMoon::CalculateGeocentric(double JD) noexcept
{
  double Lambda{0};
  double Beta{0};
  double epsilon{0};
  CAA2DCoordinate Equatorial;
  return CalculateHelper(JD, Lambda, Beta, epsilon, Equatorial);
}

CAAPhysicalMoonDetails CAAPhysicalMoon::CalculateTopocentric(double JD, double Longitude, double Latitude) noexcept
{
  //First convert to radians
  Longitude = CAACoordinateTransformation::DegreesToRadians(Longitude);
  Latitude = CAACoordinateTransformation::DegreesToRadians(Latitude);
  const double cosLatitude{cos(Latitude)};
  const double sinLatitude{sin(Latitude)};

  double Lambda{0};
  double Beta{0};
  double epsilon{0};
  CAA2DCoordinate Equatorial;
  CAAPhysicalMoonDetails details{CalculateHelper(JD, Lambda, Beta, epsilon, Equatorial)};

  const double R{CAAMoon::RadiusVector(JD)};
  const double pi{CAAMoon::RadiusVectorToHorizontalParallax(R)};
  const double Alpha{CAACoordinateTransformation::HoursToRadians(Equatorial.X)};
  const double Delta{CAACoordinateTransformation::DegreesToRadians(Equatorial.Y)};
  const double cosDelta{cos(Delta)};
  const double sinDelta{sin(Delta)};

  const double AST{CAASidereal::ApparentGreenwichSiderealTime(JD)};
  const double H{CAACoordinateTransformation::HoursToRadians(AST) - Longitude - Alpha};
  const double cosH{cos(H)};

  const double Q{atan2(cosLatitude*sin(H), (cosDelta*sinLatitude) - (sinDelta*cosLatitude*cosH))};
  const double Z{acos((sinDelta*sinLatitude) + (cosDelta*cosLatitude*cosH))};
  const double pidash{pi*(sin(Z) + (0.0084*sin(2*Z)))};

  const double Prad{CAACoordinateTransformation::DegreesToRadians(details.P)};

  const double DeltaL{-pidash*sin(Q - Prad)/cos(CAACoordinateTransformation::DegreesToRadians(details.b))};
  details.l += DeltaL;
  const double DeltaB{pidash*cos(Q - Prad)};
  details.b += DeltaB;
  const double DeltaP{DeltaL*sin(CAACoordinateTransformation::DegreesToRadians(details.b)) - (pidash*sin(Q)*tan(Delta))};
  details.P += DeltaP;

  return details;
}

CAASelenographicMoonDetails CAAPhysicalMoon::CalculateSelenographicPositionOfSun(double JD, bool bHighPrecision) noexcept
{
  const double R{CAAEarth::RadiusVector(JD, bHighPrecision)*149597970};
  const double Delta{CAAMoon::RadiusVector(JD)};
  const double lambda0{CAASun::ApparentEclipticLongitude(JD, bHighPrecision)};
  const double lambda{CAAMoon::EclipticLongitude(JD)};
  const double beta{CAAMoon::EclipticLatitude(JD)};

  const double lambdah{CAACoordinateTransformation::MapTo0To360Range(lambda0 + 180 + (Delta/R*57.296*cos(CAACoordinateTransformation::DegreesToRadians(beta))*sin(CAACoordinateTransformation::DegreesToRadians(lambda0 - lambda))))};
  const double betah{Delta/R*beta};

  //What will be the return value
  CAASelenographicMoonDetails details;

  //Calculate the optical libration
  double omega{0};
  double DeltaU{0};
  double sigma{0};
  double I{0};
  double rho{0};
  double ldash0{0};
  double bdash0{0};
  double ldash20{0};
  double bdash20{0};
  double epsilon{0};
  CalculateOpticalLibration(JD, lambdah, betah, ldash0, bdash0, ldash20, bdash20, epsilon, omega, DeltaU, sigma, I, rho);

  details.l0 = ldash0 + ldash20;
  details.b0 = bdash0 + bdash20;
  details.c0 = CAACoordinateTransformation::MapTo0To360Range(450 - details.l0);
  return details;
}

double CAAPhysicalMoon::AltitudeOfSun(double JD, double Longitude, double Latitude, bool bHighPrecision) noexcept
{
  //Calculate the selenographic details
  CAASelenographicMoonDetails selenographicDetails{CalculateSelenographicPositionOfSun(JD, bHighPrecision)};

  //convert to radians
  Latitude = CAACoordinateTransformation::DegreesToRadians(Latitude);
  Longitude = CAACoordinateTransformation::DegreesToRadians(Longitude);
  selenographicDetails.b0 = CAACoordinateTransformation::DegreesToRadians(selenographicDetails.b0);
  selenographicDetails.c0 = CAACoordinateTransformation::DegreesToRadians(selenographicDetails.c0);

  return CAACoordinateTransformation::RadiansToDegrees(asin(sin((selenographicDetails.b0)*sin(Latitude)) + (cos(selenographicDetails.b0)*cos(Latitude)*sin(selenographicDetails.c0 + Longitude))));
}

double CAAPhysicalMoon::SunriseSunsetHelper(double JD, double Longitude, double Latitude, bool bSunrise, bool bHighPrecision) noexcept
{
  double JDResult{JD};
  const double Latituderad{CAACoordinateTransformation::DegreesToRadians(Latitude)};
  double h{0};
  do
  {
    h = AltitudeOfSun(JDResult, Longitude, Latitude, bHighPrecision);
    const double DeltaJD{h/(12.19075*cos(Latituderad))};
    if (bSunrise)
      JDResult -= DeltaJD;
    else
      JDResult += DeltaJD;
  }
  while (fabs(h) > 0.001);

  return JDResult;
}

double CAAPhysicalMoon::TimeOfSunrise(double JD, double Longitude, double Latitude, bool bHighPrecision) noexcept
{
  return SunriseSunsetHelper(JD, Longitude, Latitude, true, bHighPrecision);
}

double CAAPhysicalMoon::TimeOfSunset(double JD, double Longitude, double Latitude, bool bHighPrecision) noexcept
{
  return SunriseSunsetHelper(JD, Longitude, Latitude, false, bHighPrecision);
}
