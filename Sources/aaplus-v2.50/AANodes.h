/*
Module : AANodes.h
Purpose: Implementation for the algorithms which calculate passage through the nodes
Created: PJN / 29-12-2003

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

#ifndef __AANODES_H__
#define __AANODES_H__

#ifndef AAPLUS_EXT_CLASS
#define AAPLUS_EXT_CLASS
#endif //#ifndef AAPLUS_EXT_CLASS


//////////////////// Includes /////////////////////////////////////////////////

#include "AAElliptical.h"
#include "AAParabolic.h"


//////////////////// Classes //////////////////////////////////////////////////

class AAPLUS_EXT_CLASS CAANodeObjectDetails
{
public:
//Member variables
  double t{0};
  double radius{0};
};

class AAPLUS_EXT_CLASS CAANodes
{
public:
//Static methods
  static CAANodeObjectDetails PassageThroAscendingNode(const CAAEllipticalObjectElements& elements) noexcept;
  static CAANodeObjectDetails PassageThroDescendingNode(const CAAEllipticalObjectElements& elements) noexcept;
  static CAANodeObjectDetails PassageThroAscendingNode(const CAAParabolicObjectElements& elements) noexcept;
  static CAANodeObjectDetails PassageThroDescendingNode(const CAAParabolicObjectElements& elements) noexcept;
};


#endif //#ifndef __AANODES_H__
