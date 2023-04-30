/*
Module : AAGalileanMoons.cpp
Purpose: Implementation for the algorithms which obtain the positions of the 4 great moons of Jupiter
Created: PJN / 06-01-2004
History: PJN / 08-05-2011 1. Fixed a bug in CAAGalileanMoons::CalculateHelper where the periodic terms in longitude for
                          the four satellites (Sigma1 to Sigma4) were not being converted to radians prior to some
                          trigonometric calculations. Thanks to Thomas Meyer for reporting this bug.
         PJN / 16-09-2015 1. CAAGalileanMoons::Calculate now includes a "bool bHighPrecision" parameter which if set to 
                          true means the code uses the full VSOP87 theory rather than the truncated theory as 
                          presented in Meeus's book.
         PJN / 24-07-2018 1. Fixed a number of GCC warnings in the method CAAGalileanMoons::CalculateHelper. Thanks to
                          Todd Carnes for reporting this issue.
         PJN / 18-08-2019 1. Fixed some further compiler warnings when using VC 2019 Preview v16.3.0 Preview 2.0
         PJN / 24-06-2022 1. Updated all the code in AAGlobe.cpp to use C++ uniform initialization for all
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
#include "AAGalileanMoons.h"
#include "AAJupiter.h"
#include "AASun.h"
#include "AAEarth.h"
#include "AAElliptical.h"
#include "AACoordinateTransformation.h"
#include "AAElementsPlanetaryOrbit.h"
#include <cmath>


//////////////////// Implementation ///////////////////////////////////////////

CAAGalileanMoonsDetails CAAGalileanMoons::CalculateHelper(double JD, double sunlongrad, double betarad, double R, bool bHighPrecision) noexcept
{
  //What will be the return value
  CAAGalileanMoonsDetails details;

  //Calculate the position of Jupiter decreased by the light travel time from Jupiter to the specified position
  double DELTA{5};
  double PreviousLightTravelTime{0};
  double LightTravelTime{CAAElliptical::DistanceToLightTime(DELTA)};
  double x{0};
  double y{0};
  double z{0};
  double JD1{JD - LightTravelTime};
  bool bIterate{true};
  while (bIterate)
  {
    //Calculate the position of Jupiter
    const double l{CAAJupiter::EclipticLongitude(JD1, bHighPrecision)};
    const double lrad{CAACoordinateTransformation::DegreesToRadians(l)};
    const double b{CAAJupiter::EclipticLatitude(JD1, bHighPrecision)};
    const double brad{CAACoordinateTransformation::DegreesToRadians(b)};
    const double r{CAAJupiter::RadiusVector(JD1, bHighPrecision)};

    x = (r*cos(brad)*cos(lrad)) + (R*cos(sunlongrad));
    y = (r*cos(brad)*sin(lrad)) + (R*sin(sunlongrad));
    z = (r*sin(brad)) + (R*sin(betarad));
    DELTA = sqrt((x*x) + (y*y) + (z*z));
    LightTravelTime = CAAElliptical::DistanceToLightTime(DELTA);

    //Prepare for the next loop around
    bIterate = (fabs(LightTravelTime - PreviousLightTravelTime) > 2e-6); //2e-6 corresponds to 0.17 of a second
    if (bIterate)
    {
      JD1 = JD - LightTravelTime;
      PreviousLightTravelTime = LightTravelTime;
    }
  }

  //Calculate Jupiter's Longitude and Latitude
  const double lambda0{atan2(y, x)};
  const double beta0{atan(z / sqrt((x * x) + (y * y)))};

  const double t{JD - 2443000.5 - LightTravelTime};

  //Calculate the mean longitudes 
  const double l1{106.07719 + (203.488955790*t)};
  const double l1rad{CAACoordinateTransformation::DegreesToRadians(l1)};
  const double l2{175.73161 + (101.374724735*t)};
  const double l2rad{CAACoordinateTransformation::DegreesToRadians(l2)};
  const double l3{120.55883 + (50.317609207*t)};
  const double l3rad{CAACoordinateTransformation::DegreesToRadians(l3)};
  const double l4{84.44459 + (21.571071177*t)};
  const double l4rad{CAACoordinateTransformation::DegreesToRadians(l4)};

  //Calculate the perijoves
  const double pi1{CAACoordinateTransformation::DegreesToRadians(CAACoordinateTransformation::MapTo0To360Range(97.0881 + (0.16138586*t)))};
  const double pi2{CAACoordinateTransformation::DegreesToRadians(CAACoordinateTransformation::MapTo0To360Range(154.8663 + (0.04726307*t)))};
  const double pi3{CAACoordinateTransformation::DegreesToRadians(CAACoordinateTransformation::MapTo0To360Range(188.1840 + (0.00712734*t)))};
  const double pi4{CAACoordinateTransformation::DegreesToRadians(CAACoordinateTransformation::MapTo0To360Range(335.2868 + (0.00184000*t)))};

  //Calculate the nodes on the equatorial plane of Jupiter
  const double w1{312.3346 - (0.13279386*t)};
  const double w1rad{CAACoordinateTransformation::DegreesToRadians(w1)};
  const double w2{100.4411 - (0.03263064*t)};
  const double w2rad{CAACoordinateTransformation::DegreesToRadians(w2)};
  const double w3{119.1942 - (0.00717703*t)};
  const double w3rad{CAACoordinateTransformation::DegreesToRadians(w3)};
  const double w4{322.6186 - (0.00175934*t)};
  const double w4rad{CAACoordinateTransformation::DegreesToRadians(w4)};

  //Calculate the Principal inequality in the longitude of Jupiter
  const double GAMMA{0.33033*sin(CAACoordinateTransformation::DegreesToRadians(163.679 + (0.0010512*t))) +
                     0.03439*sin(CAACoordinateTransformation::DegreesToRadians(34.486 - (0.0161731*t)))};

  //Calculate the "phase of free libration"
  const double philambda{CAACoordinateTransformation::DegreesToRadians(199.6766 + (0.17379190 * t))};

  //Calculate the longitude of the node of the equator of Jupiter on the ecliptic
  double psi{CAACoordinateTransformation::DegreesToRadians(316.5182 - (0.00000208*t))};

  //Calculate the mean anomalies of Jupiter and Saturn
  const double G{CAACoordinateTransformation::DegreesToRadians(30.23756 + (0.0830925701*t) + GAMMA)};
  const double Gdash{CAACoordinateTransformation::DegreesToRadians(31.97853 + (0.0334597339*t))};

  //Calculate the longitude of the perihelion of Jupiter
  constexpr double PI{CAACoordinateTransformation::DegreesToRadians(13.469942)};

  //Calculate the periodic terms in the longitudes of the satellites
  constexpr double twoPI{2*PI};
  const double twoG{2*G};
  const double threeG{3*G};
  const double twol3rad{2*l3rad};
  const double twopsi{2*psi};
  const double l1radminusl3rad{l1rad - l3rad};
  const double l1radminuspi3{l1rad - pi3};
  const double l1radminusl2rad{l1rad - l2rad};
  const double l2radminusl3rad{l2rad - l3rad};
  const double twol2rad{2*l2rad};
  const double threel3rad{3*l3rad};
  const double twol4rad{2*l4rad};
  const double sevenl4rad{7*l4rad};
  const double Sigma1{0.47259*sin(2*l1radminusl2rad) +
                      -0.03478*sin(pi3 - pi4) +
                       0.01081*sin(l2rad - twol3rad + pi3) +
                       0.00738*sin(philambda) +
                       0.00713*sin(l2rad - twol3rad + pi2) +
                      -0.00674*sin(pi1 + pi3 - twoPI - twoG) +
                       0.00666*sin(l2rad - twol3rad + pi4) +
                       0.00445*sin(l1radminuspi3) +
                      -0.00354*sin(l1radminusl2rad) +
                      -0.00317*sin(twopsi - twoPI) +
                       0.00265*sin(l1rad - pi4) +
                      -0.00186*sin(G) +
                       0.00162*sin(pi2 - pi3) +
                       0.00158*sin(4*l1radminusl2rad) +
                      -0.00155*sin(l1radminusl3rad) +
                      -0.00138*sin(psi + w3rad - twoPI - twoG) +
                      -0.00115*sin(2*(l1rad - twol2rad + w2rad)) +
                       0.00089*sin(pi2 - pi4) +
                       0.00085*sin(l1rad + pi3 - twoPI - twoG) +
                       0.00083*sin(w2rad - w3rad) +
                       0.00053*sin(psi - w2rad)};
  const double Sigma1rad{CAACoordinateTransformation::DegreesToRadians(Sigma1)};

  const double Sigma2{1.06476*sin(2*l2radminusl3rad) +
                       0.04256*sin(l1rad - twol2rad + pi3) +
                       0.03581*sin(l2rad - pi3) +
                       0.02395*sin(l1rad - twol2rad + pi4) +
                       0.01984*sin(l2rad - pi4) +
                      -0.01778*sin(philambda) +
                       0.01654*sin(l2rad - pi2) +
                       0.01334*sin(l2rad - twol3rad + pi2) +
                       0.01294*sin(pi3 - pi4) +
                      -0.01142*sin(l2radminusl3rad) +
                      -0.01057*sin(G) +
                      -0.00775*sin(2*(psi - PI)) +
                       0.00524*sin(2*l1radminusl2rad) +
                      -0.00460*sin(l1radminusl3rad) +
                       0.00316*sin(psi - twoG + w3rad - twoPI) +
                      -0.00203*sin(pi1 + pi3 - twoPI - twoG) +
                       0.00146*sin(psi - w3rad) +
                      -0.00145*sin(twoG) +
                       0.00125*sin(psi - w4rad) +
                      -0.00115*sin(l1rad - twol3rad + pi3) +
                      -0.00094*sin(2*(l2rad - w2rad)) +
                       0.00086*sin(2*(l1rad - twol2rad + w2rad)) +
                      -0.00086*sin((5*Gdash) - twoG + CAACoordinateTransformation::DegreesToRadians(52.225)) +
                      -0.00078*sin(l2rad - l4rad) +
                      -0.00064*sin(threel3rad - sevenl4rad + (4*pi4)) +
                       0.00064*sin(pi1 - pi4) +
                      -0.00063*sin(l1rad - twol3rad + pi4) +
                       0.00058*sin(w3rad - w4rad) +
                       0.00056*sin(2*(psi - PI - G)) +
                       0.00056*sin(2*(l2rad - l4rad)) +
                       0.00055*sin(2*(l1radminusl3rad)) +
                       0.00052*sin(threel3rad - sevenl4rad + pi3 + (3*pi4)) +
                      -0.00043*sin(l1radminuspi3) +
                       0.00041*sin(5*l2radminusl3rad) +
                       0.00041*sin(pi4 - PI) +
                       0.00032*sin(w2rad - w3rad) +
                       0.00032*sin(2*(l3rad - G - PI))};
  const double Sigma2rad{CAACoordinateTransformation::DegreesToRadians(Sigma2)};

  const double Sigma3{0.16490*sin(l3rad - pi3) +
                       0.09081*sin(l3rad - pi4) +
                      -0.06907*sin(l2radminusl3rad) +
                       0.03784*sin(pi3 - pi4) +
                       0.01846*sin(2*(l3rad - l4rad)) +
                      -0.01340*sin(G) +
                      -0.01014*sin(2*(psi - PI)) +
                       0.00704*sin(l2rad - twol3rad + pi3) +
                      -0.00620*sin(l2rad - twol3rad + pi2) +
                      -0.00541*sin(l3rad - l4rad) +
                       0.00381*sin(l2rad - twol3rad + pi4) +
                       0.00235*sin(psi - w3rad) +
                       0.00198*sin(psi - w4rad) +
                       0.00176*sin(philambda) +
                       0.00130*sin(3*(l3rad - l4rad)) +
                       0.00125*sin(l1radminusl3rad) +
                      -0.00119*sin((5*Gdash) - twoG + CAACoordinateTransformation::DegreesToRadians(52.225)) +
                       0.00109*sin(l1radminusl2rad) +
                      -0.00100*sin(threel3rad - sevenl4rad + (4*pi4)) +
                       0.00091*sin(w3rad - w4rad) +
                       0.00080*sin(threel3rad - sevenl4rad + pi3 + (3*pi4)) +
                      -0.00075*sin(twol2rad - threel3rad + pi3) +
                       0.00072*sin(pi1 + pi3 - twoPI - twoG) +
                       0.00069*sin(pi4 - PI) +
                      -0.00058*sin(twol3rad - (3*l4rad) + pi4) +
                      -0.00057*sin(l3rad - twol4rad + pi4) +
                       0.00056*sin(l3rad + pi3 - twoPI - twoG) +
                      -0.00052*sin(l2rad - twol3rad + pi1) +
                      -0.00050*sin(pi2 - pi3) +
                       0.00048*sin(l3rad - twol4rad + pi3) +
                      -0.00045*sin(twol2rad - threel3rad + pi4) +
                      -0.00041*sin(pi2 - pi4) +
                      -0.00038*sin(twoG) +
                      -0.00037*sin(pi3 - pi4 + w3rad - w4rad) +
                      -0.00032*sin(threel3rad - sevenl4rad + (2*pi3) + (2*pi4)) +
                       0.00030*sin(4*(l3rad - l4rad)) +
                       0.00029*sin(l3rad + pi4 - twoPI - twoG) +
                      -0.00028*sin(w3rad + psi - twoPI - twoG) +
                       0.00026*sin(l3rad - PI - G) +
                       0.00024*sin(l2rad - threel3rad + twol4rad) +
                       0.00021*sin(l3rad - PI - G) +
                      -0.00021*sin(l3rad - pi2) +
                       0.00017*sin(2*(l3rad - pi3))};
  const double Sigma3rad{CAACoordinateTransformation::DegreesToRadians(Sigma3)};

  const double Sigma4{0.84287*sin(l4rad - pi4) +
                       0.03431*sin(pi4 - pi3) +
                      -0.03305*sin(2*(psi - PI)) +
                      -0.03211*sin(G) +
                      -0.01862*sin(l4rad - pi3) +
                       0.01186*sin(psi - w4rad) +
                       0.00623*sin(l4rad + pi4 - twoG - twoPI) +
                       0.00387*sin(2*(l4rad - pi4)) +
                      -0.00284*sin((5*Gdash) - twoG + CAACoordinateTransformation::DegreesToRadians(52.225)) +
                      -0.00234*sin(2*(psi - pi4)) +
                      -0.00223*sin(l3rad - l4rad) +
                      -0.00208*sin(l4rad - PI) +
                       0.00178*sin(psi + w4rad - (2*pi4)) +
                       0.00134*sin(pi4 - PI) +
                       0.00125*sin(2*(l4rad - G - PI)) +
                      -0.00117*sin(twoG) +
                      -0.00112*sin(2*(l3rad - l4rad)) +
                       0.00107*sin(threel3rad - sevenl4rad + (4*pi4)) +
                       0.00102*sin(l4rad - G - PI) +
                       0.00096*sin(twol4rad - psi - w4rad) +
                       0.00087*sin(2*(psi - w4rad)) +
                      -0.00085*sin(threel3rad - sevenl4rad + pi3 + (3*pi4)) +
                       0.00085*sin(l3rad - twol4rad + pi4) +
                      -0.00081*sin(2*(l4rad - psi)) +
                       0.00071*sin(l4rad + pi4 - twoPI - threeG) +
                       0.00061*sin(l1rad - l4rad) +
                      -0.00056*sin(psi - w3rad) +
                      -0.00054*sin(l3rad - twol4rad + pi3) +
                       0.00051*sin(l2rad - l4rad) +
                       0.00042*sin(2*(psi - G - PI)) +
                       0.00039*sin(2*(pi4 - w4rad)) +
                       0.00036*sin(psi + PI - pi4 - w4rad) +
                       0.00035*sin((2*Gdash) - G + CAACoordinateTransformation::DegreesToRadians(188.37)) +
                      -0.00035*sin(l4rad - pi4 + twoPI - twopsi) +
                      -0.00032*sin(l4rad + pi4 - twoPI - G) +
                       0.00030*sin((2*Gdash) - twoG + CAACoordinateTransformation::DegreesToRadians(149.15)) +
                       0.00029*sin(threel3rad - sevenl4rad + (2*pi3) + (2*pi4)) +
                       0.00028*sin(l4rad - pi4 + twopsi - twoPI) +
                      -0.00028*sin(2*(l4rad - w4rad)) +
                      -0.00027*sin(pi3 - pi4 + w3rad - w4rad) +
                      -0.00026*sin((5*Gdash) - threeG + CAACoordinateTransformation::DegreesToRadians(188.37)) +
                       0.00025*sin(w4rad - w3rad) +
                      -0.00025*sin(l2rad - threel3rad + twol4rad) +
                      -0.00023*sin(3*(l3rad - l4rad)) +
                       0.00021*sin(twol4rad - twoPI - threeG) +
                      -0.00021*sin(twol3rad - (3*l4rad) + pi4) +
                       0.00019*sin(l4rad - pi4 - G) +
                      -0.00019*sin(twol4rad - pi3 - pi4) +
                      -0.00018*sin(l4rad - pi4 + G) +
                      -0.00016*sin(l4rad + pi3 - twoPI - twoG)};
  //There is no need to calculate a Sigma4rad as it is not used in any subsequent trigonometric functions

  details.Satellite1.MeanLongitude = CAACoordinateTransformation::MapTo0To360Range(l1);
  details.Satellite1.TrueLongitude = CAACoordinateTransformation::MapTo0To360Range(l1 + Sigma1);
  double L1{CAACoordinateTransformation::DegreesToRadians(details.Satellite1.TrueLongitude)};

  details.Satellite2.MeanLongitude = CAACoordinateTransformation::MapTo0To360Range(l2);
  details.Satellite2.TrueLongitude = CAACoordinateTransformation::MapTo0To360Range(l2 + Sigma2);
  double L2{CAACoordinateTransformation::DegreesToRadians(details.Satellite2.TrueLongitude)};

  details.Satellite3.MeanLongitude = CAACoordinateTransformation::MapTo0To360Range(l3);
  details.Satellite3.TrueLongitude = CAACoordinateTransformation::MapTo0To360Range(l3 + Sigma3);
  double L3{CAACoordinateTransformation::DegreesToRadians(details.Satellite3.TrueLongitude)};

  details.Satellite4.MeanLongitude = CAACoordinateTransformation::MapTo0To360Range(l4);
  details.Satellite4.TrueLongitude = CAACoordinateTransformation::MapTo0To360Range(l4 + Sigma4);
  double L4{CAACoordinateTransformation::DegreesToRadians(details.Satellite4.TrueLongitude)};

  //Calculate the periodic terms in the latitudes of the satellites
  const double B1{atan(0.0006393*sin(L1 - w1rad) +
                   0.0001825*sin(L1 - w2rad) +
                   0.0000329*sin(L1 - w3rad) +
                  -0.0000311*sin(L1 - psi) +
                   0.0000093*sin(L1 - w4rad) +
                   0.0000075*sin((3*L1) - (4*l2rad) - (1.9927*Sigma1rad) + w2rad) +
                   0.0000046*sin(L1 + psi - twoPI - twoG))};
  details.Satellite1.EquatorialLatitude = CAACoordinateTransformation::RadiansToDegrees(B1);

  const double B2{atan(0.0081004*sin(L2 - w2rad) +
                   0.0004512*sin(L2 - w3rad) +
                  -0.0003284*sin(L2 - psi) +
                   0.0001160*sin(L2 - w4rad) + 
                   0.0000272*sin(l1rad - twol3rad + (1.0146*Sigma2rad) + w2rad) +
                  -0.0000144*sin(L2 - w1rad) +
                   0.0000143*sin(L2 + psi - twoPI - twoG) +
                   0.0000035*sin(L2 - psi + G) +
                  -0.0000028*sin(l1rad - twol3rad + (1.0146*Sigma2rad) + w3rad))};
  details.Satellite2.EquatorialLatitude = CAACoordinateTransformation::RadiansToDegrees(B2);

  const double threeL3{3*L3};
  const double four0threeSigma3rad{4.03*Sigma3rad};
  const double B3{atan(0.0032402*sin(L3 - w3rad) +
                  -0.0016911*sin(L3 - psi) +
                   0.0006847*sin(L3 - w4rad) +
                  -0.0002797*sin(L3 - w2rad) +
                   0.0000321*sin(L3 + psi - twoPI - twoG) +
                   0.0000051*sin(L3 - psi + G) +
                  -0.0000045*sin(L3 - psi - G) +
                  -0.0000045*sin(L3 + psi - twoPI) +
                   0.0000037*sin(L3 + psi - twoPI - threeG) +
                   0.0000030*sin(twol2rad - threeL3 + four0threeSigma3rad + w2rad) +
                  -0.0000021*sin(twol2rad - threeL3 + four0threeSigma3rad + w3rad))};
  details.Satellite3.EquatorialLatitude = CAACoordinateTransformation::RadiansToDegrees(B3);

  const double B4{atan(-0.0076579*sin(L4 - psi) +
                   0.0044134*sin(L4 - w4rad) +
                  -0.0005112*sin(L4 - w3rad) +
                   0.0000773*sin(L4 + psi - twoPI - twoG) +
                   0.0000104*sin(L4 - psi + G) +
                  -0.0000102*sin(L4 - psi - G) +
                   0.0000088*sin(L4 + psi - twoPI - threeG) +
                  -0.0000038*sin(L4 + psi - twoPI - G))};
  details.Satellite4.EquatorialLatitude = CAACoordinateTransformation::RadiansToDegrees(B4);

  //Calculate the periodic terms for the radius vector
  details.Satellite1.r = 5.90569*(1 + (-0.0041339*cos(2*l1radminusl2rad) +
                                       -0.0000387*cos(l1radminuspi3) +
                                       -0.0000214*cos(l1rad - pi4) +
                                        0.0000170*cos(l1radminusl2rad) +
                                       -0.0000131*cos(4*l1radminusl2rad) +
                                        0.0000106*cos(l1radminusl3rad) +
                                       -0.0000066*cos(l1rad + pi3 - twoPI - twoG)));

  details.Satellite2.r = 9.39657*(1 + (0.0093848*cos(l1radminusl2rad) +
                                      -0.0003116*cos(l2rad - pi3) +
                                      -0.0001744*cos(l2rad - pi4) +
                                      -0.0001442*cos(l2rad - pi2) +
                                       0.0000553*cos(l2radminusl3rad) +
                                       0.0000523*cos(l1radminusl3rad) +
                                      -0.0000290*cos(2*l1radminusl2rad) +
                                       0.0000164*cos(2*(l2rad - w2rad)) +
                                       0.0000107*cos(l1rad - twol3rad + pi3) +
                                      -0.0000102*cos(l2rad - pi1) +
                                      -0.0000091*cos(2*l1radminusl3rad)));

  details.Satellite3.r = 14.98832*(1 + (-0.0014388*cos(l3rad - pi3) +
                                        -0.0007919*cos(l3rad - pi4) +
                                         0.0006342*cos(l2radminusl3rad) +
                                        -0.0001761*cos(2*(l3rad - l4rad)) +
                                         0.0000294*cos(l3rad - l4rad) +
                                        -0.0000156*cos(3*(l3rad - l4rad)) +
                                         0.0000156*cos(l1radminusl3rad) +
                                        -0.0000153*cos(l1radminusl2rad) +
                                         0.0000070*cos(twol2rad - threel3rad + pi3) +
                                        -0.0000051*cos(l3rad + pi3 - twoPI - twoG)));

  details.Satellite4.r = 26.36273*(1 + (-0.0073546*cos(l4rad - pi4) +
                                         0.0001621*cos(l4rad - pi3) +
                                         0.0000974*cos(l3rad - l4rad) +
                                        -0.0000543*cos(l4rad + pi4 - twoPI - twoG) +
                                        -0.0000271*cos(2*(l4rad - pi4)) +
                                         0.0000182*cos(l4rad - PI) +
                                         0.0000177*cos(2*(l3rad - l4rad)) +
                                        -0.0000167*cos(twol4rad - psi - w4rad) +
                                         0.0000167*cos(psi - w4rad) +
                                        -0.0000155*cos(2*(l4rad - PI - G)) +
                                         0.0000142*cos(2*(l4rad - psi)) +
                                         0.0000105*cos(l1rad - l4rad) +
                                         0.0000092*cos(l2rad - l4rad) +
                                        -0.0000089*cos(l4rad - PI - G) +
                                        -0.0000062*cos(l4rad + pi4 - twoPI - threeG) +
                                         0.0000048*cos(2*(l4rad - w4rad))));

  //Calculate T0
  const double T0{(JD - 2433282.423)/36525};

  //Calculate the precession in longitude from Epoch B1950 to the date
  const double P{CAACoordinateTransformation::DegreesToRadians((1.3966626*T0) + (0.0003088*T0*T0))};

  //Add it to L1 - L4 and psi
  L1 += P;
  details.Satellite1.TropicalLongitude = CAACoordinateTransformation::MapTo0To360Range(CAACoordinateTransformation::RadiansToDegrees(L1));
  L2 += P;
  details.Satellite2.TropicalLongitude = CAACoordinateTransformation::MapTo0To360Range(CAACoordinateTransformation::RadiansToDegrees(L2));
  L3 += P;
  details.Satellite3.TropicalLongitude = CAACoordinateTransformation::MapTo0To360Range(CAACoordinateTransformation::RadiansToDegrees(L3));
  L4 += P;
  details.Satellite4.TropicalLongitude = CAACoordinateTransformation::MapTo0To360Range(CAACoordinateTransformation::RadiansToDegrees(L4));
  psi += P;

  //Calculate the inclination of Jupiter's axis of rotation on the orbital plane
  const double T{(JD - 2415020.5)/36525};
  const double I{3.120262 + (0.0006*T)};
  const double Irad{CAACoordinateTransformation::DegreesToRadians(I)};

  const double X1{details.Satellite1.r*cos(L1 - psi)*cos(B1)};
  const double X2{details.Satellite2.r*cos(L2 - psi)*cos(B2)};
  const double X3{details.Satellite3.r*cos(L3 - psi)*cos(B3)};
  const double X4{details.Satellite4.r*cos(L4 - psi)*cos(B4)};
  constexpr double X5{0};

  const double Y1{details.Satellite1.r*sin(L1 - psi)*cos(B1)};
  const double Y2{details.Satellite2.r*sin(L2 - psi)*cos(B2)};
  const double Y3{details.Satellite3.r*sin(L3 - psi)*cos(B3)};
  const double Y4{details.Satellite4.r*sin(L4 - psi)*cos(B4)};
  constexpr double Y5{0};

  const double Z1{details.Satellite1.r*sin(B1)};
  const double Z2{details.Satellite2.r*sin(B2)};
  const double Z3{details.Satellite3.r*sin(B3)};
  const double Z4{details.Satellite4.r*sin(B4)};
  constexpr double Z5{1};

  //Now do the rotations, first for the fictitious 5th satellite, so that we can calculate D
  const double omega{CAACoordinateTransformation::DegreesToRadians(CAAElementsPlanetaryOrbit::JupiterLongitudeAscendingNode(JD))};
  const double i{CAACoordinateTransformation::DegreesToRadians(CAAElementsPlanetaryOrbit::JupiterInclination(JD))};
  double A6{0};
  double B6{0};
  double C6{0};
  Rotations(X5, Y5, Z5, Irad, psi, i, omega, lambda0, beta0, A6, B6, C6);
  const double D{atan2(A6, C6)};
  const double cosD{cos(D)};
  const double sinD{sin(D)};

  //Now calculate the values for satellite 1
  Rotations(X1, Y1, Z1, Irad, psi, i, omega, lambda0, beta0, A6, B6, C6);
  details.Satellite1.TrueRectangularCoordinates.X = (A6*cosD) - (C6*sinD);
  details.Satellite1.TrueRectangularCoordinates.Y = (A6*sinD) + (C6*cosD);
  details.Satellite1.TrueRectangularCoordinates.Z = B6;

  //Now calculate the values for satellite 2
  Rotations(X2, Y2, Z2, Irad, psi, i, omega, lambda0, beta0, A6, B6, C6);
  details.Satellite2.TrueRectangularCoordinates.X = (A6*cosD) - (C6*sinD);
  details.Satellite2.TrueRectangularCoordinates.Y = (A6*sinD) + (C6*cosD);
  details.Satellite2.TrueRectangularCoordinates.Z = B6;

  //Now calculate the values for satellite 3
  Rotations(X3, Y3, Z3, Irad, psi, i, omega, lambda0, beta0, A6, B6, C6);
  details.Satellite3.TrueRectangularCoordinates.X = (A6*cosD) - (C6*sinD);
  details.Satellite3.TrueRectangularCoordinates.Y = (A6*sinD) + (C6*cosD);
  details.Satellite3.TrueRectangularCoordinates.Z = B6;

  //And finally for satellite 4
  Rotations(X4, Y4, Z4, Irad, psi, i, omega, lambda0, beta0, A6, B6, C6);
  details.Satellite4.TrueRectangularCoordinates.X = (A6*cosD) - (C6*sinD);
  details.Satellite4.TrueRectangularCoordinates.Y = (A6*sinD) + (C6*cosD);
  details.Satellite4.TrueRectangularCoordinates.Z = B6;

  //apply the differential light-time correction
  details.Satellite1.ApparentRectangularCoordinates.X = details.Satellite1.TrueRectangularCoordinates.X + fabs(details.Satellite1.TrueRectangularCoordinates.Z)/17295*sqrt(1 - (details.Satellite1.TrueRectangularCoordinates.X/details.Satellite1.r)*(details.Satellite1.TrueRectangularCoordinates.X/details.Satellite1.r));
  details.Satellite1.ApparentRectangularCoordinates.Y = details.Satellite1.TrueRectangularCoordinates.Y;
  details.Satellite1.ApparentRectangularCoordinates.Z = details.Satellite1.TrueRectangularCoordinates.Z;

  details.Satellite2.ApparentRectangularCoordinates.X = details.Satellite2.TrueRectangularCoordinates.X + fabs(details.Satellite2.TrueRectangularCoordinates.Z)/21819*sqrt(1 - (details.Satellite2.TrueRectangularCoordinates.X/details.Satellite2.r)*(details.Satellite2.TrueRectangularCoordinates.X/details.Satellite2.r));
  details.Satellite2.ApparentRectangularCoordinates.Y = details.Satellite2.TrueRectangularCoordinates.Y;
  details.Satellite2.ApparentRectangularCoordinates.Z = details.Satellite2.TrueRectangularCoordinates.Z;

  details.Satellite3.ApparentRectangularCoordinates.X = details.Satellite3.TrueRectangularCoordinates.X + fabs(details.Satellite3.TrueRectangularCoordinates.Z)/27558*sqrt(1 - (details.Satellite3.TrueRectangularCoordinates.X/details.Satellite3.r)*(details.Satellite3.TrueRectangularCoordinates.X/details.Satellite3.r));
  details.Satellite3.ApparentRectangularCoordinates.Y = details.Satellite3.TrueRectangularCoordinates.Y;
  details.Satellite3.ApparentRectangularCoordinates.Z = details.Satellite3.TrueRectangularCoordinates.Z;

  details.Satellite4.ApparentRectangularCoordinates.X = details.Satellite4.TrueRectangularCoordinates.X + fabs(details.Satellite4.TrueRectangularCoordinates.Z)/36548*sqrt(1 - (details.Satellite4.TrueRectangularCoordinates.X/details.Satellite4.r)*(details.Satellite4.TrueRectangularCoordinates.X/details.Satellite4.r));
  details.Satellite4.ApparentRectangularCoordinates.Y = details.Satellite4.TrueRectangularCoordinates.Y;
  details.Satellite4.ApparentRectangularCoordinates.Z = details.Satellite4.TrueRectangularCoordinates.Z;

  //apply the perspective effect correction
  double W{DELTA/(DELTA + details.Satellite1.TrueRectangularCoordinates.Z/2095)};
  details.Satellite1.ApparentRectangularCoordinates.X *= W;
  details.Satellite1.ApparentRectangularCoordinates.Y *= W;

  W = DELTA/(DELTA + details.Satellite2.TrueRectangularCoordinates.Z/2095);
  details.Satellite2.ApparentRectangularCoordinates.X *= W;
  details.Satellite2.ApparentRectangularCoordinates.Y *= W;

  W = DELTA/(DELTA + details.Satellite3.TrueRectangularCoordinates.Z/2095);
  details.Satellite3.ApparentRectangularCoordinates.X *= W;
  details.Satellite3.ApparentRectangularCoordinates.Y *= W;

  W = DELTA/(DELTA + details.Satellite4.TrueRectangularCoordinates.Z/2095);
  details.Satellite4.ApparentRectangularCoordinates.X *= W;
  details.Satellite4.ApparentRectangularCoordinates.Y *= W;

  return details;
}

CAAGalileanMoonsDetails CAAGalileanMoons::Calculate(double JD, bool bHighPrecision) noexcept
{
  //Calculate the position of the Sun
  const double sunlong{CAASun::GeometricEclipticLongitude(JD, bHighPrecision)};
  const double sunlongrad{CAACoordinateTransformation::DegreesToRadians(sunlong)};
  const double beta{CAASun::GeometricEclipticLatitude(JD, bHighPrecision)};
  const double betarad{CAACoordinateTransformation::DegreesToRadians(beta)};
  const double R{CAAEarth::RadiusVector(JD, bHighPrecision)};

  //Calculate the the light travel time from Jupiter to the Earth
  double DELTA{5};
  double PreviousEarthLightTravelTime{0};
  double EarthLightTravelTime{CAAElliptical::DistanceToLightTime(DELTA)};
  double JD1{JD - EarthLightTravelTime};
  bool bIterate{true};
  double x{0};
  double y{0};
  double z{0};
  while (bIterate)
  {
    //Calculate the position of Jupiter
    const double l{CAAJupiter::EclipticLongitude(JD1, bHighPrecision)};
    const double lrad{CAACoordinateTransformation::DegreesToRadians(l)};
    const double b{CAAJupiter::EclipticLatitude(JD1, bHighPrecision)};
    const double brad{CAACoordinateTransformation::DegreesToRadians(b)};
    const double cosbrad{cos(brad)};
    const double r{CAAJupiter::RadiusVector(JD1, bHighPrecision)};

    x = (r*cosbrad*cos(lrad)) + (R*cos(sunlongrad));
    y = (r*cosbrad*sin(lrad)) + (R*sin(sunlongrad));
    z = (r*sin(brad)) + (R*sin(betarad));
    DELTA = sqrt(x*x + y*y + z*z);
    EarthLightTravelTime = CAAElliptical::DistanceToLightTime(DELTA);

    //Prepare for the next loop around
    bIterate = (fabs(EarthLightTravelTime - PreviousEarthLightTravelTime) > 2e-6); //2e-6 corresponds to 0.17 of a second
    if (bIterate)
    {
      JD1 = JD - EarthLightTravelTime;
      PreviousEarthLightTravelTime = EarthLightTravelTime;
    }
  }

  //Calculate the details as seen from the earth
  CAAGalileanMoonsDetails details1{CalculateHelper(JD, sunlongrad, betarad, R, bHighPrecision)};
  FillInPhenomenaDetails(details1.Satellite1);
  FillInPhenomenaDetails(details1.Satellite2);
  FillInPhenomenaDetails(details1.Satellite3);
  FillInPhenomenaDetails(details1.Satellite4);

  //Calculate the the light travel time from Jupiter to the Sun
  JD1 = JD - EarthLightTravelTime;
  const double l{CAAJupiter::EclipticLongitude(JD1, bHighPrecision)};
  const double lrad{CAACoordinateTransformation::DegreesToRadians(l)};
  const double b{CAAJupiter::EclipticLatitude(JD1, bHighPrecision)};
  const double brad{CAACoordinateTransformation::DegreesToRadians(b)};
  const double r{CAAJupiter::RadiusVector(JD1, bHighPrecision)};
  const double cosbrad{cos(brad)};
  x = r*cosbrad*cos(lrad);
  y = r*cosbrad*sin(lrad);
  z = r*sin(brad);
  DELTA = sqrt((x*x) + (y*y) + (z*z));
  const double SunLightTravelTime{CAAElliptical::DistanceToLightTime(DELTA)};

  //Calculate the details as seen from the Sun
  CAAGalileanMoonsDetails details2{CalculateHelper(JD + SunLightTravelTime - EarthLightTravelTime, sunlongrad, betarad, 0, bHighPrecision)};
  FillInPhenomenaDetails(details2.Satellite1);
  FillInPhenomenaDetails(details2.Satellite2);
  FillInPhenomenaDetails(details2.Satellite3);
  FillInPhenomenaDetails(details2.Satellite4);

  //Finally transfer the required values from details2 to details1
  details1.Satellite1.bInEclipse = details2.Satellite1.bInOccultation;
  details1.Satellite2.bInEclipse = details2.Satellite2.bInOccultation;
  details1.Satellite3.bInEclipse = details2.Satellite3.bInOccultation;
  details1.Satellite4.bInEclipse = details2.Satellite4.bInOccultation;
  details1.Satellite1.bInShadowTransit = details2.Satellite1.bInTransit;
  details1.Satellite2.bInShadowTransit = details2.Satellite2.bInTransit;
  details1.Satellite3.bInShadowTransit = details2.Satellite3.bInTransit;
  details1.Satellite4.bInShadowTransit = details2.Satellite4.bInTransit;

  return details1;
}

void CAAGalileanMoons::Rotations(double X, double Y, double Z, double I, double psi, double i, double omega, double lambda0, double beta0, double& A6, double& B6, double& C6) noexcept
{
  const double phi{psi - omega};

  //Rotation towards Jupiter's orbital plane
  const double A1{X};
  const double cosI{cos(I)};
  const double sinI{sin(I)};
  const double B1{(Y*cosI) - (Z*sinI)};
  const double C1{(Y*sinI) + (Z*cosI)};

  //Rotation towards the ascending node of the orbit of Jupiter
  const double cosphi{cos(phi)};
  const double sinphi{sin(phi)};
  const double A2{(A1*cosphi) - (B1*sinphi)};
  const double B2{(A1*sinphi) + (B1*cosphi)};
  const double C2{C1};

  //Rotation towards the plane of the ecliptic
  const double A3{A2};
  const double cosi{cos(i)};
  const double sini{sin(i)};
  const double B3{(B2*cosi) - (C2*sini)};
  const double C3{(B2*sini) + (C2*cosi)};

  //Rotation towards the vernal equinox
  const double cosomega{cos(omega)};
  const double sinomega{sin(omega)};
  const double A4{(A3*cosomega) - (B3*sinomega)};
  const double B4{(A3*sinomega) + (B3*cosomega)};
  const double C4{C3};

  const double coslambda0(cos(lambda0));
  const double sinlambda0(sin(lambda0));
  const double A5{(A4*sinlambda0) - (B4*coslambda0)};
  const double B5{(A4*coslambda0) + (B4*sinlambda0)};
  const double C5{C4};

  A6 = A5;
  const double cosbeta0{cos(beta0)};
  const double sinbeta0{sin(beta0)};
  B6 = (C5*sinbeta0) + (B5*cosbeta0);
  C6 = (C5*cosbeta0) - (B5*sinbeta0);
}

void CAAGalileanMoons::FillInPhenomenaDetails(CAAGalileanMoonDetail& detail) noexcept
{
  const double Y1{1.071374*detail.ApparentRectangularCoordinates.Y};
  const double r{(Y1*Y1) + (detail.ApparentRectangularCoordinates.X*detail.ApparentRectangularCoordinates.X)};

  if (r < 1)
  {
    if (detail.ApparentRectangularCoordinates.Z < 0)
    {
      //Satellite nearer to Earth than Jupiter, so it must be a transit not an occultation
      detail.bInTransit = true;
      detail.bInOccultation = false;
    }
    else
    {
      detail.bInTransit = false;
      detail.bInOccultation = true;
    }
  }
  else
  {
    detail.bInTransit = false;
    detail.bInOccultation = false;
  }
}
