/*
Module : AAParabolic.cpp
Purpose: Implementation for the algorithms for a parabolic orbit
Created: PJN / 29-12-2003
History: PJN / 31-01-2005 1. Fixed a bug in CAAParabolic::Calculate where the JD value was being used incorrectly
                          in the loop. Thanks to Mika Heiskanen for reporting this problem.
         PJN / 16-03-2008 1. Fixed a bug in CAAParabolic::Calculate(double JD, 
                          const CAAParabolicObjectElements& elements) in the calculation of the 
                          heliocentric rectangular ecliptical, the heliocentric ecliptical latitude and 
                          the heliocentric ecliptical longitude coordinates. The code incorrectly used the 
                          value "omega" instead of "w" in its calculation of the value "u". Unfortunately 
                          there is no worked examples in Jean Meeus's book for these particular values, 
                          hence resulting in my coding errors. Thanks to Jay Borseth for reporting this bug.
         PJN / 08-09-2013 1. Fixed a bug in the calculation of HeliocentricEclipticLongitude and 
                          HeliocentricEclipticLatitude in CAAParabolic::Calculate. Thanks to Joe Novak for 
                          reporting this problem.
         PJN / 16-09-2015 1. CAAParabolic::Calculate now includes a "bool bHighPrecision" parameter which if 
                          set to true means the code uses the full VSOP87 theory rather than the truncated 
                          theory as presented in Meeus's book.
         PJN / 18-08-2019 1. Fixed some further compiler warnings when using VC 2019 Preview v16.3.0 Preview 2.0
         PJN / 02-07-2022 1. Updated all the code in AAParabolic.cpp to use C++ uniform initialization for all
                          variable declarations.
                          2. Updated methods in the CAAParabolic class to allow the epsilon value used to 
                          terminate iteration loops to be specified.

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
#include "AAParabolic.h"
#include "AACoordinateTransformation.h"
#include "AASun.h"
#include "AANutation.h"
#include "AAElliptical.h"
#include <cmath>


//////////////////// Implementation ///////////////////////////////////////////

double CAAParabolic::CalculateBarkers(double W, double epsilon) noexcept
{
  double S{W/3};
  bool bRecalc{true};
  while (bRecalc)
  {
    const double S2{S*S};
    const double NextS{((2*S2*S) + W)/(3*(S2 + 1))};

    //Prepare for the next loop around
    bRecalc = (fabs(NextS - S) > epsilon);
    S = NextS;
  }

  return S;
}

CAAParabolicObjectDetails CAAParabolic::Calculate(double JD, const CAAParabolicObjectElements& elements, bool bHighPrecision, double epsilon) noexcept
{
  double Epsilon{CAANutation::MeanObliquityOfEcliptic(elements.JDEquinox)};
  double JD0{JD};

  //What will be the return value
  CAAParabolicObjectDetails details;

  Epsilon = CAACoordinateTransformation::DegreesToRadians(Epsilon);
  const double omega{CAACoordinateTransformation::DegreesToRadians(elements.omega)};
  const double w{CAACoordinateTransformation::DegreesToRadians(elements.w)};
  const double i{CAACoordinateTransformation::DegreesToRadians(elements.i)};

  const double sinEpsilon{sin(Epsilon)};
  const double cosEpsilon{cos(Epsilon)};
  const double sinOmega{sin(omega)};
  const double cosOmega{cos(omega)};
  const double cosi{cos(i)};
  const double sini{sin(i)};

  const double F{cosOmega};
  const double G{sinOmega*cosEpsilon};
  const double H{sinOmega*sinEpsilon};
  const double P{-sinOmega*cosi};
  const double Q{(cosOmega*cosi*cosEpsilon) - (sini*sinEpsilon)};
  const double R{(cosOmega*cosi*sinEpsilon) + (sini*cosEpsilon)};
  const double a{sqrt((F*F) + (P*P))};
  const double b{sqrt((G*G) + (Q*Q))};
  const double c{sqrt((H*H) + (R*R))};
  const double A{atan2(F, P)};
  const double B{atan2(G, Q)};
  const double C{atan2(H, R)};

  const CAA3DCoordinate SunCoord{CAASun::EquatorialRectangularCoordinatesAnyEquinox(JD, elements.JDEquinox, bHighPrecision)};
  for (int j{0}; j<2; j++)
  {
    const double W{0.03649116245/((elements.q*sqrt(elements.q))*(JD0 - elements.T))};
    const double s{CalculateBarkers(W, epsilon)};
    const double v{2*atan(s)};
    const double r{elements.q*(1 + (s*s))};
    const double x{r*a*sin(A + w + v)};
    const double y{r*b*sin(B + w + v)};
    const double z{r*c*sin(C + w + v)};

    if (j == 0)
    {
      details.HeliocentricRectangularEquatorial.X = x;
      details.HeliocentricRectangularEquatorial.Y = y;
      details.HeliocentricRectangularEquatorial.Z = z;

      //Calculate the heliocentric ecliptic coordinates also
      const double u{w + v};
      const double cosu{cos(u)};
      const double sinu{sin(u)};

      details.HeliocentricRectangularEcliptical.X = r*((cosOmega*cosu) - (sinOmega*sinu*cosi));
      details.HeliocentricRectangularEcliptical.Y = r*((sinOmega*cosu) + (cosOmega*sinu*cosi));
      details.HeliocentricRectangularEcliptical.Z = r*sini*sinu;

      details.HeliocentricEclipticLongitude = CAACoordinateTransformation::MapTo0To360Range(CAACoordinateTransformation::RadiansToDegrees(atan2(details.HeliocentricRectangularEcliptical.Y, details.HeliocentricRectangularEcliptical.X)));
      details.HeliocentricEclipticLatitude = CAACoordinateTransformation::RadiansToDegrees(asin(details.HeliocentricRectangularEcliptical.Z/r));
    }

    const double psi{SunCoord.X + x};
    const double psi2{psi*psi};
    const double nu{SunCoord.Y + y};
    const double nu2{nu*nu};
    const double sigma{SunCoord.Z + z};

    double Alpha{atan2(nu, psi)};
    Alpha = CAACoordinateTransformation::RadiansToDegrees(Alpha);
    double Delta{atan2(sigma, sqrt(psi2 + nu2))};
    Delta = CAACoordinateTransformation::RadiansToDegrees(Delta);
    const double Distance{sqrt(psi2 + nu2 + (sigma*sigma))};

    if (j == 0)
    {
      details.TrueGeocentricRA = CAACoordinateTransformation::MapTo0To24Range(Alpha/15);
      details.TrueGeocentricDeclination = Delta;
      details.TrueGeocentricDistance = Distance;
      details.TrueGeocentricLightTime = CAAElliptical::DistanceToLightTime(Distance);
    }
    else
    {
      details.AstrometricGeocenticRA = CAACoordinateTransformation::MapTo0To24Range(Alpha/15);
      details.AstrometricGeocentricDeclination = Delta;
      details.AstrometricGeocentricDistance = Distance;
      details.AstrometricGeocentricLightTime = CAAElliptical::DistanceToLightTime(Distance);

      const double RES{sqrt((SunCoord.X*SunCoord.X) + (SunCoord.Y*SunCoord.Y) + (SunCoord.Z*SunCoord.Z))};
      const double RES2{RES*RES};
      const double r2{r*r};

      details.Elongation = CAACoordinateTransformation::RadiansToDegrees(acos((RES2 + Distance*Distance - r2)/(2*RES*Distance)));
      details.PhaseAngle = CAACoordinateTransformation::RadiansToDegrees(acos((r2 + Distance*Distance - RES2)/(2*r*Distance)));
    }

    if (j == 0) //Prepare for the next loop around
      JD0 = JD - details.TrueGeocentricLightTime;
  }

  return details;
}
