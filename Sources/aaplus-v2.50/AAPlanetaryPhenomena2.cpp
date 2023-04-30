/*
Module : AAPlanetaryPhenomena2.cpp
Purpose: Implementation for the algorithms which obtain the dates of various planetary phenomena (revised version)
Created: PJN / 11-06-2020
History: PJN / 11-06-2020 1. Initial implementation
         PJN / 04-07-2022 1. Updated all the code in AAPlanetaryPhenomena2.cpp to use C++ uniform initialization for
                          all variable declarations.
         PJN / 01-20-2022 1. Added support to CAAPlanetaryPhenomena2::Calculate for MinimumDistance and 
                          MaximumDistance event types.
         PJN / 28-01-2023 1. Fixed a number of spelling mistakes in the CAAPlanetaryPhenomena2::Calculate
                          method.

Copyright (c) 2020 - 2023 by PJ Naughter (Web: www.naughter.com, Email: pjna@naughter.com)

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


//////////////////// Implementation ///////////////////////////////////////////

std::vector<CAAPlanetaryPhenomenaDetails2> CAAPlanetaryPhenomena2::Calculate(double StartJD, double EndJD, Object object, double StepInterval, bool bHighPrecision)
{
  //What will be the return value
  std::vector<CAAPlanetaryPhenomenaDetails2> events;

  double JD{StartJD};
  double LastJD{0};
  double LastConjunctionValueInEclipticLongitude0{-1};
  double LastConjunctionValueInRA0{-1};
  double LastConjunctionValueInEclipticLongitude1{-1};
  double LastConjunctionValueInRA1{-1};
  double LastElongationValue0{-1};
  double LastElongationValue1{-1};
  double LastStationValueInEclipticLongitude0{-1};
  double LastStationValueInEclipticLongitude1{-1};
  double LastStationValueInRA0{-1};
  double LastStationValueInRA1{-1};
  double LastMinDistance0{-1};
  double LastMinDistance1{-1};
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

    double ConjunctionValueInEclipticLongitude{0};
    if (ObjectDetails.ApparentGeocentricEclipticalLongitude > SunDetails.ApparentGeocentricEclipticalLongitude)
      ConjunctionValueInEclipticLongitude = ObjectDetails.ApparentGeocentricEclipticalLongitude - SunDetails.ApparentGeocentricEclipticalLongitude;
    else
      ConjunctionValueInEclipticLongitude = SunDetails.ApparentGeocentricEclipticalLongitude - ObjectDetails.ApparentGeocentricEclipticalLongitude;
    if (ConjunctionValueInEclipticLongitude > 180)
      ConjunctionValueInEclipticLongitude = 360 - ConjunctionValueInEclipticLongitude;
    if ((LastConjunctionValueInEclipticLongitude0 != -1) && (LastConjunctionValueInEclipticLongitude1 != -1))
    {
      if ((LastConjunctionValueInEclipticLongitude0 > ConjunctionValueInEclipticLongitude) && (LastConjunctionValueInEclipticLongitude0 > LastConjunctionValueInEclipticLongitude1))
      {
        CAAPlanetaryPhenomenaDetails2 event;
        if ((object == Object::MERCURY) || (object == Object::VENUS))
        {
          if (ObjectDetails.ApparentGeocentricEclipticalLongitude < SunDetails.ApparentGeocentricEclipticalLongitude)
            event.type = CAAPlanetaryPhenomenaDetails2::Type::GreatestWesternElongationInEclipticLongitude;
          else
            event.type = CAAPlanetaryPhenomenaDetails2::Type::GreatestEasternElongationInEclipticLongitude;
        }
        else
          event.type = CAAPlanetaryPhenomenaDetails2::Type::OppositionInEclipticLongitude;
        double fraction{0};
        const double Extremum{CAAInterpolate::Extremum(LastConjunctionValueInEclipticLongitude1, LastConjunctionValueInEclipticLongitude0, ConjunctionValueInEclipticLongitude, fraction)};
        if ((object == Object::MERCURY) || (object == Object::VENUS))
          event.Value = Extremum;
        else
          event.Value = 180;
        event.JD = LastJD + (fraction*StepInterval);
        events.push_back(event);
      }
      else if ((LastConjunctionValueInEclipticLongitude0 < ConjunctionValueInEclipticLongitude) && (LastConjunctionValueInEclipticLongitude0 < LastConjunctionValueInEclipticLongitude1))
      {
        CAAPlanetaryPhenomenaDetails2 event;
        if ((object == Object::MERCURY) || (object == Object::VENUS))
          event.type = (ObjectDetails.ApparentGeocentricDistance > 1) ? CAAPlanetaryPhenomenaDetails2::Type::SuperiorConjunctionInEclipticLongitude : CAAPlanetaryPhenomenaDetails2::Type::InferiorConjunctionInEclipticLongitude;
        else
          event.type = CAAPlanetaryPhenomenaDetails2::Type::ConjunctionInEclipticLongitude;
        double fraction{0};
        event.Value = 0;
        CAAInterpolate::Extremum(LastConjunctionValueInEclipticLongitude1, LastConjunctionValueInEclipticLongitude0, ConjunctionValueInEclipticLongitude, fraction);
        event.JD = LastJD + (fraction*StepInterval);
        events.push_back(event);
      }
    }
    double ConjunctionValueInRA{0};
    if (ObjectDetails.ApparentGeocentricRA > SunDetails.ApparentGeocentricRA)
      ConjunctionValueInRA = ObjectDetails.ApparentGeocentricRA - SunDetails.ApparentGeocentricRA;
    else
      ConjunctionValueInRA = SunDetails.ApparentGeocentricRA - ObjectDetails.ApparentGeocentricRA;
    if (ConjunctionValueInRA > 12)
      ConjunctionValueInRA = 24 - ConjunctionValueInRA;
    if ((LastConjunctionValueInRA0 != -1) && (LastConjunctionValueInRA1 != -1))
    {
      if ((LastConjunctionValueInRA0 > ConjunctionValueInRA) && (LastConjunctionValueInRA0 > LastConjunctionValueInRA1))
      {
        CAAPlanetaryPhenomenaDetails2 event;
        if ((object == Object::MERCURY) || (object == Object::VENUS))
        {
          if (ObjectDetails.ApparentGeocentricEclipticalLongitude < SunDetails.ApparentGeocentricEclipticalLongitude)
            event.type = CAAPlanetaryPhenomenaDetails2::Type::GreatestWesternElongationInRA;
          else
            event.type = CAAPlanetaryPhenomenaDetails2::Type::GreatestEasternElongationInRA;
        }
        else
          event.type = CAAPlanetaryPhenomenaDetails2::Type::OppositionInRA;
        double fraction{0};
        const double Extremum{CAAInterpolate::Extremum(LastConjunctionValueInRA1, LastConjunctionValueInRA0, ConjunctionValueInRA, fraction)};
        if ((object == Object::MERCURY) || (object == Object::VENUS))
          event.Value = Extremum;
        else
          event.Value = 12;
        event.JD = LastJD + (fraction*StepInterval);
        events.push_back(event);
      }
      else if ((LastConjunctionValueInRA0 < ConjunctionValueInRA) && (LastConjunctionValueInRA0 < LastConjunctionValueInRA1))
      {
        CAAPlanetaryPhenomenaDetails2 event;
        if ((object == Object::MERCURY) || (object == Object::VENUS))
          event.type = (ObjectDetails.ApparentGeocentricDistance > 1) ? CAAPlanetaryPhenomenaDetails2::Type::SuperiorConjunctionInRA : CAAPlanetaryPhenomenaDetails2::Type::InferiorConjunctionInRA;
        else
          event.type = CAAPlanetaryPhenomenaDetails2::Type::ConjunctionInRA;
        double fraction{0};
        event.Value = 0;
        CAAInterpolate::Extremum(LastConjunctionValueInRA1, LastConjunctionValueInRA0, ConjunctionValueInRA, fraction);
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
          if (ObjectDetails.ApparentGeocentricEclipticalLongitude < SunDetails.ApparentGeocentricEclipticalLongitude)
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
    if (LastConjunctionValueInRA0 != -1)
    {
      if (((LastConjunctionValueInRA0 < 6) && (ConjunctionValueInRA >= 6)) || ((LastConjunctionValueInRA0 > 6) && (ConjunctionValueInRA <= 6)))
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
        const double fraction{(6 - LastConjunctionValueInRA0)/(ConjunctionValueInRA - LastConjunctionValueInRA0)};
        event.JD = LastJD + (fraction*StepInterval);
        event.Value = 6;
        events.push_back(event);
      }
    }
    if (LastConjunctionValueInEclipticLongitude0 != -1)
    {
      if (((LastConjunctionValueInEclipticLongitude0 < 90) && (ConjunctionValueInEclipticLongitude >= 90)) || ((LastConjunctionValueInEclipticLongitude0 > 90) && (ConjunctionValueInEclipticLongitude <= 90)))
      {
        double SunApparentGeocentricEclipticLongitudeComparison{SunDetails.ApparentGeocentricEclipticalLongitude};
        double ObjectApparentGeocentricEclipticLongitudeComparison{ObjectDetails.ApparentGeocentricEclipticalLongitude};
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
        const double fraction{(90 - LastConjunctionValueInEclipticLongitude0)/(ConjunctionValueInEclipticLongitude - LastConjunctionValueInEclipticLongitude0)};
        event.JD = LastJD + (fraction*StepInterval);
        event.Value = 90;
        events.push_back(event);
      }
    }
    if (LastElongationValue0 != -1)
    {
      if (((LastElongationValue0 < 90) && (ElongationValue >= 90)) || ((LastElongationValue0 > 90) && (ElongationValue <= 90)))
      {
        double SunApparentGeocentricLongitudeComparison{SunDetails.ApparentGeocentricEclipticalLongitude};
        double ObjectApparentGeocentricLongitudeComparison{ObjectDetails.ApparentGeocentricEclipticalLongitude};
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
    const double StationValueInEclipticLongitude{ObjectDetails.ApparentGeocentricEclipticalLongitude};
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
    const double MinDistance{ObjectDetails.TrueGeocentricDistance};
    if ((LastMinDistance0 != -1) && (LastMinDistance1 != -1))
    {
      if ((LastMinDistance0 > MinDistance) && (LastMinDistance0 > LastMinDistance1))
      {
        CAAPlanetaryPhenomenaDetails2 event;
        event.type = CAAPlanetaryPhenomenaDetails2::Type::MaximumDistance;
        double fraction{0};
        event.Value = CAAInterpolate::Extremum(LastMinDistance1, LastMinDistance0, MinDistance, fraction);
        event.JD = LastJD + (fraction*StepInterval);
        events.push_back(event);
      }
      else if ((LastMinDistance0 < MinDistance) && (LastMinDistance0 < LastMinDistance1))
      {
        CAAPlanetaryPhenomenaDetails2 event;
        event.type = CAAPlanetaryPhenomenaDetails2::Type::MinimumDistance;
        double fraction{0};
        event.Value = CAAInterpolate::Extremum(LastMinDistance1, LastMinDistance0, MinDistance, fraction);
        event.JD = LastJD + (fraction*StepInterval);
        events.push_back(event);
      }
    }

    //Prepare for the next loop
    LastConjunctionValueInEclipticLongitude1 = LastConjunctionValueInEclipticLongitude0;
    LastConjunctionValueInEclipticLongitude0 = ConjunctionValueInEclipticLongitude;
    LastConjunctionValueInRA1 = LastConjunctionValueInRA0;
    LastConjunctionValueInRA0 = ConjunctionValueInRA;
    LastElongationValue1 = LastElongationValue0;
    LastElongationValue0 = ElongationValue;
    LastStationValueInEclipticLongitude1 = LastStationValueInEclipticLongitude0;
    LastStationValueInEclipticLongitude0 = StationValueInEclipticLongitude;
    LastStationValueInRA1 = LastStationValueInRA0;
    LastStationValueInRA0 = StationValueInRA;
    LastMinDistance1 = LastMinDistance0;
    LastMinDistance0 = MinDistance;
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
