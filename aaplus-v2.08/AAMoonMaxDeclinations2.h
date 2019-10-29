/*
Module : AAMoonMaxDeclinations2.h
Purpose: Implementation for the algorithms to calculate the dates and values for maximum declination of the Moon (revised version)
Created: PJN / 22-10-2019

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

#ifndef __AAMOONMAXDECLINATIONS2_H_
#define __AAMOONMAXDECLINATIONS2_H_

#ifndef AAPLUS_EXT_CLASS
#define AAPLUS_EXT_CLASS
#endif //#ifndef AAPLUS_EXT_CLASS


/////////////////////// Includes //////////////////////////////////////////////

#include "AA2DCoordinate.h"
#include <vector>


/////////////////////// Classes ///////////////////////////////////////////////

class AAPLUS_EXT_CLASS CAAMoonMaxDeclinationsDetails2
{
public:
//Enums
  enum class Type
  {
    NotDefined = 0,
    MaxNorthernDeclination = 1,
    MaxSouthernDeclination = 2,
  };

//Constructors / Destructors
  CAAMoonMaxDeclinationsDetails2() noexcept : type(Type::NotDefined),
                                          JD(0),
                                          Declination(0),
                                          RA(0)
  {
  };
  CAAMoonMaxDeclinationsDetails2(const CAAMoonMaxDeclinationsDetails2&) = default;
  CAAMoonMaxDeclinationsDetails2(CAAMoonMaxDeclinationsDetails2&&) = default;
  ~CAAMoonMaxDeclinationsDetails2() = default;

//Methods
  CAAMoonMaxDeclinationsDetails2& operator=(const CAAMoonMaxDeclinationsDetails2&) = default;
  CAAMoonMaxDeclinationsDetails2& operator=(CAAMoonMaxDeclinationsDetails2&&) = default;

//Member variables
  Type type; //The type of the event which has occurred
  double JD; //When the event occurred in TT
  double Declination; //The actual max declination value in degrees
  double RA; //The Right ascension at the time of the event
};

class AAPLUS_EXT_CLASS CAAMoonMaxDeclinations2
{
public:
//Enums
  enum class Algorithm
  {
    MeeusTruncated = 0,
    ELP2000 = 1,
    ELPMPP02Nominal = 2,
    ELPMPP02LLR = 3,
    ELPMPP02DE405 = 4,
    ELPMPP02DE406 = 5
  };

//Static methods
  static std::vector<CAAMoonMaxDeclinationsDetails2> Calculate(double StartJD, double EndJD, double StepInterval = 0.007, Algorithm algorithm = Algorithm::MeeusTruncated);
};


#endif //#ifndef __AARISETRANSITSET2_H__
