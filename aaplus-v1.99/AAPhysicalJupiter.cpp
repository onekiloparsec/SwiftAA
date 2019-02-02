/*
Module : AAPhysicalJupiter.cpp
Purpose: Implementation for the algorithms which obtain the physical parameters of Jupiter
Created: PJN / 29-12-2003
History: PJN / 16-09-2015 1. CAAPhysicalJupiter::Calculate now includes a "bool bHighPrecision" parameter
                          which if set to true means the code uses the full VSOP87 theory rather than the
                          truncated theory as presented in Meeus's book. 

Copyright (c) 2003 - 2019 by PJ Naughter (Web: www.naughter.com, Email: pjna@naughter.com)

All rights reserved.

Copyright / Usage Details:

You are allowed to include the source code in any product (commercial, shareware, freeware or otherwise) 
when your product is released in binary form. You are allowed to modify the source code in any way you want 
except you cannot modify the copyright details at the top of each module. If you want to distribute source 
code with your application, then you are only allowed to distribute versions released by the author. This is 
to maintain a single distribution point for the source code. 

*/


///////////////////////////////// Includes ////////////////////////////////////

#include "stdafx.h"
#include "AAPhysicalJupiter.h"
#include "AAJupiter.h"
#include "AAEarth.h"
#include "AANutation.h"
#include "AACoordinateTransformation.h"
#include <cmath>
using namespace std;


//////////////////////////////// Implementation ///////////////////////////////

