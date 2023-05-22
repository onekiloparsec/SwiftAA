/*
Module : AAPlanetaryPhenomena2.h
Purpose: Implementation for the algorithms which obtain the dates of various planetary phenomena (revised version)
Created: PJN / 11-06-2020

Copyright (c) 2020 - 2023 by PJ Naughter (Web: www.naughter.com, Email: pjna@naughter.com)

All rights reserved.

Copyright / Usage Details:

You are allowed to include the source code in any product (commercial, shareware, freeware or otherwise) 
when your product is released in binary form. You are allowed to modify the source code in any way you want 
except you cannot modify the copyright details at the top of each module. If you want to distribute source 
code with your application, then you are only allowed to distribute versions released by the author. This is 
to maintain a single distribution point for the source code.

*/


//////////////////// Macros / Defines /////////////////////////////////////////

#if _MSC_VER > 1000
#pragma once
#endif //#if _MSC_VER > 1000

#ifndef __AAPLANETARYPHENOMENA2_H__
#define __AAPLANETARYPHENOMENA2_H__

#ifndef AAPLUS_EXT_CLASS
#define AAPLUS_EXT_CLASS
#endif //#ifndef AAPLUS_EXT_CLASS


//////////////////// Includes /////////////////////////////////////////////////

#include "AA2DCoordinate.h"
#include <vector>


//////////////////// Classes //////////////////////////////////////////////////

class AAPLUS_EXT_CLASS CAAPlanetaryPhenomenaDetails2
{
public:
//Enums
  enum class Type
  {
    NotDefined = 0,
    InferiorConjunctionInEclipticLongitude = 1,
    InferiorConjunctionInRA = 2,
    InferiorConjunctionInAngularDistance = 3,
    SuperiorConjunctionInEclipticLongitude = 4,
    SuperiorConjunctionInRA = 5,
    SuperiorConjunctionInAngularDistance = 6,
    GreatestWesternElongationInEclipticLongitude = 7,
    GreatestWesternElongationInRA = 8,
    GreatestWesternElongationInAngularDistance = 9,
    GreatestEasternElongationInEclipticLongitude = 10,
    GreatestEasternElongationInRA = 11,
    GreatestEasternElongationInAngularDistance = 12,
    OppositionInEclipticLongitude = 13,
    OppositionInRA = 14,
    OppositionInAngularDistance = 15,
    ConjunctionInEclipticLongitude = 16,
    ConjunctionInRA = 17,
    ConjunctionInAngularDistance = 18,
    Station1InEclipticLongitude = 19,
    Station1InRA = 20,
    Station2InEclipticLongitude = 21,
    Station2InRA = 22,
    WesternQuadratureInEclipticLongitude = 23,
    WesternQuadratureInRA = 24,
    WesternQuadratureInAngularDistance = 25,
    EasternQuadratureInEclipticLongitude = 26,
    EasternQuadratureInRA = 27,
    EasternQuadratureInAngularDistance = 28,
    MaximumDistance = 29,
    MinimumDistance = 30
  };

//Member variables
  Type type{Type::NotDefined}; //The type of the event which has occurred
  double JD{0}; //When the event occurred in TT
  double Value{0}; //The value associated with the event
};

class AAPLUS_EXT_CLASS CAAPlanetaryPhenomena2
{
public:
//Enums
  enum class Object
  {
    MERCURY,
    VENUS,
    MARS,
    JUPITER,
    SATURN,
    URANUS,
    NEPTUNE
  };

//Static methods
  static std::vector<CAAPlanetaryPhenomenaDetails2> Calculate(double StartJD, double EndJD, Object object, double StepInterval = 0.007, bool bHighPrecision = false);

protected:
  static void CorrectRAValuesForInterpolation(double& Alpha1, double& Alpha2, double& Alpha3) noexcept;
  static void CorrectLongitudeValuesForInterpolation(double& Long1, double& Long2, double& Long3) noexcept;
};


#endif //#ifndef __AAPLANETARYPHENOMENA2_H__
