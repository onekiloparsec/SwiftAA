/*
Module : AAPlanetaryPhenomena2.cpp
Purpose: Implementation for the algorithms which obtain the dates of various planetary phenomena (revised version)
Created: PJN / 11-06-2020
History: PJN / 11-06-2020 1. Initial implementation
         PJN / 04-07-2022 1. Updated all the code in AAPlanetaryPhenomena2.cpp to use C++ uniform initialization for
                          all variable declarations.

Copyright (c) 2020 - 2022 by PJ Naughter (Web: www.naughter.com, Email: pjna@naughter.com)

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
#include "AAPlanetaryPhenomena2.h"
#include "AAElliptical.h"
#include "AACoordinateTransformation.h"
#include "AAAngularSeparation.h"
#include "AAInterpolate.h"
#include <cassert>
using namespace std;


//////////////////// Implementation ///////////////////////////////////////////

vector<CAAPlanetaryPhenomenaDetails2> CAAPlanetaryPhenomena2::Calculate(double StartJD, double EndJD, Object object, double StepInterval, bool bHighPrecision)
{
  //What will be the return value
  vector<CAAPlanetaryPhenomenaDetails2> events;

  double JD{StartJD};
  double LastJD{0};
  double LastConjuctionValueInEclipticLongitude0{-1};
  double LastConjuctionValueInRA0{-1};
  double LastConjuctionValueInEclipticLongitude1{-1};
  double LastConjuctionValueInRA1{-1};
  double LastElongationValue0{-1};
  double LastElongationValue1{-1};
  double LastStationValueInEclipticLongitude0{-1};
  double LastStationValueInEclipticLongitude1{-1};
  double LastStationValueInRA0{-1};
  double LastStationValueInRA1{-1};
  while (JD < EndJD)
  {
    const CAAEllipticalPlanetaryDetails SunDetails{CAAElliptical::Calculate(JD, CAAElliptical::Object::SUN, bHighPrecision)};
    CAAEllipticalPlanetaryDetails ObjectDetails;
    switch (object)
    {
      case Object::MERCURY:
      {
        ObjectDetails = CAAElliptical::Calculate(JD, CAAElliptical::Object::MERCURY, bHighPrecision);
        break;
      }
      case Object::VENUS:
      {
        ObjectDetails = CAAElliptical::Calculate(JD, CAAElliptical::Object::VENUS, bHighPrecision);
        break;
      }
      case Object::MARS:
      {
        ObjectDetails = CAAElliptical::Calculate(JD, CAAElliptical::Object::MARS, bHighPrecision);
        break;
      }
      case Object::JUPITER:
      {
        ObjectDetails = CAAElliptical::Calculate(JD, CAAElliptical::Object::JUPITER, bHighPrecision);
        break;
      }
      case Object::SATURN:
      {
        ObjectDetails = CAAElliptical::Calculate(JD, CAAElliptical::Object::SATURN, bHighPrecision);
        break;
      }
      case Object::URANUS:
      {
        ObjectDetails = CAAElliptical::Calculate(JD, CAAElliptical::Object::URANUS, bHighPrecision);
        break;
      }
      case Object::NEPTUNE:
      {
        ObjectDetails = CAAElliptical::Calculate(JD, CAAElliptical::Object::NEPTUNE, bHighPrecision);
        break;
      }
      default:
      {
        assert(false);
        break;
      }
    }

    double ConjuctionValueInEclipticLongitude{0};
    if (ObjectDetails.ApparentGeocentricLongitude > SunDetails.ApparentGeocentricLongitude)
      ConjuctionValueInEclipticLongitude = ObjectDetails.ApparentGeocentricLongitude - SunDetails.ApparentGeocentricLongitude;
    else
      ConjuctionValueInEclipticLongitude = SunDetails.ApparentGeocentricLongitude - ObjectDetails.ApparentGeocentricLongitude;
    if (ConjuctionValueInEclipticLongitude > 180)
      ConjuctionValueInEclipticLongitude = 360 - ConjuctionValueInEclipticLongitude;
    if ((LastConjuctionValueInEclipticLongitude0 != -1) && (LastConjuctionValueInEclipticLongitude1 != -1))
    {
      if ((LastConjuctionValueInEclipticLongitude0 > ConjuctionValueInEclipticLongitude) && (LastConjuctionValueInEclipticLongitude0 > LastConjuctionValueInEclipticLongitude1))
      {
        CAAPlanetaryPhenomenaDetails2 event;
        if ((object == Object::MERCURY) || (object == Object::VENUS))
        {
          if (ObjectDetails.ApparentGeocentricLongitude < SunDetails.ApparentGeocentricLongitude)
            event.type = CAAPlanetaryPhenomenaDetails2::Type::GreatestWesternElongationInEclipticLongitude;
          else
            event.type = CAAPlanetaryPhenomenaDetails2::Type::GreatestEasternElongationInEclipticLongitude;
        }
        else
          event.type = CAAPlanetaryPhenomenaDetails2::Type::OppositionInEclipticLongitude;
        double fraction{0};
        const double Extremum{CAAInterpolate::Extremum(LastConjuctionValueInEclipticLongitude1, LastConjuctionValueInEclipticLongitude0, ConjuctionValueInEclipticLongitude, fraction)};
        if ((object == Object::MERCURY) || (object == Object::VENUS))
          event.Value = Extremum;
        else
          event.Value = 180;
        event.JD = LastJD + (fraction*StepInterval);
        events.push_back(event);
      }
      else if ((LastConjuctionValueInEclipticLongitude0 < ConjuctionValueInEclipticLongitude) && (LastConjuctionValueInEclipticLongitude0 < LastConjuctionValueInEclipticLongitude1))
      {
        CAAPlanetaryPhenomenaDetails2 event;
        if ((object == Object::MERCURY) || (object == Object::VENUS))
          event.type = (ObjectDetails.ApparentGeocentricDistance > 1) ? CAAPlanetaryPhenomenaDetails2::Type::SuperiorConjunctionInEclipticLongitude : CAAPlanetaryPhenomenaDetails2::Type::InferiorConjunctionInEclipticLongitude;
        else
          event.type = CAAPlanetaryPhenomenaDetails2::Type::ConjunctionInEclipticLongitude;
        double fraction{0};
        event.Value = 0;
        CAAInterpolate::Extremum(LastConjuctionValueInEclipticLongitude1, LastConjuctionValueInEclipticLongitude0, ConjuctionValueInEclipticLongitude, fraction);
        event.JD = LastJD + (fraction*StepInterval);
        events.push_back(event);
      }
    }
    double ConjuctionValueInRA{0};
    if (ObjectDetails.ApparentGeocentricRA > SunDetails.ApparentGeocentricRA)
      ConjuctionValueInRA = ObjectDetails.ApparentGeocentricRA - SunDetails.ApparentGeocentricRA;
    else
      ConjuctionValueInRA = SunDetails.ApparentGeocentricRA - ObjectDetails.ApparentGeocentricRA;
    if (ConjuctionValueInRA > 12)
      ConjuctionValueInRA = 24 - ConjuctionValueInRA;
    if ((LastConjuctionValueInRA0 != -1) && (LastConjuctionValueInRA1 != -1))
    {
      if ((LastConjuctionValueInRA0 > ConjuctionValueInRA) && (LastConjuctionValueInRA0 > LastConjuctionValueInRA1))
      {
        CAAPlanetaryPhenomenaDetails2 event;
        if ((object == Object::MERCURY) || (object == Object::VENUS))
        {
          if (ObjectDetails.ApparentGeocentricLongitude < SunDetails.ApparentGeocentricLongitude)
            event.type = CAAPlanetaryPhenomenaDetails2::Type::GreatestWesternElongationInRA;
          else
            event.type = CAAPlanetaryPhenomenaDetails2::Type::GreatestEasternElongationInRA;
        }
        else
          event.type = CAAPlanetaryPhenomenaDetails2::Type::OppositionInRA;
        double fraction{0};
        const double Extremum{CAAInterpolate::Extremum(LastConjuctionValueInRA1, LastConjuctionValueInRA0, ConjuctionValueInRA, fraction)};
        if ((object == Object::MERCURY) || (object == Object::VENUS))
          event.Value = Extremum;
        else
          event.Value = 12;
        event.JD = LastJD + (fraction*StepInterval);
        events.push_back(event);
      }
      else if ((LastConjuctionValueInRA0 < ConjuctionValueInRA) && (LastConjuctionValueInRA0 < LastConjuctionValueInRA1))
      {
        CAAPlanetaryPhenomenaDetails2 event;
        if ((object == Object::MERCURY) || (object == Object::VENUS))
          event.type = (ObjectDetails.ApparentGeocentricDistance > 1) ? CAAPlanetaryPhenomenaDetails2::Type::SuperiorConjunctionInRA : CAAPlanetaryPhenomenaDetails2::Type::InferiorConjunctionInRA;
        else
          event.type = CAAPlanetaryPhenomenaDetails2::Type::ConjunctionInRA;
        double fraction{0};
        event.Value = 0;
        CAAInterpolate::Extremum(LastConjuctionValueInRA1, LastConjuctionValueInRA0, ConjuctionValueInRA, fraction);
        event.JD = LastJD + (fraction*StepInterval);
        events.push_back(event);
      }
    }
    const double ElongationValue{CAAAngularSeparation::Separation(SunDetails.ApparentGeocentricRA, SunDetails.ApparentGeocentricDeclination, ObjectDetails.ApparentGeocentricRA, ObjectDetails.ApparentGeocentricDeclination)};
    if ((LastElongationValue0 != -1) && (LastElongationValue1 != -1))
    {
      if ((LastElongationValue0 > ElongationValue) && (LastElongationValue0 > LastElongationValue1))
      {
        CAAPlanetaryPhenomenaDetails2 event;
        if ((object == Object::MERCURY) || (object == Object::VENUS))
        {
          if (ObjectDetails.ApparentGeocentricLongitude < SunDetails.ApparentGeocentricLongitude)
            event.type = CAAPlanetaryPhenomenaDetails2::Type::GreatestWesternElongationInAngularDistance;
          else
            event.type = CAAPlanetaryPhenomenaDetails2::Type::GreatestEasternElongationInAngularDistance;
        }
        else
          event.type = CAAPlanetaryPhenomenaDetails2::Type::OppositionInAngularDistance;
        double fraction{0};
        event.Value = CAAInterpolate::Extremum(LastElongationValue1, LastElongationValue0, ElongationValue, fraction);
        event.JD = LastJD + (fraction*StepInterval);
        events.push_back(event);
      }
      else if ((LastElongationValue0 < ElongationValue) && (LastElongationValue0 < LastElongationValue1))
      {
        CAAPlanetaryPhenomenaDetails2 event;
        if ((object == Object::MERCURY) || (object == Object::VENUS))
          event.type = (ObjectDetails.ApparentGeocentricDistance > 1) ? CAAPlanetaryPhenomenaDetails2::Type::SuperiorConjunctionInAngularDistance : CAAPlanetaryPhenomenaDetails2::Type::InferiorConjunctionInAngularDistance;
        else
          event.type = CAAPlanetaryPhenomenaDetails2::Type::ConjunctionInAngularDistance;
        double fraction{0};
        event.Value = CAAInterpolate::Extremum(LastElongationValue1, LastElongationValue0, ElongationValue, fraction);
        event.JD = LastJD + (fraction*StepInterval);
        events.push_back(event);
      }
    }
    if (LastConjuctionValueInRA0 != -1)
    {
      if (((LastConjuctionValueInRA0 < 6) && (ConjuctionValueInRA >= 6)) || ((LastConjuctionValueInRA0 > 6) && (ConjuctionValueInRA <= 6)))
      {
        double SunApparentGeocentricRAComparison{SunDetails.ApparentGeocentricRA};
        double ObjectApparentGeocentricRAComparison{ObjectDetails.ApparentGeocentricRA};
        if (fabs(ObjectApparentGeocentricRAComparison - SunApparentGeocentricRAComparison) > 12)
        {
          if (ObjectApparentGeocentricRAComparison > SunApparentGeocentricRAComparison)
            SunApparentGeocentricRAComparison += 24;
          else
            ObjectApparentGeocentricRAComparison += 24;
        }
        CAAPlanetaryPhenomenaDetails2 event;
        if (ObjectApparentGeocentricRAComparison > SunApparentGeocentricRAComparison)
          event.type = CAAPlanetaryPhenomenaDetails2::Type::EasternQuadratureInRA;
        else
          event.type = CAAPlanetaryPhenomenaDetails2::Type::WesternQuadratureInRA;
        const double fraction{(6 - LastConjuctionValueInRA0)/(ConjuctionValueInRA - LastConjuctionValueInRA0)};
        event.JD = LastJD + (fraction*StepInterval);
        event.Value = 6;
        events.push_back(event);
      }
    }
    if (LastConjuctionValueInEclipticLongitude0 != -1)
    {
      if (((LastConjuctionValueInEclipticLongitude0 < 90) && (ConjuctionValueInEclipticLongitude >= 90)) || ((LastConjuctionValueInEclipticLongitude0 > 90) && (ConjuctionValueInEclipticLongitude <= 90)))
      {
        double SunApparentGeocentricEclipticLongitudeComparison{SunDetails.ApparentGeocentricLongitude};
        double ObjectApparentGeocentricEclipticLongitudeComparison{ObjectDetails.ApparentGeocentricLongitude};
        if (fabs(ObjectApparentGeocentricEclipticLongitudeComparison - SunApparentGeocentricEclipticLongitudeComparison) > 180)
        {
          if (ObjectApparentGeocentricEclipticLongitudeComparison > SunApparentGeocentricEclipticLongitudeComparison)
            SunApparentGeocentricEclipticLongitudeComparison += 360;
          else
            ObjectApparentGeocentricEclipticLongitudeComparison += 360;
        }
        CAAPlanetaryPhenomenaDetails2 event;
        if (ObjectApparentGeocentricEclipticLongitudeComparison > SunApparentGeocentricEclipticLongitudeComparison)
          event.type = CAAPlanetaryPhenomenaDetails2::Type::EasternQuadratureInEclipticLongitude;
        else
          event.type = CAAPlanetaryPhenomenaDetails2::Type::WesternQuadratureInEclipticLongitude;
        const double fraction{(90 - LastConjuctionValueInEclipticLongitude0)/(ConjuctionValueInEclipticLongitude - LastConjuctionValueInEclipticLongitude0)};
        event.JD = LastJD + (fraction*StepInterval);
        event.Value = 90;
        events.push_back(event);
      }
    }
    if (LastElongationValue0 != -1)
    {
      if (((LastElongationValue0 < 90) && (ElongationValue >= 90)) || ((LastElongationValue0 > 90) && (ElongationValue <= 90)))
      {
        double SunApparentGeocentricLongitudeComparison{SunDetails.ApparentGeocentricLongitude};
        double ObjectApparentGeocentricLongitudeComparison{ObjectDetails.ApparentGeocentricLongitude};
        if (fabs(ObjectApparentGeocentricLongitudeComparison - SunApparentGeocentricLongitudeComparison) > 180)
        {
          if (ObjectApparentGeocentricLongitudeComparison > SunApparentGeocentricLongitudeComparison)
            SunApparentGeocentricLongitudeComparison += 360;
          else
            ObjectApparentGeocentricLongitudeComparison += 360;
        }
        CAAPlanetaryPhenomenaDetails2 event;
        if (ObjectApparentGeocentricLongitudeComparison > SunApparentGeocentricLongitudeComparison)
          event.type = CAAPlanetaryPhenomenaDetails2::Type::EasternQuadratureInAngularDistance;
        else
          event.type = CAAPlanetaryPhenomenaDetails2::Type::WesternQuadratureInAngularDistance;
        const double fraction{(90 - LastElongationValue0)/(ElongationValue - LastElongationValue0)};
        event.JD = LastJD + (fraction*StepInterval);
        event.Value = 90;
        events.push_back(event);
      }
    }
    const double StationValueInEclipticLongitude{ObjectDetails.ApparentGeocentricLongitude};
    if ((LastStationValueInEclipticLongitude0 != -1) && (LastStationValueInEclipticLongitude1 != -1))
    {
      double LastStationValueForInterpolationInEclipticLongitude0{LastStationValueInEclipticLongitude0};
      double LastStationValueForInterpolationInEclipticLongitude1{LastStationValueInEclipticLongitude1};
      double StationValueForInterpolationInEclipticLongitude{StationValueInEclipticLongitude};
      CorrectLongitudeValuesForInterpolation(LastStationValueForInterpolationInEclipticLongitude1, LastStationValueForInterpolationInEclipticLongitude0, StationValueForInterpolationInEclipticLongitude);
      if ((LastStationValueForInterpolationInEclipticLongitude0 > StationValueForInterpolationInEclipticLongitude) && (LastStationValueForInterpolationInEclipticLongitude0 > LastStationValueForInterpolationInEclipticLongitude1))
      {
        CAAPlanetaryPhenomenaDetails2 event;
        event.type = CAAPlanetaryPhenomenaDetails2::Type::Station1InEclipticLongitude;
        double fraction{0};
        event.Value = CAACoordinateTransformation::MapTo0To360Range(CAAInterpolate::Extremum(LastStationValueForInterpolationInEclipticLongitude1, LastStationValueForInterpolationInEclipticLongitude0, StationValueForInterpolationInEclipticLongitude, fraction));
        event.JD = LastJD + (fraction*StepInterval);
        events.push_back(event);
      }
      else if ((LastStationValueForInterpolationInEclipticLongitude0 < StationValueForInterpolationInEclipticLongitude) && (LastStationValueForInterpolationInEclipticLongitude0 < LastStationValueForInterpolationInEclipticLongitude1))
      {
        CAAPlanetaryPhenomenaDetails2 event;
        event.type = CAAPlanetaryPhenomenaDetails2::Type::Station2InEclipticLongitude;
        double fraction{0};
        event.Value = CAACoordinateTransformation::MapTo0To360Range(CAAInterpolate::Extremum(LastStationValueForInterpolationInEclipticLongitude1, LastStationValueForInterpolationInEclipticLongitude0, StationValueForInterpolationInEclipticLongitude, fraction));
        event.JD = LastJD + (fraction*StepInterval);
        events.push_back(event);
      }
    }
    const double StationValueInRA{ObjectDetails.ApparentGeocentricRA};
    if ((LastStationValueInRA0 != -1) && (LastStationValueInRA1 != -1))
    {
      double LastStationValueForInterpolationInRA0{LastStationValueInRA0};
      double LastStationValueForInterpolationInRA1{LastStationValueInRA1};
      double StationValueForInterpolationInRA{StationValueInRA};
      CorrectRAValuesForInterpolation(LastStationValueForInterpolationInRA1, LastStationValueForInterpolationInRA0, StationValueForInterpolationInRA);
      if ((LastStationValueForInterpolationInRA0 > StationValueForInterpolationInRA) && (LastStationValueForInterpolationInRA0 > LastStationValueForInterpolationInRA1))
      {
        CAAPlanetaryPhenomenaDetails2 event;
        event.type = CAAPlanetaryPhenomenaDetails2::Type::Station1InRA;
        double fraction{0};
        event.Value = CAACoordinateTransformation::MapTo0To24Range(CAAInterpolate::Extremum(LastStationValueForInterpolationInRA1, LastStationValueForInterpolationInRA0, StationValueForInterpolationInRA, fraction));
        event.JD = LastJD + (fraction*StepInterval);
        events.push_back(event);
      }
      else if ((LastStationValueForInterpolationInRA0 < StationValueForInterpolationInRA) && (LastStationValueForInterpolationInRA0 < LastStationValueForInterpolationInRA1))
      {
        CAAPlanetaryPhenomenaDetails2 event;
        event.type = CAAPlanetaryPhenomenaDetails2::Type::Station2InRA;
        double fraction{0};
        event.Value = CAACoordinateTransformation::MapTo0To24Range(CAAInterpolate::Extremum(LastStationValueForInterpolationInRA1, LastStationValueForInterpolationInRA0, StationValueForInterpolationInRA, fraction));
        event.JD = LastJD + (fraction*StepInterval);
        events.push_back(event);
      }
    }

    //Prepare for the next loop
    LastConjuctionValueInEclipticLongitude1 = LastConjuctionValueInEclipticLongitude0;
    LastConjuctionValueInEclipticLongitude0 = ConjuctionValueInEclipticLongitude;
    LastConjuctionValueInRA1 = LastConjuctionValueInRA0;
    LastConjuctionValueInRA0 = ConjuctionValueInRA;
    LastElongationValue1 = LastElongationValue0;
    LastElongationValue0 = ElongationValue;
    LastStationValueInEclipticLongitude1 = LastStationValueInEclipticLongitude0;
    LastStationValueInEclipticLongitude0 = StationValueInEclipticLongitude;
    LastStationValueInRA1 = LastStationValueInRA0;
    LastStationValueInRA0 = StationValueInRA;
    LastJD = JD;
    JD += StepInterval;
  }

  return events;
}

void CAAPlanetaryPhenomena2::CorrectRAValuesForInterpolation(double& Alpha1, double& Alpha2, double& Alpha3) noexcept
{
  //Ensure the RA values are corrected for interpolation. Due to important Remark 2 by Meeus on interpolation of RA values
  Alpha1 = CAACoordinateTransformation::MapTo0To24Range(Alpha1);
  Alpha2 = CAACoordinateTransformation::MapTo0To24Range(Alpha2);
  Alpha3 = CAACoordinateTransformation::MapTo0To24Range(Alpha3);
  if (fabs(Alpha2 - Alpha1) > 12.0)
  {
    if (Alpha2 > Alpha1)
      Alpha1 += 24;
    else
      Alpha2 += 24;
  }
  if (fabs(Alpha3 - Alpha2) > 12.0)
  {
    if (Alpha3 > Alpha2)
      Alpha2 += 24;
    else
      Alpha3 += 24;
  }
  if (fabs(Alpha2 - Alpha1) > 12.0)
  {
    if (Alpha2 > Alpha1)
      Alpha1 += 24;
    else
      Alpha2 += 24;
  }
  if (fabs(Alpha3 - Alpha2) > 12.0)
  {
    if (Alpha3 > Alpha2)
      Alpha2 += 24;
    else
      Alpha3 += 24;
  }
}

void CAAPlanetaryPhenomena2::CorrectLongitudeValuesForInterpolation(double& Long1, double& Long2, double& Long3) noexcept
{
  //Ensure the Longitude values are corrected for interpolation. Due to important Remark 2 by Meeus on interpolation of Longitude values
  Long1 = CAACoordinateTransformation::MapTo0To360Range(Long1);
  Long2 = CAACoordinateTransformation::MapTo0To360Range(Long2);
  Long3 = CAACoordinateTransformation::MapTo0To360Range(Long3);
  if (fabs(Long2 - Long1) > 180)
  {
    if (Long2 > Long1)
      Long1 += 360;
    else
      Long2 += 360;
  }
  if (fabs(Long3 - Long2) > 180)
  {
    if (Long3 > Long2)
      Long2 += 360;
    else
      Long3 += 360;
  }
  if (fabs(Long2 - Long1) > 180)
  {
    if (Long2 > Long1)
      Long1 += 360;
    else
      Long2 += 360;
  }
  if (fabs(Long3 - Long2) > 180)
  {
    if (Long3 > Long2)
      Long2 += 360;
    else
      Long3 += 360;
  }
}