CAAPhysicalJupiterDetails CAAPhysicalJupiter::Calculate(double JD, bool bHighPrecision)
{
  //What will be the return value
  CAAPhysicalJupiterDetails details;

  //Step 1
  const double d = JD - 2433282.5;
  const double T1 = d/36525;
  const double alpha0 = 268.00 + 0.1061*T1;
  const double alpha0rad = CAACoordinateTransformation::DegreesToRadians(alpha0);
  const double delta0 = 64.50 - 0.0164*T1;
  const double delta0rad = CAACoordinateTransformation::DegreesToRadians(delta0);

  //Step 2
  const double W1 = CAACoordinateTransformation::MapTo0To360Range(17.710 + 877.90003539*d);
  const double W2 = CAACoordinateTransformation::MapTo0To360Range(16.838 + 870.27003539*d);

  //Step 3
  const double l0 = CAAEarth::EclipticLongitude(JD, bHighPrecision);
  const double l0rad = CAACoordinateTransformation::DegreesToRadians(l0);
  const double b0 = CAAEarth::EclipticLatitude(JD, bHighPrecision);
  const double b0rad = CAACoordinateTransformation::DegreesToRadians(b0);
  const double R = CAAEarth::RadiusVector(JD, bHighPrecision);

  //Step 4
  double l = CAAJupiter::EclipticLongitude(JD, bHighPrecision);
  double lrad = CAACoordinateTransformation::DegreesToRadians(l);
  const double b = CAAJupiter::EclipticLatitude(JD, bHighPrecision);
  const double brad = CAACoordinateTransformation::DegreesToRadians(b);
  const double r = CAAJupiter::RadiusVector(JD, bHighPrecision);

  //Step 5
  double x = r*cos(brad)*cos(lrad) - R*cos(l0rad);
  double y = r*cos(brad)*sin(lrad) - R*sin(l0rad);
  double z = r*sin(brad) - R*sin(b0rad);
  double DELTA = sqrt(x*x + y*y + z*z);

  //Step 6
  l -= 0.012990*DELTA/(r*r);
  lrad = CAACoordinateTransformation::DegreesToRadians(l);

  //Step 7
  x = r*cos(brad)*cos(lrad) - R*cos(l0rad);
  y = r*cos(brad)*sin(lrad) - R*sin(l0rad);
  z = r*sin(brad) - R*sin(b0rad);
  DELTA = sqrt(x*x + y*y + z*z);

  //Step 8
  double e0 = CAANutation::MeanObliquityOfEcliptic(JD);
  double e0rad = CAACoordinateTransformation::DegreesToRadians(e0);

  //Step 9
  const double alphas = atan2(cos(e0rad)*sin(lrad) - sin(e0rad)*tan(brad), cos(lrad));
  const double deltas = asin(cos(e0rad)*sin(brad) + sin(e0rad)*cos(brad)*sin(lrad));

  //Step 10
  details.DS = CAACoordinateTransformation::RadiansToDegrees(asin(-sin(delta0rad)*sin(deltas) - cos(delta0rad)*cos(deltas)*cos(alpha0rad - alphas)));

  //Step 11
  const double u = y*cos(e0rad) - z*sin(e0rad);
  const double v = y*sin(e0rad) + z*cos(e0rad);
  double alpharad = atan2(u, x);
  double alpha = CAACoordinateTransformation::RadiansToDegrees(alpharad);
  const double deltarad = atan2(v, sqrt(x*x + u*u));
  double delta = CAACoordinateTransformation::RadiansToDegrees(deltarad);
  const double xi = atan2(sin(delta0rad)*cos(deltarad)*cos(alpha0rad - alpharad) - sin(deltarad)*cos(delta0rad), cos(deltarad)*sin(alpha0rad - alpharad));

  //Step 12
  details.DE = CAACoordinateTransformation::RadiansToDegrees(asin(-sin(delta0rad)*sin(deltarad) - cos(delta0rad)*cos(deltarad)*cos(alpha0rad - alpharad)));

  //Step 13
  details.Geometricw1 = CAACoordinateTransformation::MapTo0To360Range(W1 - CAACoordinateTransformation::RadiansToDegrees(xi) - 5.07033*DELTA);
  details.Geometricw2 = CAACoordinateTransformation::MapTo0To360Range(W2 - CAACoordinateTransformation::RadiansToDegrees(xi) - 5.02626*DELTA);

  //Step 14
  const double C = 57.2958 * (2*r*DELTA + R*R - r*r - DELTA*DELTA)/(4*r*DELTA);
  if (sin(lrad - l0rad) > 0)
  {
    details.Apparentw1 = CAACoordinateTransformation::MapTo0To360Range(details.Geometricw1 + C);
    details.Apparentw2 = CAACoordinateTransformation::MapTo0To360Range(details.Geometricw2 + C);
  }
  else
  {
    details.Apparentw1 = CAACoordinateTransformation::MapTo0To360Range(details.Geometricw1 - C);
    details.Apparentw2 = CAACoordinateTransformation::MapTo0To360Range(details.Geometricw2 - C);
  }

  //Step 15
  const double NutationInLongitude = CAANutation::NutationInLongitude(JD);
  const double NutationInObliquity = CAANutation::NutationInObliquity(JD);
  e0 += NutationInObliquity/3600;
  e0rad = CAACoordinateTransformation::DegreesToRadians(e0);

  //Step 16
  alpha += 0.005693*(cos(alpharad)*cos(l0rad)*cos(e0rad) + sin(alpharad)*sin(l0rad))/cos(deltarad);
  alpha = CAACoordinateTransformation::MapTo0To360Range(alpha);
  alpharad = CAACoordinateTransformation::DegreesToRadians(alpha);
  delta += 0.005693*(cos(l0rad)*cos(e0rad)*(tan(e0rad)*cos(deltarad) - sin(alpharad)*sin(deltarad)) + cos(alpharad)*sin(deltarad)*sin(l0rad));

  //Step 17
  double NutationRA = CAANutation::NutationInRightAscension(alpha/15, delta, e0, NutationInLongitude, NutationInObliquity);
  const double alphadash = alpha + NutationRA/3600;
  const double alphadashrad = CAACoordinateTransformation::DegreesToRadians(alphadash);
  double NutationDec = CAANutation::NutationInDeclination(alpha/15, e0, NutationInLongitude, NutationInObliquity);
  const double deltadash = delta + NutationDec/3600;
  const double deltadashrad = CAACoordinateTransformation::DegreesToRadians(deltadash);
  NutationRA = CAANutation::NutationInRightAscension(alpha0/15, delta0, e0, NutationInLongitude, NutationInObliquity);
  const double alpha0dash = alpha0 + NutationRA/3600;
  const double alpha0dashrad = CAACoordinateTransformation::DegreesToRadians(alpha0dash);
  NutationDec = CAANutation::NutationInDeclination(alpha0/15, e0, NutationInLongitude, NutationInObliquity);
  const double delta0dash = delta0 + NutationDec/3600;
  const double delta0dashrad = CAACoordinateTransformation::DegreesToRadians(delta0dash);

  //Step 18
  details.P = CAACoordinateTransformation::MapTo0To360Range(CAACoordinateTransformation::RadiansToDegrees(atan2(cos(delta0dashrad)*sin(alpha0dashrad - alphadashrad), sin(delta0dashrad)*cos(deltadashrad) - cos(delta0dashrad)*sin(deltadashrad)*cos(alpha0dashrad - alphadashrad))));

  return details;
}
