/*
Module : AAEquinoxesAndSoltices2.h
Purpose: Implementation for the algorithms to calculate the dates of the Equinoxes and Solstices (revised version)
Created: PJN / 28-09-2019

Copyright (c) 2019 by PJ Naughter (Web: www.naughter.com, Email: pjna@naughter.com)

All rights reserved.

Copyright / Usage Details:

You are allowed to include the source code in any product (commercial, shareware, freeware or otherwise) 
when your product is released in binary form. You are allowed to modify the source code in any way you want 
except you cannot modify the copyright details at the top of each module. If you want to distribute source 
code with your application, then you are only allowed to distribute versions released by the author. This is 
to maintain a single distribution point for the source code. 

*/


/////////////////////// Macros / Defines //////////////////////////////////////

#if _MSC_VER > 1000
#pragma once
#endif //#if _MSC_VER > 1000

#ifndef __AAEQUINOXESANDSOLSTICES2_H_
#define __AAEQUINOXESANDSOLSTICES2_H_

#ifndef AAPLUS_EXT_CLASS
#define AAPLUS_EXT_CLASS
#endif //#ifndef AAPLUS_EXT_CLASS


/////////////////////// Includes //////////////////////////////////////////////

#include "AA2DCoordinate.h"
#include <vector>


/////////////////////// Classes ///////////////////////////////////////////////

class AAPLUS_EXT_CLASS CAAEquinoxSolsticeDetails2
{
public:
//Enums
  enum class Type
  {
    NotDefined = 0,
    NorthwardEquinox = 1,
    NorthernSolstice = 2,
    SouthwardEquinox = 3,
    SouthernSolstice = 4,
  };

//Constructors / Destructors
  CAAEquinoxSolsticeDetails2() noexcept : type(Type::NotDefined),
                                          JD(0),
                                          Declination(0)
  {
  };
  CAAEquinoxSolsticeDetails2(const CAAEquinoxSolsticeDetails2&) = default;
  CAAEquinoxSolsticeDetails2(CAAEquinoxSolsticeDetails2&&) = default;
  ~CAAEquinoxSolsticeDetails2() = default;

//Methods
  CAAEquinoxSolsticeDetails2& operator=(const CAAEquinoxSolsticeDetails2&) = default;
  CAAEquinoxSolsticeDetails2& operator=(CAAEquinoxSolsticeDetails2&&) = default;

//Member variables
  Type type; //The type of the event which has occurred
  double JD; //When the event occurred in TT
  double Declination; //Applicable for solstices only, the apparent declination of the Sun
};

class AAPLUS_EXT_CLASS CAAEquinoxesAndSolstices2
{
public:
//Static methods
  static std::vector<CAAEquinoxSolsticeDetails2> Calculate(double StartJD, double EndJD, double StepInterval = 0.007, bool bHighPrecision = false);
};


#endif //#ifndef __AARISETRANSITSET2_H__
