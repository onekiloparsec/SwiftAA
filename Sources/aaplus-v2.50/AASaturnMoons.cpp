/*
Module : AASaturnMoons.cpp
Purpose: Implementation for the algorithms which obtain the positions of the moons of Saturn
Created: PJN / 09-01-2004
History: PJN / 09-02-2004 1. Updated the values used in the calculation of the a1 and a2 constants
                          for Rhea (satellite V) following an email from Jean Meeus confirming
                          that these constants are indeed incorrect as published in the book.
         PJN / 16-09-2015 1. CAASaturnMoons::Calculate now includes a "bool bHighPrecision" parameter
                          which if set to true means the code uses the full VSOP87 theory rather than the
                          truncated theory as presented in Meeus's book.
         PJN / 12-02-2017 1. Fixed a copy and paste bug in CAASaturnMoons::CalculateHelper in the calculation
                          of the value mu for the eight moon (Iapetus). Thanks to Cedric Foellmi for
                          reporting this issue.
         PJN / 24-07-2018 1. Fixed a GCC warning in the method CAASaturnMoons::HelperSubroutine. Thanks to
                          Todd Carnes for reporting this issue.
         PJN / 18-08-2019 1. Fixed some further compiler warnings when using VC 2019 Preview v16.3.0 Preview 2.0
         PJN / 11-07-2022 1. Updated all the code in AASaturnMoons.cpp to use C++ uniform initialization for
                          all variable declarations.

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
#include "AASaturnMoons.h"
#include "AASaturn.h"
#include "AASun.h"
#include "AAEarth.h"
#include "AAElliptical.h"
#include "AACoordinateTransformation.h"
#include "AAPrecession.h"
#include <cmath>


//////////////////// Implementation ///////////////////////////////////////////

void CAASaturnMoons::HelperSubroutine(double e, double lambdadash, double p, double a, double omega, double i, double c1, double s1, double& r, double& lambda, double& gamma, double& w) noexcept
{
  const double e2{e*e};
  const double e3{e2*e};
  const double e4{e3*e};
  const double e5{e4*e};
  const double M{CAACoordinateTransformation::DegreesToRadians(lambdadash - p)};

  const double Crad{((2*e) - (0.25*e3) + (0.0520833333*e5))*sin(M) +
                    ((1.25*e2) - (0.458333333*e4))*sin(2*M) +
                    ((1.083333333*e3) - (0.671875*e5))*sin(3*M) +
                    (1.072917*e4*sin(4*M)) +
                    (1.142708*e5*sin(5*M))};
  double C{CAACoordinateTransformation::RadiansToDegrees(Crad)};
  r = a*(1 - e2)/(1 + (e*cos(M + Crad)));
  double g{omega - 168.8112};
  const double grad{CAACoordinateTransformation::DegreesToRadians(g)};
  const double cosgrad{cos(grad)};
  const double singrad{sin(grad)};
  const double irad{CAACoordinateTransformation::DegreesToRadians(i)};
  const double sinirad{sin(irad)};
  const double cosirad{cos(irad)};
  const double a1{sinirad*singrad};
  const double a2{(c1*sinirad*cosgrad) - (s1*cosirad)};
  gamma = CAACoordinateTransformation::RadiansToDegrees(asin(sqrt((a1*a1) + (a2*a2))));
  const double urad{atan2(a1, a2)};
  double u{CAACoordinateTransformation::RadiansToDegrees(urad)};
  w = CAACoordinateTransformation::MapTo0To360Range(168.8112 + u);
  const double h{(c1*sinirad) - (s1*cosirad*cosgrad)};
  const double psirad{atan2(s1*singrad, h)};
  double psi{CAACoordinateTransformation::RadiansToDegrees(psirad)};
  lambda = lambdadash + C + u - g - psi;
}

CAASaturnMoonsDetails CAASaturnMoons::CalculateHelper(double JD, double sunlongrad, double betarad, double R, bool bHighPrecision) noexcept
{
  //What will be the return value
  CAASaturnMoonsDetails details;

  //Calculate the position of Saturn decreased by the light travel time from Saturn to the specified position
  double DELTA{9};
  double PreviousLightTravelTime{0};
  double LightTravelTime{CAAElliptical::DistanceToLightTime(DELTA)};
  double x{0};
  double y{0};
  double z{0};
  double JD1{JD - LightTravelTime};
  bool bIterate{true};
  while (bIterate)
  {
    //Calculate the position of Saturn
    const double l{CAASaturn::EclipticLongitude(JD1, bHighPrecision)};
    const double lrad{CAACoordinateTransformation::DegreesToRadians(l)};
    const double b{CAASaturn::EclipticLatitude(JD1, bHighPrecision)};
    const double brad{CAACoordinateTransformation::DegreesToRadians(b)};
    const double cosbrad{cos(brad)};
    const double r{CAASaturn::RadiusVector(JD1, bHighPrecision)};

    x = (r*cosbrad*cos(lrad)) + (R*cos(sunlongrad));
    y = (r*cosbrad*sin(lrad)) + (R*sin(sunlongrad));
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

  //Calculate Saturn's Longitude and Latitude
  double lambda0{atan2(y, x)};
  lambda0 = CAACoordinateTransformation::RadiansToDegrees(lambda0);
  double beta0{atan(z/sqrt((x*x) + (y*y)))};
  beta0 = CAACoordinateTransformation::RadiansToDegrees(beta0);

  //Precess the longitude and Latitude to B1950.0
  const CAA2DCoordinate Saturn1950{CAAPrecession::PrecessEcliptic(lambda0, beta0, JD, 2433282.4235)};
  lambda0 = Saturn1950.X;
  const double lambda0rad{CAACoordinateTransformation::DegreesToRadians(lambda0)};
  beta0 = Saturn1950.Y;
  const double beta0rad{CAACoordinateTransformation::DegreesToRadians(beta0)};

  const double JDE{JD - LightTravelTime};
  const double t1{JDE - 2411093.0};
  const double t2{t1/365.25};
  const double t3{((JDE - 2433282.423)/365.25) + 1950.0};
  const double t4{JDE - 2411368.0};
  const double t5{t4/365.25};
  const double t6{JDE - 2415020.0};
  const double t7{t6/36525.0};
  const double t8{t6/365.25};
  const double t9{(JDE - 2442000.5)/365.25};
  const double t10{JDE - 2409786.0};
  const double t11{t10/36525.0};
  const double t112{t11*t11};
  const double t113{t112*t11};

  const double W0{CAACoordinateTransformation::MapTo0To360Range(5.095*(t3 - 1866.39))};
  const double W0rad{CAACoordinateTransformation::DegreesToRadians(W0)};
  const double W1{CAACoordinateTransformation::MapTo0To360Range(74.4 + (32.39*t2))};
  const double W1rad{CAACoordinateTransformation::DegreesToRadians(W1)};
  const double W2{CAACoordinateTransformation::MapTo0To360Range(134.3 + (92.62*t2))};
  const double W2rad{CAACoordinateTransformation::DegreesToRadians(W2)};
  const double W3{CAACoordinateTransformation::MapTo0To360Range(42.0 - (0.5118*t5))};
  const double W3rad{CAACoordinateTransformation::DegreesToRadians(W3)};
  const double W4{CAACoordinateTransformation::MapTo0To360Range(276.59 + (0.5118*t5))};
  const double W4rad{CAACoordinateTransformation::DegreesToRadians(W4)};
  const double W5{CAACoordinateTransformation::MapTo0To360Range(267.2635 + (1222.1136*t7))};
  const double W5rad{CAACoordinateTransformation::DegreesToRadians(W5)};
  const double W6{CAACoordinateTransformation::MapTo0To360Range(175.4762 + (1221.5515*t7))};
  const double W6rad{CAACoordinateTransformation::DegreesToRadians(W6)};
  const double W7{CAACoordinateTransformation::MapTo0To360Range(2.4891 + (0.002435*t7))};
  const double W7rad{CAACoordinateTransformation::DegreesToRadians(W7)};
  const double sinW7rad{sin(W7rad)};
  const double W8{CAACoordinateTransformation::MapTo0To360Range(113.35 - (0.2597*t7))};
  const double W8rad{CAACoordinateTransformation::DegreesToRadians(W8)};

  const double s1{sin(CAACoordinateTransformation::DegreesToRadians(28.0817))};
  const double s2{sin(CAACoordinateTransformation::DegreesToRadians(168.8112))};
  const double c1{cos(CAACoordinateTransformation::DegreesToRadians(28.0817))};
  const double c2{cos(CAACoordinateTransformation::DegreesToRadians(168.8112))};
  const double e1{0.05589 - (0.000346*t7)};


  //Satellite 1
  double L{CAACoordinateTransformation::MapTo0To360Range(127.64 + (381.994497*t1) - (43.57*sin(W0rad)) - (0.720*sin(3*W0rad)) - (0.02144*sin(5*W0rad)))};
  double p{106.1 + (365.549*t2)};
  double M{L - p};
  double Mrad{CAACoordinateTransformation::DegreesToRadians(M)};
  double C{(2.18287*sin(Mrad)) + (0.025988*sin(2*Mrad)) + (0.00043*sin(3*Mrad))};
  double Crad{CAACoordinateTransformation::DegreesToRadians(C)};
  const double lambda1{CAACoordinateTransformation::MapTo0To360Range(L + C)};
  const double r1{3.06879/(1 + (0.01905*cos(Mrad + Crad)))};
  constexpr double gamma1{1.563};
  const double omega1{CAACoordinateTransformation::MapTo0To360Range(54.5 - (365.072*t2))};

  //Satellite 2
  L = CAACoordinateTransformation::MapTo0To360Range(200.317 + (262.7319002*t1) + (0.25667*sin(W1rad)) + (0.20883*sin(W2rad)));
  p = 309.107 + (123.44121*t2);
  M = L - p;
  Mrad = CAACoordinateTransformation::DegreesToRadians(M);
  C = (0.55577*sin(Mrad)) + (0.00168*sin(2*Mrad));
  Crad = CAACoordinateTransformation::DegreesToRadians(C);
  const double lambda2{CAACoordinateTransformation::MapTo0To360Range(L + C)};
  const double r2{3.94118/(1 + (0.00485*cos(Mrad + Crad)))};
  constexpr double gamma2{0.0262};
  const double omega2{CAACoordinateTransformation::MapTo0To360Range(348 - (151.95*t2))};

  //Satellite 3
  const double lambda3{CAACoordinateTransformation::MapTo0To360Range(285.306 + (190.69791226*t1) + (2.063*sin(W0rad)) + (0.03409*sin(3*W0rad)) + (0.001015*sin(5*W0rad)))};
  constexpr double r3{4.880998};
  constexpr double gamma3{1.0976};
  const double omega3{CAACoordinateTransformation::MapTo0To360Range(111.33 - (72.2441*t2))};

  //Satellite 4
  L = CAACoordinateTransformation::MapTo0To360Range(254.712 + (131.53493193*t1) - (0.0215*sin(W1rad)) - (0.01733*sin(W2rad)));
  p = 174.8 + (30.820*t2);
  M = L - p;
  Mrad = CAACoordinateTransformation::DegreesToRadians(M);
  C = (0.24717*sin(Mrad)) + (0.00033*sin(2*Mrad));
  Crad = CAACoordinateTransformation::DegreesToRadians(C);
  const double lambda4{CAACoordinateTransformation::MapTo0To360Range(L + C)};
  const double r4{6.24871/(1 + (0.002157*cos(Mrad + Crad)))};
  constexpr double gamma4{0.0139};
  const double omega4{CAACoordinateTransformation::MapTo0To360Range(232 - (30.27*t2))};

  //Satellite 5
  const double pdash{342.7 + (10.057*t2)};
  const double pdashrad{CAACoordinateTransformation::DegreesToRadians(pdash)};
  double a1{(0.000265*sin(pdashrad)) + (0.001*sin(W4rad))}; //Note the book uses the incorrect constant 0.01*sin(W4rad);
  double a2{(0.000265*cos(pdashrad)) + (0.001*cos(W4rad))}; //Note the book uses the incorrect constant 0.01*cos(W4rad);
  double e{sqrt((a1*a1) + (a2*a2))};
  p = CAACoordinateTransformation::RadiansToDegrees(atan2(a1, a2));
  const double N{345 - (10.057*t2)};
  const double Nrad{CAACoordinateTransformation::DegreesToRadians(N)};
  double lambdadash{CAACoordinateTransformation::MapTo0To360Range(359.244 + (79.69004720*t1) + (0.086754*sin(Nrad)))};
  double i{28.0362 + (0.346898*cos(Nrad)) + (0.01930*cos(W3rad))};
  double omega{168.8034 + (0.736936*sin(Nrad)) + (0.041*sin(W3rad))};
  double a{8.725924};
  double lambda5{0};
  double gamma5{0};
  double omega5{0};
  double r5{0};
  HelperSubroutine(e, lambdadash, p, a, omega, i, c1, s1, r5, lambda5, gamma5, omega5);

  //Satellite 6
  L = 261.1582 + (22.57697855*t4) + (0.074025*sin(W3rad));
  double idash{27.45141 + (0.295999*cos(W3rad))};
  double idashrad{CAACoordinateTransformation::DegreesToRadians(idash)};
  const double sinidashrad{sin(idashrad)};
  const double cosidashrad{cos(idashrad)};
  double omegadash{168.66925 + (0.628808*sin(W3rad))};
  const double omegadashrad{CAACoordinateTransformation::DegreesToRadians(omegadash)};
  a1 = sinW7rad*sin(omegadashrad - W8rad);
  a2 = (cos(W7rad)*sinidashrad) - (sinW7rad*cosidashrad*cos(omegadashrad - W8rad));
  constexpr double g0{CAACoordinateTransformation::DegreesToRadians(102.8623)};
  double psi{atan2(a1, a2)};
  if (a2 < 0)
    psi += CAACoordinateTransformation::PI();
  const double psideg{CAACoordinateTransformation::RadiansToDegrees(psi)};
  const double s{sqrt((a1*a1) + (a2*a2))};
  double g{W4 - omegadash - psideg};
  double w_{0};
  for (int j{0}; j<3; j++)
  {
    w_ = W4 + 0.37515*(sin(2*CAACoordinateTransformation::DegreesToRadians(g)) - sin(2*g0));
    g = w_ - omegadash - psideg;
  }
  const double grad{CAACoordinateTransformation::DegreesToRadians(g)};
  double edash{0.029092 + (0.00019048*(cos(2*grad) - cos(2*g0)))};
  const double q{CAACoordinateTransformation::DegreesToRadians(2*(W5 - w_))};
  const double b1{sinidashrad*sin(omegadashrad - W8rad)};
  const double b2{(cos(W7rad)*sinidashrad*cos(omegadashrad - W8rad)) - (sin(W7rad)*cosidashrad)};
  const double atanb1b2{atan2(b1, b2)};
  double theta{atanb1b2 + W8rad};
  e = edash + (0.002778797*edash*cos(q));
  p = w_ + (0.159215*sin(q));
  double u = (2*W5rad) - (2*theta) + psi;
  const double h{(0.9375*edash*edash*sin(q)) + (0.1875*s*s*sin(2*(W5rad - theta)))};
  lambdadash = CAACoordinateTransformation::MapTo0To360Range(L - 0.254744*((e1*sin(W6rad)) + (0.75*e1*e1*sin(2*W6rad)) + h));
  i = idash + (0.031843*s*cos(u));
  omega = omegadash + ((0.031843*s*sin(u))/sinidashrad);
  a = 20.216193;
  double lambda6{0};
  double gamma6{0};
  double omega6{0};
  double r6{0};
  HelperSubroutine(e, lambdadash, p, a, omega, i, c1, s1, r6, lambda6, gamma6, omega6);

  //Satellite 7
  const double eta{92.39 + (0.5621071*t6)};
  const double etarad{CAACoordinateTransformation::DegreesToRadians(eta)};
  const double zeta{148.19 - (19.18*t8)};
  const double zetarad{CAACoordinateTransformation::DegreesToRadians(zeta)};
  theta = CAACoordinateTransformation::DegreesToRadians(184.8 - (35.41*t9));
  const double thetadash{theta - CAACoordinateTransformation::DegreesToRadians(7.5)};
  const double as{CAACoordinateTransformation::DegreesToRadians(176 + (12.22*t8))};
  const double bs{CAACoordinateTransformation::DegreesToRadians(8 + (24.44*t8))};
  const double cs{bs + CAACoordinateTransformation::DegreesToRadians(5)};
  w_ = 69.898 - (18.67088*t8);
  double phi{2*(w_ - W5)};
  double phirad{CAACoordinateTransformation::DegreesToRadians(phi)};
  const double chi{94.9 - (2.292*t8)};
  const double chirad{CAACoordinateTransformation::DegreesToRadians(chi)};
  a = 24.50601 - (0.08686*cos(etarad)) - (0.00166*cos(zetarad + etarad)) + (0.00175*cos(zetarad - etarad));
  e = 0.103458 - (0.004099*cos(etarad)) - (0.000167*cos(zetarad + etarad)) + (0.000235*cos(zetarad - etarad)) +
      (0.02303*cos(zetarad)) - (0.00212*cos(2*zetarad)) + (0.000151*cos(3*zetarad)) + (0.00013*cos(phirad));
  p = w_ + (0.15648*sin(chirad)) - (0.4457*sin(etarad)) - (0.2657*sin(zetarad + etarad)) -
      (0.3573*sin(zetarad - etarad)) - (12.872*sin(zetarad)) + (1.668*sin(2*zetarad)) -
      (0.2419*sin(3*zetarad)) - (0.07*sin(phirad));
  lambdadash = CAACoordinateTransformation::MapTo0To360Range(177.047 + (16.91993829*t6) + (0.15648*sin(chirad)) + (9.142*sin(etarad)) +
               (0.007*sin(2*etarad)) - (0.014*sin(3*etarad)) + (0.2275*sin(zetarad + etarad)) +
               (0.2112*sin(zetarad - etarad)) - (0.26*sin(zetarad)) - (0.0098*sin(2*zetarad)) -
               (0.013*sin(as)) + (0.017*sin(bs)) - (0.0303*sin(phirad)));
  i = 27.3347 + (0.643486*cos(chirad)) + (0.315*cos(W3rad)) + (0.018*cos(theta)) - (0.018*cos(cs));
  omega = 168.6812 + (1.40136*cos(chirad)) + (0.68599*sin(W3rad)) - (0.0392*sin(cs)) + (0.0366*sin(thetadash));
  double lambda7{0};
  double gamma7{0};
  double omega7{0};
  double r7{0};
  HelperSubroutine(e, lambdadash, p, a, omega, i, c1, s1, r7, lambda7, gamma7, omega7);

  //Satellite 8
  L = CAACoordinateTransformation::MapTo0To360Range(261.1582 + (22.57697855*t4));
  const double w_dash{91.796 + (0.562*t7)};
  psi = 4.367 - (0.195*t7);
  const double psirad{CAACoordinateTransformation::DegreesToRadians(psi)};
  theta = 146.819 - (3.198*t7);
  phi = 60.470 + (1.521*t7);
  phirad = CAACoordinateTransformation::DegreesToRadians(phi);
  const double PHI{205.055 - (2.091*t7)};
  edash = 0.028298 + (0.001156*t11);
  const double w_0{352.91 + (11.71*t11)};
  const double mu{CAACoordinateTransformation::MapTo0To360Range(76.3852 + (4.53795125*t10))};
  idash = 18.4602 - (0.9518*t11) - (0.072*t112) + (0.0054*t113);
  idashrad = CAACoordinateTransformation::DegreesToRadians(idash);
  omegadash = 143.198 - (3.919*t11) + (0.116*t112) + (0.008*t113);
  const double l{CAACoordinateTransformation::DegreesToRadians(mu - w_0)};
  g = CAACoordinateTransformation::DegreesToRadians(w_0 - omegadash - psi);
  const double g1{CAACoordinateTransformation::DegreesToRadians(w_0 - omegadash - phi)};
  const double ls{CAACoordinateTransformation::DegreesToRadians(W5 - w_dash)};
  const double gs{CAACoordinateTransformation::DegreesToRadians(w_dash - theta)};
  const double lt{CAACoordinateTransformation::DegreesToRadians(L - W4)};
  const double gt{CAACoordinateTransformation::DegreesToRadians(W4 - PHI)};
  const double u1{2*(l + g - ls - gs)};
  const double u2{l + g1 - lt - gt};
  const double u3{l + 2*(g - ls - gs)};
  const double u4{lt + gt - g1};
  const double u5{2*(ls + gs)};
  a = 58.935028 + (0.004638*cos(u1)) + (0.058222*cos(u2));
  e = edash - (0.0014097*cos(g1 - gt)) + (0.0003733*cos(u5 - (2*g))) +
      (0.0001180*cos(u3)) + (0.0002408*cos(l)) +
      (0.0002849*cos(l + u2)) + (0.0006190*cos(u4));
  double w = (0.08077*sin(g1 - gt)) + (0.02139*sin(u5 - (2*g))) - (0.00676*sin(u3)) +
             (0.01380*sin(l)) + (0.01632*sin(l + u2)) + (0.03547*sin(u4));
  p = w_0 + (w/edash);
  lambdadash = mu - (0.04299*sin(u2)) - (0.00789*sin(u1)) - (0.06312*sin(ls)) -
               (0.00295*sin(2*ls)) - (0.02231*sin(u5)) + (0.00650*sin(u5 + psirad));
  i = idash + (0.04204*cos(u5 + psirad)) + (0.00235*cos(l + g1 + lt + gt + phirad)) +
      (0.00360*cos(u2 + phirad));
  const double wdash{(0.04204*sin(u5 + psirad)) + (0.00235*sin(l + g1 + lt + gt + phirad)) +
                     (0.00358*sin(u2 + phirad))};
  omega = omegadash + (wdash/sin(idashrad));
  double lambda8{0};
  double gamma8{0};
  double omega8{0};
  double r8{0};
  HelperSubroutine(e, lambdadash, p, a, omega, i, c1, s1, r8, lambda8, gamma8, omega8);


  u = CAACoordinateTransformation::DegreesToRadians(lambda1 - omega1);
  double cosu{cos(u)};
  double sinu{sin(u)};
  w = CAACoordinateTransformation::DegreesToRadians(omega1 - 168.8112);
  double sinw{sin(w)};
  double cosw{cos(w)};
  constexpr double gamma1rad{CAACoordinateTransformation::DegreesToRadians(gamma1)};
  const double cosgamma1rad{cos(gamma1rad)};
  const double X1{r1*((cosu*cosw) - (sinu*cosgamma1rad*sinw))};
  const double Y1{r1*((sinu*cosw*cosgamma1rad) + (cosu*sinw))};
  const double Z1{r1*sinu*sin(gamma1rad)};

  u = CAACoordinateTransformation::DegreesToRadians(lambda2 - omega2);
  cosu = cos(u);
  sinu = sin(u);
  w = CAACoordinateTransformation::DegreesToRadians(omega2 - 168.8112);
  sinw = sin(w);
  cosw = cos(w);
  constexpr double gamma2rad{CAACoordinateTransformation::DegreesToRadians(gamma2)};
  const double cosgamma2rad{cos(gamma2rad)};
  const double X2{r2*((cosu*cosw) - (sinu*cosgamma2rad*sinw))};
  const double Y2{r2*((sinu*cosw*cosgamma2rad) + (cosu*sinw))};
  const double Z2{r2*sinu*sin(gamma2rad)};

  u = CAACoordinateTransformation::DegreesToRadians(lambda3 - omega3);
  cosu = cos(u);
  sinu = sin(u);
  w = CAACoordinateTransformation::DegreesToRadians(omega3 - 168.8112);
  sinw = sin(w);
  cosw = cos(w);
  constexpr double gamma3rad{CAACoordinateTransformation::DegreesToRadians(gamma3)};
  const double cosgamma3rad{cos(gamma3rad)};
  const double X3{r3*((cosu*cosw) - (sinu*cosgamma3rad*sinw))};
  const double Y3{r3*((sinu*cosw*cosgamma3rad) + (cosu*sinw))};
  const double Z3{r3*sinu*sin(gamma3rad)};

  u = CAACoordinateTransformation::DegreesToRadians(lambda4 - omega4);
  cosu = cos(u);
  sinu = sin(u);
  w = CAACoordinateTransformation::DegreesToRadians(omega4 - 168.8112);
  sinw = sin(w);
  cosw = cos(w);
  constexpr double gamma4rad{CAACoordinateTransformation::DegreesToRadians(gamma4)};
  const double cosgamma4rad{cos(gamma4rad)};
  const double X4{r4*((cosu*cosw) - (sinu*cosgamma4rad*sinw))};
  const double Y4{r4*((sinu*cosw*cosgamma4rad) + (cosu*sinw))};
  const double Z4{r4*sinu*sin(gamma4rad)};

  u = CAACoordinateTransformation::DegreesToRadians(lambda5 - omega5);
  cosu = cos(u);
  sinu = sin(u);
  w = CAACoordinateTransformation::DegreesToRadians(omega5 - 168.8112);
  sinw = sin(w);
  cosw = cos(w);
  const double gamma5rad{CAACoordinateTransformation::DegreesToRadians(gamma5)};
  const double cosgamma5rad{cos(gamma5rad)};
  const double X5{r5*((cosu*cosw) - (sinu*cosgamma5rad*sinw))};
  const double Y5{r5*((sinu*cosw*cosgamma5rad) + (cosu*sinw))};
  const double Z5{r5*sinu*sin(gamma5rad)};

  u = CAACoordinateTransformation::DegreesToRadians(lambda6 - omega6);
  cosu = cos(u);
  sinu = sin(u);
  w = CAACoordinateTransformation::DegreesToRadians(omega6 - 168.8112);
  sinw = sin(w);
  cosw = cos(w);
  const double gamma6rad{CAACoordinateTransformation::DegreesToRadians(gamma6)};
  const double cosgamma6rad{cos(gamma6rad)};
  const double X6{r6*((cosu*cosw) - (sinu*cosgamma6rad*sinw))};
  const double Y6{r6*((sinu*cosw*cosgamma6rad) + (cosu*sinw))};
  const double Z6{r6*sinu*sin(gamma6rad)};

  u = CAACoordinateTransformation::DegreesToRadians(lambda7 - omega7);
  cosu = cos(u);
  sinu = sin(u);
  w = CAACoordinateTransformation::DegreesToRadians(omega7 - 168.8112);
  sinw = sin(w);
  cosw = cos(w);
  const double gamma7rad{CAACoordinateTransformation::DegreesToRadians(gamma7)};
  const double cosgamma7rad{cos(gamma7rad)};
  const double X7{r7*((cosu*cosw) - (sinu*cosgamma7rad*sinw))};
  const double Y7{r7*((sinu*cosw*cosgamma7rad) + (cosu*sinw))};
  const double Z7{r7*sinu*sin(gamma7rad)};

  u = CAACoordinateTransformation::DegreesToRadians(lambda8 - omega8);
  cosu = cos(u);
  sinu = sin(u);
  w = CAACoordinateTransformation::DegreesToRadians(omega8 - 168.8112);
  sinw = sin(w);
  cosw = cos(w);
  const double gamma8rad{CAACoordinateTransformation::DegreesToRadians(gamma8)};
  const double cosgamma8rad{cos(gamma8rad)};
  const double X8{r8*((cosu*cosw) - (sinu*cosgamma8rad*sinw))};
  const double Y8{r8*((sinu*cosw*cosgamma8rad) + (cosu*sinw))};
  const double Z8{r8*sinu*sin(gamma8rad)};

  constexpr double X9{0};
  constexpr double Y9{0};
  constexpr double Z9{1};

  //Now do the rotations, first for the fictitious 9th satellite, so that we can calculate D
  double A4{0};
  double B4{0};
  double C4{0};
  Rotations(X9, Y9, Z9, c1, s1, c2, s2, lambda0rad, beta0rad, A4, B4, C4);
  const double D{atan2(A4, C4)};
  const double cosD{cos(D)};
  const double sinD{sin(D)};

  //Now calculate the values for satellite 1
  Rotations(X1, Y1, Z1, c1, s1, c2, s2, lambda0rad, beta0rad, A4, B4, C4);
  details.Satellite1.TrueRectangularCoordinates.X = (A4*cosD) - (C4*sinD);
  details.Satellite1.TrueRectangularCoordinates.Y = (A4*sinD) + (C4*cosD);
  details.Satellite1.TrueRectangularCoordinates.Z = B4;

  //Now calculate the values for satellite 2
  Rotations(X2, Y2, Z2, c1, s1, c2, s2, lambda0rad, beta0rad, A4, B4, C4);
  details.Satellite2.TrueRectangularCoordinates.X = (A4*cosD) - (C4*sinD);
  details.Satellite2.TrueRectangularCoordinates.Y = (A4*sinD) + (C4*cosD);
  details.Satellite2.TrueRectangularCoordinates.Z = B4;

  //Now calculate the values for satellite 3
  Rotations(X3, Y3, Z3, c1, s1, c2, s2, lambda0rad, beta0rad, A4, B4, C4);
  details.Satellite3.TrueRectangularCoordinates.X = (A4*cosD) - (C4*sinD);
  details.Satellite3.TrueRectangularCoordinates.Y = (A4*sinD) + (C4*cosD);
  details.Satellite3.TrueRectangularCoordinates.Z = B4;

  //Now calculate the values for satellite 4
  Rotations(X4, Y4, Z4, c1, s1, c2, s2, lambda0rad, beta0rad, A4, B4, C4);
  details.Satellite4.TrueRectangularCoordinates.X = (A4*cosD) - (C4*sinD);
  details.Satellite4.TrueRectangularCoordinates.Y = (A4*sinD) + (C4*cosD);
  details.Satellite4.TrueRectangularCoordinates.Z = B4;

  //Now calculate the values for satellite 5
  Rotations(X5, Y5, Z5, c1, s1, c2, s2, lambda0rad, beta0rad, A4, B4, C4);
  details.Satellite5.TrueRectangularCoordinates.X = (A4*cosD) - (C4*sinD);
  details.Satellite5.TrueRectangularCoordinates.Y = (A4*sinD) + (C4*cosD);
  details.Satellite5.TrueRectangularCoordinates.Z = B4;

  //Now calculate the values for satellite 6
  Rotations(X6, Y6, Z6, c1, s1, c2, s2, lambda0rad, beta0rad, A4, B4, C4);
  details.Satellite6.TrueRectangularCoordinates.X = (A4*cosD) - (C4*sinD);
  details.Satellite6.TrueRectangularCoordinates.Y = (A4*sinD) + (C4*cosD);
  details.Satellite6.TrueRectangularCoordinates.Z = B4;

  //Now calculate the values for satellite 7
  Rotations(X7, Y7, Z7, c1, s1, c2, s2, lambda0rad, beta0rad, A4, B4, C4);
  details.Satellite7.TrueRectangularCoordinates.X = (A4*cosD) - (C4*sinD);
  details.Satellite7.TrueRectangularCoordinates.Y = (A4*sinD) + (C4*cosD);
  details.Satellite7.TrueRectangularCoordinates.Z = B4;

  //Now calculate the values for satellite 8
  Rotations(X8, Y8, Z8, c1, s1, c2, s2, lambda0rad, beta0rad, A4, B4, C4);
  details.Satellite8.TrueRectangularCoordinates.X = (A4*cosD) - (C4*sinD);
  details.Satellite8.TrueRectangularCoordinates.Y = (A4*sinD) + (C4*cosD);
  details.Satellite8.TrueRectangularCoordinates.Z = B4;


  //apply the differential light-time correction
  details.Satellite1.ApparentRectangularCoordinates.X = details.Satellite1.TrueRectangularCoordinates.X + fabs(details.Satellite1.TrueRectangularCoordinates.Z)/20947*sqrt(1 - (details.Satellite1.TrueRectangularCoordinates.X/r1)*(details.Satellite1.TrueRectangularCoordinates.X/r1));
  details.Satellite1.ApparentRectangularCoordinates.Y = details.Satellite1.TrueRectangularCoordinates.Y;
  details.Satellite1.ApparentRectangularCoordinates.Z = details.Satellite1.TrueRectangularCoordinates.Z;

  details.Satellite2.ApparentRectangularCoordinates.X = details.Satellite2.TrueRectangularCoordinates.X + fabs(details.Satellite2.TrueRectangularCoordinates.Z)/23715*sqrt(1 - (details.Satellite2.TrueRectangularCoordinates.X/r2)*(details.Satellite2.TrueRectangularCoordinates.X/r2));
  details.Satellite2.ApparentRectangularCoordinates.Y = details.Satellite2.TrueRectangularCoordinates.Y;
  details.Satellite2.ApparentRectangularCoordinates.Z = details.Satellite2.TrueRectangularCoordinates.Z;

  details.Satellite3.ApparentRectangularCoordinates.X = details.Satellite3.TrueRectangularCoordinates.X + fabs(details.Satellite3.TrueRectangularCoordinates.Z)/26382*sqrt(1 - (details.Satellite3.TrueRectangularCoordinates.X/r3)*(details.Satellite3.TrueRectangularCoordinates.X/r3));
  details.Satellite3.ApparentRectangularCoordinates.Y = details.Satellite3.TrueRectangularCoordinates.Y;
  details.Satellite3.ApparentRectangularCoordinates.Z = details.Satellite3.TrueRectangularCoordinates.Z;

  details.Satellite4.ApparentRectangularCoordinates.X = details.Satellite4.TrueRectangularCoordinates.X + fabs(details.Satellite4.TrueRectangularCoordinates.Z)/29876*sqrt(1 - (details.Satellite4.TrueRectangularCoordinates.X/r4)*(details.Satellite4.TrueRectangularCoordinates.X/r4));
  details.Satellite4.ApparentRectangularCoordinates.Y = details.Satellite4.TrueRectangularCoordinates.Y;
  details.Satellite4.ApparentRectangularCoordinates.Z = details.Satellite4.TrueRectangularCoordinates.Z;

  details.Satellite5.ApparentRectangularCoordinates.X = details.Satellite5.TrueRectangularCoordinates.X + fabs(details.Satellite5.TrueRectangularCoordinates.Z)/35313*sqrt(1 - (details.Satellite5.TrueRectangularCoordinates.X/r5)*(details.Satellite5.TrueRectangularCoordinates.X/r5));
  details.Satellite5.ApparentRectangularCoordinates.Y = details.Satellite5.TrueRectangularCoordinates.Y;
  details.Satellite5.ApparentRectangularCoordinates.Z = details.Satellite5.TrueRectangularCoordinates.Z;

  details.Satellite6.ApparentRectangularCoordinates.X = details.Satellite6.TrueRectangularCoordinates.X + fabs(details.Satellite6.TrueRectangularCoordinates.Z)/53800*sqrt(1 - (details.Satellite6.TrueRectangularCoordinates.X/r6)*(details.Satellite6.TrueRectangularCoordinates.X/r6));
  details.Satellite6.ApparentRectangularCoordinates.Y = details.Satellite6.TrueRectangularCoordinates.Y;
  details.Satellite6.ApparentRectangularCoordinates.Z = details.Satellite6.TrueRectangularCoordinates.Z;

  details.Satellite7.ApparentRectangularCoordinates.X = details.Satellite7.TrueRectangularCoordinates.X + fabs(details.Satellite7.TrueRectangularCoordinates.Z)/59222*sqrt(1 - (details.Satellite7.TrueRectangularCoordinates.X/r7)*(details.Satellite7.TrueRectangularCoordinates.X/r7));
  details.Satellite7.ApparentRectangularCoordinates.Y = details.Satellite7.TrueRectangularCoordinates.Y;
  details.Satellite7.ApparentRectangularCoordinates.Z = details.Satellite7.TrueRectangularCoordinates.Z;

  details.Satellite8.ApparentRectangularCoordinates.X = details.Satellite8.TrueRectangularCoordinates.X + fabs(details.Satellite8.TrueRectangularCoordinates.Z)/91820*sqrt(1 - (details.Satellite8.TrueRectangularCoordinates.X/r8)*(details.Satellite8.TrueRectangularCoordinates.X/r8));
  details.Satellite8.ApparentRectangularCoordinates.Y = details.Satellite8.TrueRectangularCoordinates.Y;
  details.Satellite8.ApparentRectangularCoordinates.Z = details.Satellite8.TrueRectangularCoordinates.Z;


  //apply the perspective effect correction
  double W{DELTA/(DELTA + (details.Satellite1.TrueRectangularCoordinates.Z/2475))};
  details.Satellite1.ApparentRectangularCoordinates.X *= W;
  details.Satellite1.ApparentRectangularCoordinates.Y *= W;

  W = DELTA/(DELTA + (details.Satellite2.TrueRectangularCoordinates.Z/2475));
  details.Satellite2.ApparentRectangularCoordinates.X *= W;
  details.Satellite2.ApparentRectangularCoordinates.Y *= W;

  W = DELTA/(DELTA + (details.Satellite3.TrueRectangularCoordinates.Z/2475));
  details.Satellite3.ApparentRectangularCoordinates.X *= W;
  details.Satellite3.ApparentRectangularCoordinates.Y *= W;

  W = DELTA/(DELTA + (details.Satellite4.TrueRectangularCoordinates.Z/2475));
  details.Satellite4.ApparentRectangularCoordinates.X *= W;
  details.Satellite4.ApparentRectangularCoordinates.Y *= W;

  W = DELTA/(DELTA + (details.Satellite5.TrueRectangularCoordinates.Z/2475));
  details.Satellite5.ApparentRectangularCoordinates.X *= W;
  details.Satellite5.ApparentRectangularCoordinates.Y *= W;

  W = DELTA/(DELTA + (details.Satellite6.TrueRectangularCoordinates.Z/2475));
  details.Satellite6.ApparentRectangularCoordinates.X *= W;
  details.Satellite6.ApparentRectangularCoordinates.Y *= W;

  W = DELTA/(DELTA + (details.Satellite7.TrueRectangularCoordinates.Z/2475));
  details.Satellite7.ApparentRectangularCoordinates.X *= W;
  details.Satellite7.ApparentRectangularCoordinates.Y *= W;

  W = DELTA/(DELTA + (details.Satellite8.TrueRectangularCoordinates.Z/2475));
  details.Satellite8.ApparentRectangularCoordinates.X *= W;
  details.Satellite8.ApparentRectangularCoordinates.Y *= W;

  return details;
}

CAASaturnMoonsDetails CAASaturnMoons::Calculate(double JD, bool bHighPrecision) noexcept
{
  //Calculate the position of the Sun
  const double sunlong{CAASun::GeometricEclipticLongitude(JD, bHighPrecision)};
  const double sunlongrad{CAACoordinateTransformation::DegreesToRadians(sunlong)};
  const double beta{CAASun::GeometricEclipticLatitude(JD, bHighPrecision)};
  const double betarad{CAACoordinateTransformation::DegreesToRadians(beta)};
  const double R{CAAEarth::RadiusVector(JD, bHighPrecision)};

  //Calculate the the light travel time from Saturn to the Earth
  double DELTA{9};
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
    const double l{CAASaturn::EclipticLongitude(JD1, bHighPrecision)};
    const double lrad{CAACoordinateTransformation::DegreesToRadians(l)};
    const double b{CAASaturn::EclipticLatitude(JD1, bHighPrecision)};
    const double brad{CAACoordinateTransformation::DegreesToRadians(b)};
    const double cosbrad{cos(brad)};
    const double r{CAASaturn::RadiusVector(JD1, bHighPrecision)};

    x = (r*cosbrad*cos(lrad)) + (R*cos(sunlongrad));
    y = (r*cosbrad*sin(lrad)) + (R*sin(sunlongrad));
    z = (r*sin(brad)) + (R*sin(betarad));
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

  //Calculate the details as seen from the earth
  CAASaturnMoonsDetails details1{CalculateHelper(JD, sunlongrad, betarad, R, bHighPrecision)};
  FillInPhenomenaDetails(details1.Satellite1);
  FillInPhenomenaDetails(details1.Satellite2);
  FillInPhenomenaDetails(details1.Satellite3);
  FillInPhenomenaDetails(details1.Satellite4);
  FillInPhenomenaDetails(details1.Satellite5);
  FillInPhenomenaDetails(details1.Satellite6);
  FillInPhenomenaDetails(details1.Satellite7);
  FillInPhenomenaDetails(details1.Satellite8);

  //Calculate the the light travel time from Saturn to the Sun
  JD1 = JD - EarthLightTravelTime;
  const double l{CAASaturn::EclipticLongitude(JD1, bHighPrecision)};
  const double lrad{CAACoordinateTransformation::DegreesToRadians(l)};
  const double b{CAASaturn::EclipticLatitude(JD1, bHighPrecision)};
  const double brad{CAACoordinateTransformation::DegreesToRadians(b)};
  const double cosbrad{cos(brad)};
  const double r{CAASaturn::RadiusVector(JD1, bHighPrecision)};
  x = r*cosbrad*cos(lrad);
  y = r*cosbrad*sin(lrad);
  z = r*sin(brad);
  DELTA = sqrt((x*x) + (y*y) + (z*z));
  const double SunLightTravelTime = CAAElliptical::DistanceToLightTime(DELTA);

  //Calculate the details as seen from the Sun
  CAASaturnMoonsDetails details2{CalculateHelper(JD + SunLightTravelTime - EarthLightTravelTime, sunlongrad, betarad, 0, bHighPrecision)};
  FillInPhenomenaDetails(details2.Satellite1);
  FillInPhenomenaDetails(details2.Satellite2);
  FillInPhenomenaDetails(details2.Satellite3);
  FillInPhenomenaDetails(details2.Satellite4);
  FillInPhenomenaDetails(details2.Satellite5);
  FillInPhenomenaDetails(details2.Satellite6);
  FillInPhenomenaDetails(details2.Satellite7);
  FillInPhenomenaDetails(details2.Satellite8);

  //Finally transfer the required values from details2 to details1
  details1.Satellite1.bInEclipse = details2.Satellite1.bInOccultation;
  details1.Satellite2.bInEclipse = details2.Satellite2.bInOccultation;
  details1.Satellite3.bInEclipse = details2.Satellite3.bInOccultation;
  details1.Satellite4.bInEclipse = details2.Satellite4.bInOccultation;
  details1.Satellite5.bInEclipse = details2.Satellite5.bInOccultation;
  details1.Satellite6.bInEclipse = details2.Satellite6.bInOccultation;
  details1.Satellite7.bInEclipse = details2.Satellite7.bInOccultation;
  details1.Satellite8.bInEclipse = details2.Satellite8.bInOccultation;
  details1.Satellite1.bInShadowTransit = details2.Satellite1.bInTransit;
  details1.Satellite2.bInShadowTransit = details2.Satellite2.bInTransit;
  details1.Satellite3.bInShadowTransit = details2.Satellite3.bInTransit;
  details1.Satellite4.bInShadowTransit = details2.Satellite4.bInTransit;
  details1.Satellite5.bInShadowTransit = details2.Satellite5.bInTransit;
  details1.Satellite6.bInShadowTransit = details2.Satellite6.bInTransit;
  details1.Satellite7.bInShadowTransit = details2.Satellite7.bInTransit;
  details1.Satellite8.bInShadowTransit = details2.Satellite8.bInTransit;

  return details1;
}

void CAASaturnMoons::Rotations(double X, double Y, double Z, double c1, double s1, double c2, double s2, double lambda0, double beta0, double& A4, double& B4, double& C4) noexcept
{
  //Rotation towards the plane of the ecliptic
  const double A1{X};
  const double B1{(c1*Y) - (s1*Z)};
  const double C1{(s1*Y) + (c1*Z)};

  //Rotation towards the vernal equinox
  const double A2{(c2*A1) - (s2*B1)};
  const double B2{(s2*A1) + (c2*B1)};
  const double C2{C1};

  const double sinlambda0{sin(lambda0)};
  const double coslambda0{cos(lambda0)};
  const double A3{(A2*sinlambda0) - (B2*coslambda0)};
  const double B3{(A2*coslambda0) + (B2*sinlambda0)};
  const double C3{C2};

  const double cosbeta0{cos(beta0)};
  const double sinbeta0{sin(beta0)};
  A4 = A3;
  B4 = (B3*cosbeta0) + (C3*sinbeta0);
  C4 = (C3*cosbeta0) - (B3*sinbeta0);
}

void CAASaturnMoons::FillInPhenomenaDetails(CAASaturnMoonDetail& detail) noexcept
{
  const double Y1{1.108601*detail.ApparentRectangularCoordinates.Y};
  const double r{(Y1*Y1) + (detail.ApparentRectangularCoordinates.X*detail.ApparentRectangularCoordinates.X)};

  if (r < 1)
  {
    if (detail.ApparentRectangularCoordinates.Z < 0)
    {
      //Satellite nearer to Earth than Saturn, so it must be a transit not an occultation
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
