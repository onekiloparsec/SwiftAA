/*
Module : AAPlanetPerihelionAphelion2.h
Purpose: Implementation for the algorithms which obtain the dates of Perihelion and Aphelion of the planets (revised version)
Created: PJN / 01-06-2020

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

#ifndef __AAPLANETPERIHELIONAPHELION2_H__
#define __AAPLANETPERIHELIONAPHELION2_H__

#ifndef AAPLUS_EXT_CLASS
#define AAPLUS_EXT_CLASS
#endif //#ifndef AAPLUS_EXT_CLASS


//////////////////// Includes /////////////////////////////////////////////////

#include "AA2DCoordinate.h"
#include <vector>


//////////////////// Classes //////////////////////////////////////////////////

class AAPLUS_EXT_CLASS CAAPlanetPerihelionAphelionDetails2
{
public:
//Enums
  enum class Type
  {
    NotDefined = 0,
    Perihelion = 1,
    Aphelion = 2
  };

//Member variables
  Type type{Type::NotDefined}; //The type of the event which has occurred
  double JD{0}; //When the event occurred in TT
  double Value{0}; //The actual distance in AU
};

class AAPLUS_EXT_CLASS CAAPlanetPerihelionAphelion2
{
public:
//Enums
  enum class Object
  {
    MERCURY,
    VENUS,
    EARTH,
    MARS,
    JUPITER,
    SATURN,
    URANUS,
    NEPTUNE,
    PLUTO
  };

//Static methods
  static std::vector<CAAPlanetPerihelionAphelionDetails2> Calculate(double StartJD, double EndJD, Object object, double StepInterval = 0.007, bool bHighPrecision = false);
};


#endif //#ifndef __AAPLANETPERIHELIONAPHELION2_H__
