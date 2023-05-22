/*
Module : AASaturnRings.cpp
Purpose: Implementation for the algorithms which calculate various parameters related to the Rings of Saturn
Created: PJN / 08-01-2004
History: PJN / 05-07-2015 1. U1 (the Saturnicentric longitude of the Sun) and U2 (the Saturnicentic longitude 
                          of the Earth) are now returned in CAASaturnRings::Calculate.
                          2. Fixed a bug in the calculation of CAASaturnRingDetails::DeltaU in the method
                          CAASaturnRings::Calculate where for some date ranges the value would end up greater 
                          than 180 degrees. The book indicates that this value should never be more than 7 
                          degrees. The issue was related to subtraction of two angles to obtain an absolute 
                          elongation value between the two. By definition this value should never be greater 
                          than 180 degrees. The bug occurred between the dates of June 3rd 2024 and July 28th 
                          2024 and December 1st 2024 and February 12 2025. Thanks to Frank Vergeest for 
                          reporting this bug.
         PJN / 16-09-2015 1. CAASaturnRings::Calculate now includes a "bool bHighPrecision" parameter
                          which if set to true means the code uses the full VSOP87 theory rather than the
                          truncated theory as presented in Meeus's book.
         PJN / 18-08-2019 1. Fixed some further compiler warnings when using VC 2019 Preview v16.3.0 Preview 2.0
         PJN / 11-07-2022 1. Updated all the code in AASaturnRings.cpp to use C++ uniform initialization for all
                          variable declarations.

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
#include "AASaturnRings.h"
#include "AASaturn.h"
#include "AAEarth.h"
#include "AAFK5.h"
#include "AANutation.h"
#include "AACoordinateTransformation.h"
#include "AAElliptical.h"
#include <cmath>


//////////////////// Implementation ///////////////////////////////////////////

CAASaturnRingDetails CAASaturnRings::Calculate(double JD, bool bHighPrecision) noexcept
{
  //What will be the return value
  CAASaturnRingDetails details;

  const double T{(JD - 2451545)/36525};
  const double T2{T*T};

  //Step 1. Calculate the inclination of the plane of the ring and the longitude of the ascending node referred to the ecliptic and mean equinox of the date
  const double i{28.075216 - (0.012998*T) + (0.000004*T2)};
  const double irad{CAACoordinateTransformation::DegreesToRadians(i)};
  const double sinirad{sin(irad)};
  const double cosirad{cos(irad)};
  const double omega{169.508470 + (1.394681*T) + (0.000412*T2)};
  const double omegarad{CAACoordinateTransformation::DegreesToRadians(omega)};

  //Step 2. Calculate the heliocentric longitude, latitude and radius vector of the Earth in the FK5 system
  double l0{CAAEarth::EclipticLongitude(JD, bHighPrecision)};
  double b0{CAAEarth::EclipticLatitude(JD, bHighPrecision)};
  l0 += CAAFK5::CorrectionInLongitude(l0, b0, JD);
  const double l0rad{CAACoordinateTransformation::DegreesToRadians(l0)};
  b0 += CAAFK5::CorrectionInLatitude(l0, JD);
  const double b0rad{CAACoordinateTransformation::DegreesToRadians(b0)};
  const double R{CAAEarth::RadiusVector(JD, bHighPrecision)};

  //Step 3. Calculate the corresponding coordinates l,b,r for Saturn but for the instance t-lighttraveltime
  double DELTA{9};
  double PreviousEarthLightTravelTime{0};
  double EarthLightTravelTime{CAAElliptical::DistanceToLightTime(DELTA)};
  double JD1{JD - EarthLightTravelTime};
  bool bIterate{true};
  double x{0};
  double y{0};
  double z{0};
  double l{0};
  double b{0};
  double r{0};
  while (bIterate)
  {
    //Calculate the position of Saturn
    l = CAASaturn::EclipticLongitude(JD1, bHighPrecision);
    b = CAASaturn::EclipticLatitude(JD1, bHighPrecision);
    l += CAAFK5::CorrectionInLongitude(l, b, JD1);
    b += CAAFK5::CorrectionInLatitude(l, JD1);

    const double lrad{CAACoordinateTransformation::DegreesToRadians(l)};
    const double brad{CAACoordinateTransformation::DegreesToRadians(b)};
    const double cosbrad{cos(brad)};
    r = CAASaturn::RadiusVector(JD1, bHighPrecision);

    //Step 4
    x = (r*cosbrad*cos(lrad)) - (R*cos(l0rad));
    y = (r*cosbrad*sin(lrad)) - (R*sin(l0rad));
    z = (r*sin(brad)) - (R*sin(b0rad));
    DELTA = sqrt((x*x) + (y*y) + (z*z));
    EarthLightTravelTime = CAAElliptical::DistanceToLightTime(DELTA);

    //Prepare for the next loop around
    bIterate = (fabs(EarthLightTravelTime - PreviousEarthLightTravelTime) > 2e-6); //2e-6 corresponds to 0.17 of a second
    if (bIterate)
    {
      JD1 = JD - EarthLightTravelTime;
      PreviousEarthLightTravelTime = EarthLightTravelTime;
    }
  }

  //Step 5. Calculate Saturn's geocentric Longitude and Latitude
  double lambda{atan2(y, x)};
  double beta{atan2(z, sqrt((x*x) + (y*y)))};
  const double cosbeta{cos(beta)};
  const double sinbeta{sin(beta)};

  //Step 6. Calculate B, a and b
  const double sinlambdaminusomegarad{sin(lambda - omegarad)};
  details.B = asin((sinirad*cosbeta*sinlambdaminusomegarad) - (cosirad*sinbeta));
  details.a = 375.35/DELTA;
  details.b = details.a*sin(fabs(details.B));
  details.B = CAACoordinateTransformation::RadiansToDegrees(details.B);

  //Step 7. Calculate the longitude of the ascending node of Saturn's orbit
  const double N{113.6655 + (0.8771*T)};
  const double Nrad{CAACoordinateTransformation::DegreesToRadians(N)};
  const double ldash{l - (0.01759/r)};
  const double ldashrad{CAACoordinateTransformation::DegreesToRadians(ldash)};
  const double bdash{b - (0.000764*cos(ldashrad - Nrad)/r)};
  const double bdashrad{CAACoordinateTransformation::DegreesToRadians(bdash)};
  const double sinbdashrad{sin(bdashrad)};
  const double cosbdashrad{cos(bdashrad)};
  const double sinldashradminusomegarad{sin(ldashrad - omegarad)};

  //Step 8. Calculate Bdash
  details.Bdash = CAACoordinateTransformation::RadiansToDegrees(asin((sinirad*cosbdashrad*sinldashradminusomegarad) - (cosirad*sinbdashrad)));

  //Step 9. Calculate DeltaU
  details.U1 = CAACoordinateTransformation::MapTo0To360Range(CAACoordinateTransformation::RadiansToDegrees(atan2((sinirad*sinbdashrad) + (cosirad*cosbdashrad*sinldashradminusomegarad), cosbdashrad*cos(ldashrad - omegarad))));
  details.U2 = CAACoordinateTransformation::MapTo0To360Range(CAACoordinateTransformation::RadiansToDegrees(atan2((sinirad*sinbeta) + (cosirad*cosbeta*sinlambdaminusomegarad), cosbeta*cos(lambda - omegarad))));
  details.DeltaU = fabs(details.U1 - details.U2);
  if (details.DeltaU > 180)
   details.DeltaU = 360 - details.DeltaU;

  //Step 10. Calculate the Nutations
  const double Obliquity{CAANutation::TrueObliquityOfEcliptic(JD)};
  const double NutationInLongitude{CAANutation::NutationInLongitude(JD)};

  //Step 11. Calculate the Ecliptical longitude and latitude of the northern pole of the ring plane
  double lambda0{omega - 90};
  const double beta0{90 - i};

  //Step 12. Correct lambda and beta for the aberration of Saturn
  lambda += CAACoordinateTransformation::DegreesToRadians(0.005693*cos(l0rad - lambda)/cosbeta);
  beta += CAACoordinateTransformation::DegreesToRadians(0.005693*sin(l0rad - lambda)*sinbeta);

  //Step 13. Add nutation in longitude to lambda0 and lambda
  lambda = CAACoordinateTransformation::RadiansToDegrees(lambda);
  lambda += NutationInLongitude/3600;
  lambda = CAACoordinateTransformation::MapTo0To360Range(lambda);
  lambda0 += NutationInLongitude/3600;
  lambda0 = CAACoordinateTransformation::MapTo0To360Range(lambda0);

  //Step 14. Convert to equatorial coordinates
  beta = CAACoordinateTransformation::RadiansToDegrees(beta);
  const CAA2DCoordinate GeocentricEclipticSaturn{CAACoordinateTransformation::Ecliptic2Equatorial(lambda, beta, Obliquity)};
  const double alpha{CAACoordinateTransformation::HoursToRadians(GeocentricEclipticSaturn.X)};
  const double delta{CAACoordinateTransformation::DegreesToRadians(GeocentricEclipticSaturn.Y)};
  const CAA2DCoordinate GeocentricEclipticNorthPole{CAACoordinateTransformation::Ecliptic2Equatorial(lambda0, beta0, Obliquity)};
  const double alpha0{CAACoordinateTransformation::HoursToRadians(GeocentricEclipticNorthPole.X)};
  const double delta0{CAACoordinateTransformation::DegreesToRadians(GeocentricEclipticNorthPole.Y)};
  const double cosdelta0{cos(delta0)};
  const double alpha0minusalpha{alpha0 - alpha};

  //Step 15. Calculate the Position angle
  details.P = CAACoordinateTransformation::RadiansToDegrees(atan2(cosdelta0*sin(alpha0minusalpha), sin(delta0)*cos(delta) - cosdelta0*sin(delta)*cos(alpha0minusalpha)));

  return details;
}
