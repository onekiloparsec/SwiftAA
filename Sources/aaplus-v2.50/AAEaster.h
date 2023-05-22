/*
Module : AAEaster.h
Purpose: Implementation for the algorithms which calculate the date of Easter
Created: PJN / 29-12-2003
History: PJN / 07-07-2016 1. Fixed a compiler warning in CAAEaster::Calculate as reported at
                          http://stackoverflow.com/questions/2348415/objective-c-astronomy-library.
         PJN / 03-10-2021 1. Made CAAEaster::Calculate constexpr
         PJN / 14-07-2022 1. Updated all the code in AAEaster.h to use C++ uniform initialization for all
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


//////////////////// Macros / Defines /////////////////////////////////////////

#if _MSC_VER > 1000
#pragma once
#endif //#if _MSC_VER > 1000

#ifndef __AAEASTER_H__
#define __AAEASTER_H__

#ifndef AAPLUS_EXT_CLASS
#define AAPLUS_EXT_CLASS
#endif //#ifndef AAPLUS_EXT_CLASS


//////////////////// Classes //////////////////////////////////////////////////

class AAPLUS_EXT_CLASS CAAEasterDetails
{
public:
//Member variables
  long Month{0};
  long Day{0};
};

class AAPLUS_EXT_CLASS CAAEaster
{
public:
//Static methods
  static constexpr CAAEasterDetails Calculate(int nYear, bool GregorianCalendar) noexcept
  {
    CAAEasterDetails details;
    if (GregorianCalendar)
    {
      const int a{nYear % 19};
      const int b{nYear/100};
      const int c{nYear % 100};
      const int d{b/4};
      const int e{b % 4};
      const int f{(b + 8)/25};
      const int g{(b - f + 1)/3};
      const int h{((19*a) + b - d - g + 15) % 30};
      const int i{c/4};
      const int k{c % 4};
      const int l{(32 + (2*e) + (2*i) - h - k) % 7};
      const int m{(a + (11*h) + (22*l))/451};
      const int n{(h + l - (7*m) + 114) / 31};
      const int p{(h + l - (7*m) + 114) % 31};
      details.Month = n;
      details.Day = p + 1;
    }
    else
    {
      const int a{nYear % 4};
      const int b{nYear % 7};
      const int c{nYear % 19};
      const int d{((19*c) + 15) % 30};
      const int e{((2*a) + (4*b) - d + 34) % 7};
      const int f{(d + e + 114)/31};
      const int g{(d + e + 114) % 31};
      details.Month = f;
      details.Day = g + 1;
    }
    return details;
  }
};


#endif //#ifndef __AAEASTER_H__
