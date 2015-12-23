/*
Module : AAVSOP87_VEN.h
Purpose: Implementation for the algorithms for VSOP87
Created: PJN / 13-09-2015
History: PJN / 13-09-2015 1. Initial public release.

Copyright (c) 2015 by PJ Naughter (Web: www.naughter.com, Email: pjna@naughter.com)

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
#endif

#ifndef __AAVSOP87_VEN_H__
#define __AAVSOP87_VEN_H__

#ifndef AAPLUS_EXT_CLASS
#define AAPLUS_EXT_CLASS
#endif


////////////////////////////// Classes ////////////////////////////////////////

class AAPLUS_EXT_CLASS CAAVSOP87_Venus
{
public:
  static double A(double JD);
  static double L(double JD);
  static double K(double JD);
  static double H(double JD);
  static double Q(double JD);
  static double P(double JD);
};


#endif //#ifndef __AAVSOP87_VEN_H_
