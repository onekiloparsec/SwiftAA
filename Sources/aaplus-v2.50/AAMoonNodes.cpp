/*
Module : AAMoonNodes.cpp
Purpose: Implementation for the algorithms which obtain the dates when the Moon passes thro its nodes
Created: PJN / 29-12-2003
History: PJN / 28-03-2016 1. Fixed two transcription errors in CAAMoonNodes::PassageThroNode. The first 
                          error was the calculation of the D4 local variable which represented 4D in 
                          Meeus's formulae while the second error was in the -E*0.0003*sin(2D - 2M) 
                          coefficient. With these two fixes the calculated time of Example 51.a from
                          Meeus's book is within 2 seconds of the value he reports. Thanks to Alejandro 
                          Krohn for prompting this bug fix.
         PJN / 18-08-2019 1. Fixed some further compiler warnings when using VC 2019 Preview v16.3.0 Preview 2.0
         PJN / 27-06-2022 1. Updated all the code in AAMoonNodes.cpp to use C++ uniform initialization
                          for all variable declarations.

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
#include "AAMoonNodes.h"
#include "AACoordinateTransformation.h"
#include <cmath>


//////////////////// Implementation ///////////////////////////////////////////

double CAAMoonNodes::PassageThroNode(double k) noexcept
{
  //convert from K to T
  const double T{k/1342.23};
  const double Tsquared{T*T};
  const double Tcubed{Tsquared*T};
  const double T4{Tcubed*T};

  double D{CAACoordinateTransformation::MapTo0To360Range(183.6380 + (331.73735682*k) + (0.0014852*Tsquared) + (0.00000209*Tcubed) - (0.000000010*T4))};
  double M{CAACoordinateTransformation::MapTo0To360Range(17.4006 + (26.82037250*k) + (0.0001186*Tsquared) + (0.00000006*Tcubed))};
  double Mdash{CAACoordinateTransformation::MapTo0To360Range(38.3776 + (355.52747313*k) + (0.0123499*Tsquared) + (0.000014627*Tcubed) - (0.000000069*T4))};
  double omega{CAACoordinateTransformation::MapTo0To360Range(123.9767 - (1.44098956*k) + (0.0020608*Tsquared) + (0.00000214*Tcubed) - (0.000000016*T4))};
  double V{CAACoordinateTransformation::MapTo0To360Range(299.75 + (132.85*T) - (0.009173*Tsquared))};
  double P{CAACoordinateTransformation::MapTo0To360Range(omega + 272.75 - (2.3*T))};
  const double E{1 - (0.002516*T) - (0.0000074*Tsquared)};

  //convert to radians
  D = CAACoordinateTransformation::DegreesToRadians(D);
  const double twoD{2*D};
  const double fourD{twoD*2};
  M = CAACoordinateTransformation::DegreesToRadians(M);
  Mdash = CAACoordinateTransformation::DegreesToRadians(Mdash);
  const double twoMdash{2*Mdash};
  omega = CAACoordinateTransformation::DegreesToRadians(omega);
  V = CAACoordinateTransformation::DegreesToRadians(V);
  P = CAACoordinateTransformation::DegreesToRadians(P);

  const double JD{2451565.1619 +
                  (27.212220817*k) +
                  (0.0002762*Tsquared) +
                  (0.000000021*Tcubed) -
                  (0.000000000088*T4)-
                  (0.4721*sin(Mdash)) -
                  (0.1649*sin(twoD)) -
                  (0.0868*sin(twoD - Mdash)) +
                  (0.0084*sin(twoD + Mdash)) -
                  (E*0.0083*sin(twoD - M)) -
                  (E*0.0039*sin(twoD - M - Mdash)) +
                  (0.0034*sin(twoMdash)) -
                  (0.0031*sin(twoD - twoMdash)) +
                  (E*0.0030*sin(twoD + M)) +
                  (E*0.0028*sin(M - Mdash)) +
                  (E*0.0026*sin(M)) +
                  (0.0025*sin(fourD)) +
                  (0.0024*sin(D)) +
                  (E*0.0022*sin(M + Mdash)) +
                  (0.0017*sin(omega)) +
                  (0.0014*sin(fourD - Mdash)) +
                  (E*0.0005*sin(twoD + M - Mdash)) +
                  (E*0.0004*sin(twoD - M + Mdash)) -
                  (E*0.0003*sin(twoD - 2*M)) +
                  (E*0.0003*sin(fourD - M)) +
                  (0.0003*sin(V)) +
                  (0.0003*sin(P))};

  return JD;
}
