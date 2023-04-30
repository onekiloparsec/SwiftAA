/*
Module : AAMoonMaxDeclinations.cpp
Purpose: Implementation for the algorithms which obtain the dates and values for maximum declination of the Moon
Created: PJN / 13-01-2004
History: PJN / 18-08-2019 1. Fixed some further compiler warnings when using VC 2019 Preview v16.3.0 Preview 2.0
         PJN / 27-06-2022 1. Updated all the code in AAMoonMaxDeclinations.cpp to use C++ uniform initialization
                          for all variable declarations.

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
#include "AAMoonMaxDeclinations.h"
#include "AACoordinateTransformation.h"
#include <cmath>


//////////////////// Implementation ///////////////////////////////////////////

double CAAMoonMaxDeclinations::TrueGreatestDeclination(double k, bool bNortherly) noexcept
{
  //convert from K to T
  const double T{k/1336.86};
  const double T2{T*T};
  const double T3{T2*T};

  double D{bNortherly ? 152.2029 : 345.6676};
  D = CAACoordinateTransformation::MapTo0To360Range(D + (333.0705546*k) - (0.0004214*T2) + (0.00000011*T3));
  double M{bNortherly ? 14.8591 : 1.3951};
  M = CAACoordinateTransformation::MapTo0To360Range(M + (26.9281592*k) - (0.0000355*T2) - (0.00000010*T3));
  double Mdash{bNortherly ? 4.6881 : 186.2100};
  Mdash = CAACoordinateTransformation::MapTo0To360Range(Mdash + (356.9562794*k) + (0.0103066*T2) + (0.00001251*T3));
  double F{bNortherly ? 325.8867 : 145.1633};
  F = CAACoordinateTransformation::MapTo0To360Range(F + (1.4467807*k) - (0.0020690*T2) - (0.00000215*T3));
  const double E{1 - (0.002516*T) - (0.0000074*T2)};

  //convert to radians
  D = CAACoordinateTransformation::DegreesToRadians(D);
  M = CAACoordinateTransformation::DegreesToRadians(M);
  Mdash = CAACoordinateTransformation::DegreesToRadians(Mdash);
  F = CAACoordinateTransformation::DegreesToRadians(F);

  const double twoD{2*D};
  const double twoF{2*F};
  const double threeF{3*F};
  const double twoMdash{2*Mdash};
  const double threeMdash{3*Mdash};

  double DeltaJD{0};
  if (bNortherly)
  {
    DeltaJD = (0.8975*cos(F)) +
              (-0.4726*sin(Mdash)) +
              (-0.1030*sin(twoF)) +
              (-0.0976*sin(twoD - Mdash)) +
              (-0.0462*cos(Mdash - F)) +
              (-0.0461*cos(Mdash + F)) +
              (-0.0438*sin(twoD)) +
              ( 0.0162*E*sin(M)) +
              (-0.0157*cos(threeF)) +
              ( 0.0145*sin(Mdash + twoF)) +
              ( 0.0136*cos(twoD - F)) +
              (-0.0095*cos(twoD - Mdash - F)) +
              (-0.0091*cos(twoD - Mdash + F)) +
              (-0.0089*cos(twoD + F)) +
              ( 0.0075*sin(twoMdash)) +
              (-0.0068*sin(Mdash - twoF)) +
              ( 0.0061*cos(twoMdash - F)) +
              (-0.0047*sin(Mdash + threeF)) +
              (-0.0043*E*sin(twoD - M - Mdash)) +
              (-0.0040*cos(Mdash - twoF)) +
              (-0.0037*sin(twoD - twoMdash)) +
              ( 0.0031*sin(F)) +
              ( 0.0030*sin(twoD + Mdash)) +
              (-0.0029*cos(Mdash + twoF)) +
              (-0.0029*E*sin(twoD - M)) +
              (-0.0027*sin(Mdash + F)) +
              ( 0.0024*E*sin(M - Mdash)) +
              (-0.0021*sin(Mdash - threeF)) +
              ( 0.0019*sin(twoMdash + F)) +
              ( 0.0018*cos(twoD - twoMdash - F)) +
              ( 0.0018*sin(threeF)) +
              ( 0.0017*cos(Mdash + threeF)) +
              ( 0.0017*cos(twoMdash)) +
              (-0.0014*cos(twoD - Mdash)) +
              ( 0.0013*cos(twoD + Mdash + F)) +
              ( 0.0013*cos(Mdash)) +
              ( 0.0012*sin(threeMdash + F)) +
              ( 0.0011*sin(twoD - Mdash + F)) +
              (-0.0011*cos(twoD - twoMdash)) +
              ( 0.0010*cos(D + F)) +
              ( 0.0010*E*sin(M + Mdash)) +
              (-0.0009*sin(twoD - twoF)) +
              ( 0.0007*cos(twoMdash + F)) +
              (-0.0007*cos(threeMdash + F));
  }
  else
  {
    DeltaJD = (-0.8975*cos(F)) +
              (-0.4726*sin(Mdash)) +
              (-0.1030*sin(twoF)) +
              (-0.0976*sin(twoD - Mdash)) +
              ( 0.0541*cos(Mdash - F)) +
              ( 0.0516*cos(Mdash + F)) +
              (-0.0438*sin(twoD)) +
              ( 0.0112*E*sin(M)) +
              ( 0.0157*cos(threeF)) +
              ( 0.0023*sin(Mdash + twoF)) +
              (-0.0136*cos(twoD - F)) +
              ( 0.0110*cos(twoD - Mdash - F)) +
              ( 0.0091*cos(twoD - Mdash + F)) +
              ( 0.0089*cos(twoD + F)) +
              ( 0.0075*sin(twoMdash)) +
              (-0.0030*sin(Mdash - twoF)) +
              (-0.0061*cos(twoMdash - F)) +
              (-0.0047*sin(Mdash + threeF)) +
              (-0.0043*E*sin(twoD - M - Mdash)) +
              ( 0.0040*cos(Mdash - twoF)) +
              (-0.0037*sin(twoD - twoMdash)) +
              (-0.0031*sin(F)) +
              ( 0.0030*sin(twoD + Mdash)) +
              ( 0.0029*cos(Mdash + twoF)) +
              (-0.0029*E*sin(twoD - M)) +
              (-0.0027*sin(Mdash + F)) +
              ( 0.0024*E*sin(M - Mdash)) +
              (-0.0021*sin(Mdash - threeF)) +
              (-0.0019*sin(twoMdash + F)) +
              (-0.0006*cos(twoD - twoMdash - F)) +
              (-0.0018*sin(threeF)) +
              (-0.0017*cos(Mdash + threeF)) +
              ( 0.0017*cos(twoMdash)) +
              ( 0.0014*cos(twoD - Mdash)) +
              (-0.0013*cos(twoD + Mdash + F)) +
              (-0.0013*cos(Mdash)) +
              ( 0.0012*sin(threeMdash + F)) +
              ( 0.0011*sin(twoD - Mdash + F)) +
              ( 0.0011*cos(twoD - twoMdash)) +
              ( 0.0010*cos(D + F)) +
              ( 0.0010*E*sin(M + Mdash)) +
              (-0.0009*sin(twoD - twoF)) +
              (-0.0007*cos(twoMdash + F)) +
              (-0.0007*cos(threeMdash + F));
  }

  return MeanGreatestDeclination(k, bNortherly) + DeltaJD;
}

double CAAMoonMaxDeclinations::TrueGreatestDeclinationValue(double k, bool bNortherly) noexcept
{
  //convert from K to T
  const double T{k/1336.86};
  const double T2{T*T};
  const double T3{T2*T};

  double D{bNortherly ? 152.2029 : 345.6676};
  D = CAACoordinateTransformation::MapTo0To360Range(D + (333.0705546*k) - (0.0004214*T2) + (0.00000011*T3));
  double M{bNortherly ? 14.8591 : 1.3951};
  M = CAACoordinateTransformation::MapTo0To360Range(M + (26.9281592*k) - (0.0000355*T2) - (0.00000010*T3));
  double Mdash{bNortherly ? 4.6881 : 186.2100};
  Mdash = CAACoordinateTransformation::MapTo0To360Range(Mdash + (356.9562794*k) + (0.0103066*T2) + (0.00001251*T3));
  double F{bNortherly ? 325.8867 : 145.1633};
  F = CAACoordinateTransformation::MapTo0To360Range(F + (1.4467807*k) - (0.0020690*T2) - (0.00000215*T3));
  const double E{1 - (0.002516*T) - (0.0000074*T2)};

  //convert to radians
  D = CAACoordinateTransformation::DegreesToRadians(D);
  M = CAACoordinateTransformation::DegreesToRadians(M);
  Mdash = CAACoordinateTransformation::DegreesToRadians(Mdash);
  F = CAACoordinateTransformation::DegreesToRadians(F);

  const double twoD{2*D};
  const double twoF{2*F};
  const double threeF{3*F};
  const double twoMdash{2*Mdash};
  const double threeMdash{3*Mdash};

  double DeltaValue{0};
  if (bNortherly)
  {
    DeltaValue = ( 5.1093*sin(F)) +
                 ( 0.2658*cos(twoF)) +
                 ( 0.1448*sin(twoD - F)) +
                 (-0.0322*sin(threeF)) +
                 ( 0.0133*cos(twoD - twoF)) +
                 ( 0.0125*cos(twoD)) +
                 (-0.0124*sin(Mdash - F)) +
                 (-0.0101*sin(Mdash + twoF)) +
                 ( 0.0097*cos(F)) +
                 (-0.0087*E*sin(twoD + M - F)) +
                 ( 0.0074*sin(Mdash + threeF)) +
                 ( 0.0067*sin(D + F)) +
                 ( 0.0063*sin(Mdash - twoF)) +
                 ( 0.0060*E*sin(twoD - M - F)) +
                 (-0.0057*sin(twoD - Mdash - F)) +
                 (-0.0056*cos(Mdash + F)) +
                 ( 0.0052*cos(Mdash + twoF)) +
                 ( 0.0041*cos(twoMdash + F)) +
                 (-0.0040*cos(Mdash - threeF)) +
                 ( 0.0038*cos(twoMdash - F)) +
                 (-0.0034*cos(Mdash - twoF)) +
                 (-0.0029*sin(twoMdash)) +
                 ( 0.0029*sin(threeMdash + F)) +
                 (-0.0028*E*cos(twoD + M - F)) +
                 (-0.0028*cos(Mdash - F)) +
                 (-0.0023*cos(threeF)) +
                 (-0.0021*sin(twoD + F)) +
                 ( 0.0019*cos(Mdash + threeF)) +
                 ( 0.0018*cos(D + F)) +
                 ( 0.0017*sin(twoMdash - F)) +
                 ( 0.0015*cos(threeMdash + F)) +
                 ( 0.0014*cos(twoD + twoMdash + F)) +
                 (-0.0012*sin(twoD - twoMdash - F)) +
                 (-0.0012*cos(twoMdash)) +
                 (-0.0010*cos(Mdash)) +
                 (-0.0010*sin(twoF)) +
                 ( 0.0006*sin(Mdash + F));
  }
  else
  {
    DeltaValue = (-5.1093*sin(F)) +
                 ( 0.2658*cos(twoF)) +
                 (-0.1448*sin(twoD - F)) +
                 ( 0.0322*sin(threeF)) +
                 ( 0.0133*cos(twoD - twoF)) +
                 ( 0.0125*cos(twoD)) +
                 (-0.0015*sin(Mdash - F)) +
                 ( 0.0101*sin(Mdash + twoF)) +
                 (-0.0097*cos(F)) +
                 ( 0.0087*E*sin(twoD + M - F)) +
                 ( 0.0074*sin(Mdash + threeF)) +
                 ( 0.0067*sin(D + F)) +
                 (-0.0063*sin(Mdash - twoF)) +
                 (-0.0060*E*sin(twoD - M - F)) +
                 ( 0.0057*sin(twoD - Mdash - F)) +
                 (-0.0056*cos(Mdash + F)) +
                 (-0.0052*cos(Mdash + twoF)) +
                 (-0.0041*cos(twoMdash + F)) +
                 (-0.0040*cos(Mdash - threeF)) +
                 (-0.0038*cos(twoMdash - F)) +
                 ( 0.0034*cos(Mdash - twoF)) +
                 (-0.0029*sin(twoMdash)) +
                 ( 0.0029*sin(threeMdash + F)) +
                 ( 0.0028*E*cos(twoD + M - F)) +
                 (-0.0028*cos(Mdash - F)) +
                 ( 0.0023*cos(threeF)) +
                 ( 0.0021*sin(twoD + F)) +
                 ( 0.0019*cos(Mdash + threeF)) +
                 ( 0.0018*cos(D + F)) +
                 (-0.0017*sin(twoMdash - F)) +
                 ( 0.0015*cos(threeMdash + F)) +
                 ( 0.0014*cos(twoD + twoMdash + F)) +
                 ( 0.0012*sin(twoD - twoMdash - F)) +
                 (-0.0012*cos(twoMdash)) +
                 ( 0.0010*cos(Mdash)) +
                 (-0.0010*sin(twoF)) +
                 ( 0.0037*sin(Mdash + F));
  }

  return MeanGreatestDeclinationValue(k) + DeltaValue;
}
