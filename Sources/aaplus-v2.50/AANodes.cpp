/*
Module : AANodes.cpp
Purpose: Implementation for the algorithms which calculate passage through the nodes
Created: PJN / 29-12-2003
History: PJN / 18-08-2019 1. Fixed some further compiler warnings when using VC 2019 Preview v16.3.0 Preview 2.0
         PJN / 30-06-2022 1. Updated all the code in AANodes.cpp to use C++ uniform initialization for all
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
#include "AANodes.h"
#include "AACoordinateTransformation.h"
#include <cmath>


//////////////////// Implementation ///////////////////////////////////////////

CAANodeObjectDetails CAANodes::PassageThroAscendingNode(const CAAEllipticalObjectElements& elements) noexcept
{
  double v{CAACoordinateTransformation::MapTo0To360Range(-elements.w)};
  v = CAACoordinateTransformation::DegreesToRadians(v);
  const double E{atan(sqrt((1 - elements.e)/(1 + elements.e))*tan(v/2))*2};
  double M{E - (elements.e*sin(E))};
  M = CAACoordinateTransformation::RadiansToDegrees(M);
  const double n{CAAElliptical::MeanMotionFromSemiMajorAxis(elements.a)};

  CAANodeObjectDetails details;
  details.t = elements.T + (M/n);
  details.radius = elements.a*(1 - (elements.e*cos(E)));
  return details;
}

CAANodeObjectDetails CAANodes::PassageThroDescendingNode(const CAAEllipticalObjectElements& elements) noexcept
{
  double v{CAACoordinateTransformation::MapTo0To360Range(180 - elements.w)};
  v = CAACoordinateTransformation::DegreesToRadians(v);
  const double E{atan(sqrt((1 - elements.e)/(1 + elements.e))*tan(v/2))*2};
  double M{E - (elements.e*sin(E))};
  M = CAACoordinateTransformation::RadiansToDegrees(M);
  const double n{CAAElliptical::MeanMotionFromSemiMajorAxis(elements.a)};

  CAANodeObjectDetails details;
  details.t = elements.T + (M/n);
  details.radius = elements.a*(1 - (elements.e*cos(E)));
  return details;
}

CAANodeObjectDetails CAANodes::PassageThroAscendingNode(const CAAParabolicObjectElements& elements) noexcept
{
  double v{CAACoordinateTransformation::MapTo0To360Range(-elements.w)};
  v = CAACoordinateTransformation::DegreesToRadians(v);
  const double s{tan(v/2)};
  const double s2{s*s};

  CAANodeObjectDetails details;
  details.t = elements.T + (27.403895*((s2*s) + (3*s))*elements.q*sqrt(elements.q));
  details.radius = elements.q*(1 + s2);
  return details;
}

CAANodeObjectDetails CAANodes::PassageThroDescendingNode(const CAAParabolicObjectElements& elements) noexcept
{
  double v{CAACoordinateTransformation::MapTo0To360Range(180 - elements.w)};
  v = CAACoordinateTransformation::DegreesToRadians(v);
  const double s{tan(v/2)};
  const double s2{s*s};

  CAANodeObjectDetails details;
  details.t = elements.T + (27.403895*((s2*s) + (3*s))*elements.q*sqrt(elements.q));
  details.radius = elements.q*(1 + s2);
  return details;
}
