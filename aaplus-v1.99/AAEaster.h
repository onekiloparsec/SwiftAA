/*
Module : AAEaster.h
Purpose: Implementation for the algorithms which calculate the date of Easter
Created: PJN / 29-12-2003

Copyright (c) 2003 - 2019 by PJ Naughter (Web: www.naughter.com, Email: pjna@naughter.com)

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

#ifndef __AAEASTER_H__
#define __AAEASTER_H__

#ifndef AAPLUS_EXT_CLASS
#define AAPLUS_EXT_CLASS
#endif //#ifndef AAPLUS_EXT_CLASS


///////////////////// Classes /////////////////////////////////////////////////

class AAPLUS_EXT_CLASS CAAEasterDetails
{
public:
//Constructors / Destructors
  CAAEasterDetails() noexcept : Month(0),
                                Day(0)
  {
  };

//Member variables
  long Month;
  long Day;
};

class AAPLUS_EXT_CLASS CAAEaster
{
public:
//Static methods
  static CAAEasterDetails Calculate(int nYear, bool GregorianCalendar) noexcept;
};


#endif //#ifndef __AAEASTER_H__
