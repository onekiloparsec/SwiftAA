/*
Module : AARiseTransitSet2.cpp
Purpose: Implementation for the algorithms which obtain the Rise, Transit and Set times (revised version)
Created: PJN / 29-12-2003
History: PJN / 13-07-2019 1. Initial implementation
         PJN / 15-07-2019 1. Refactored the code in various CAARiseTransitSet2 methods and improved the 
                          interpolation code to provide better accuracy of event details.
         PJN / 08-09-2019 1. Added support for EndCivilTwilight, EndNauticalTwilight, EndAstronomicalTwilight,
                          StartAstronomicalTwilight, StartNauticalTwilight & StartCivilTwilight event types
         PJN / 10-08-2021 1. Fixed various bugs in CAARiseTransitSet2::AddEvents related to the calculation
                          of various twilight events. Thanks to Stephen F. Booth for reporting these bugs.
         PJN / 20-08-2021 1. Fixed a bug in CAARiseTransitSet2::CalculateMoon in the calculation of the H0
                          value. In the book Meeus uses the value +0.125 degrees for the Moon, but this value
                          is not correct in the context of the CAARiseTransitSet2 class as this class already
                          takes diurnal parallax of the Moon into account. Instead the H0 value is now 
                          calculated with a new formula which provides more accurate times of Moon Rise and 
                          Set. Thanks to Stephen F. Booth for reporting these bug.
                          2. The CAARiseTransitSet2::CalculateMoon method now includes a new RefractionAtHorizon
                          parameter. This value defaults to -0.5667 and corresponds to the amount of 
                          atmospheric refraction to use at the moment of Moon rise or set. Note that the actual
                          H0 value for the Moon is not constant and is calculated from this value in this method
                          using the apparent semidiameter of the Moon.
                          3. Updated the CAARiseTransitSet2::CalculateMoon method to support the ELP2000 and 
                          ELPMPP02 theories in addition to the Meeus ELP2000 truncated algorithms.
         PJN / 21-08-2021 1. Reworked the algorithm to calculate the apparent semidiameter of the Moon in 
                          CAARiseTransitSet2::CalculateMoon. Tests indicate that this change only causes the
                          rise / set times of the Moon to be a couple of seconds different compared to the old
                          formula.
         PJN / 12-09-2021 1. Removed the Height parameter from the CAARiseTransitSet2::Calculate & CalculateMoon
                          methods. Instead now if you want to calculate times of rise or set at different altitudes
                          you should send in an adjusted H0 parameter. For example you could use the following 
                          formulae to adjust for the Sun:
                          double H0 = -0.8333 - CAACoordinateTransformation::RadiansToDegrees(acos(6371008 / (6371008 + Height)))
                          where Height is the altitude above sea-level in meters. Thanks to Stephen F. Booth for 
                          reporting this issue.
         PJN / 06-07-2022 1. Updated all the code in AARiseTransitSet2.cpp to use C++ uniform initialization for
                          all variable declarations.

Copyright (c) 2019 - 2023 by PJ Naughter (Web: www.naughter.com, Email: pjna@naughter.com)

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
#include "AARiseTransitSet2.h"
#include "AACoordinateTransformation.h"
#include "AAEarth.h"
#include "AAElliptical.h"
#include "AAParallax.h"
#include "AASidereal.h"
#include "AASun.h"
#include "AAMoon.h"
#include "AANutation.h"
#include "AAPrecession.h"
#ifndef AAPLUS_NO_ELP2000
#include "AAELP2000.h"
#endif //#ifndef AAPLUS_NO_ELP2000
#ifndef AAPLUS_NO_ELPMPP02
#include "AAELPMPP02.h"
#endif //#ifndef AAPLUS_NO_ELPMPP02
#include <cmath>
#include <cassert>


//////////////////// Implementation ///////////////////////////////////////////

void CAARiseTransitSet2::AddEvents(std::vector<CAARiseTransitSetDetails2>& events, double LastAltitudeForDetectingRiseSet, double AltitudeForDetectingRiseSet,
                                   double LastAltitudeForInterpolation, double h0, const CAA2DCoordinate& Horizontal, double LastJD, double StepInterval, double LastBearing, 
                                   Object object, double LastAltitudeForDetectingTwilight, double AltitudeForTwilight)
{
  if ((object == Object::SUN) && (LastAltitudeForDetectingTwilight != -90))
  {
    if ((LastAltitudeForDetectingTwilight < -18) && (AltitudeForTwilight >= -18))
    {
      CAARiseTransitSetDetails2 event;
      event.type = CAARiseTransitSetDetails2::Type::AstronomicalDawn;
      const double fraction{(-18 - LastAltitudeForInterpolation)/(Horizontal.Y - LastAltitudeForInterpolation)};
      event.JD = LastJD + (fraction*StepInterval);

      //Ensure the LastBearing and Horizontal.X values are correct for interpolation
      double LastBearing2{LastBearing};
      double HorizontalX2{Horizontal.X};
      if (fabs(HorizontalX2 - LastBearing2) > 180)
      {
        if (HorizontalX2 > LastBearing2)
          LastBearing2 += 360;
        else
          HorizontalX2 += 360;
      }

      event.Bearing = CAACoordinateTransformation::MapTo0To360Range(LastBearing2 + (fraction*(HorizontalX2 - LastBearing2)));
      events.push_back(event);
    }
    else if ((LastAltitudeForDetectingTwilight < -12) && (AltitudeForTwilight >= -12))
    {
      CAARiseTransitSetDetails2 event;
      event.type = CAARiseTransitSetDetails2::Type::NauticalDawn;
      const double fraction{(-12 - LastAltitudeForInterpolation)/(Horizontal.Y - LastAltitudeForInterpolation)};
      event.JD = LastJD + (fraction*StepInterval);

      //Ensure the LastBearing and Horizontal.X values are correct for interpolation
      double LastBearing2{LastBearing};
      double HorizontalX2{Horizontal.X};
      if (fabs(HorizontalX2 - LastBearing2) > 180)
      {
        if (HorizontalX2 > LastBearing2)
          LastBearing2 += 360;
        else
          HorizontalX2 += 360;
      }

      event.Bearing = CAACoordinateTransformation::MapTo0To360Range(LastBearing2 + (fraction*(HorizontalX2 - LastBearing2)));
      events.push_back(event);
    }
    else if ((LastAltitudeForDetectingTwilight < -6) && (AltitudeForTwilight >= -6))
    {
      CAARiseTransitSetDetails2 event;
      event.type = CAARiseTransitSetDetails2::Type::CivilDawn;
      const double fraction{(-6 - LastAltitudeForInterpolation)/(Horizontal.Y - LastAltitudeForInterpolation)};
      event.JD = LastJD + (fraction*StepInterval);

      //Ensure the LastBearing and Horizontal.X values are correct for interpolation
      double LastBearing2{LastBearing};
      double HorizontalX2{Horizontal.X};
      if (fabs(HorizontalX2 - LastBearing2) > 180)
      {
        if (HorizontalX2 > LastBearing2)
          LastBearing2 += 360;
        else
          HorizontalX2 += 360;
      }

      event.Bearing = CAACoordinateTransformation::MapTo0To360Range(LastBearing2 + (fraction*(HorizontalX2 - LastBearing2)));
      events.push_back(event);
    }
    else if ((LastAltitudeForDetectingTwilight > -18) && (AltitudeForTwilight <= -18))
    {
      CAARiseTransitSetDetails2 event;
      event.type = CAARiseTransitSetDetails2::Type::AstronomicalDusk;
      const double fraction{(-18 - LastAltitudeForInterpolation)/(Horizontal.Y - LastAltitudeForInterpolation)};
      event.JD = LastJD + (fraction * StepInterval);

      //Ensure the LastBearing and Horizontal.X values are correct for interpolation
      double LastBearing2{LastBearing};
      double HorizontalX2{Horizontal.X};
      if (fabs(HorizontalX2 - LastBearing2) > 180)
      {
        if (HorizontalX2 > LastBearing2)
          LastBearing2 += 360;
        else
          HorizontalX2 += 360;
      }

      event.Bearing = CAACoordinateTransformation::MapTo0To360Range(LastBearing2 + (fraction*(HorizontalX2 - LastBearing2)));
      events.push_back(event);
    }
    else if ((LastAltitudeForDetectingTwilight > -12) && (AltitudeForTwilight <= -12))
    {
      CAARiseTransitSetDetails2 event;
      event.type = CAARiseTransitSetDetails2::Type::NauticalDusk;
      const double fraction{(-12 - LastAltitudeForInterpolation)/(Horizontal.Y - LastAltitudeForInterpolation)};
      event.JD = LastJD + (fraction*StepInterval);

      //Ensure the LastBearing and Horizontal.X values are correct for interpolation
      double LastBearing2{LastBearing};
      double HorizontalX2{Horizontal.X};
      if (fabs(HorizontalX2 - LastBearing2) > 180)
      {
        if (HorizontalX2 > LastBearing2)
          LastBearing2 += 360;
        else
          HorizontalX2 += 360;
      }

      event.Bearing = CAACoordinateTransformation::MapTo0To360Range(LastBearing2 + (fraction*(HorizontalX2 - LastBearing2)));
      events.push_back(event);
    }
    else if ((LastAltitudeForDetectingTwilight > -6) && (AltitudeForTwilight <= -6))
    {
      CAARiseTransitSetDetails2 event;
      event.type = CAARiseTransitSetDetails2::Type::CivilDusk;
      const double fraction{(-6 - LastAltitudeForInterpolation)/(Horizontal.Y - LastAltitudeForInterpolation)};
      event.JD = LastJD + (fraction*StepInterval);

      //Ensure the LastBearing and Horizontal.X values are correct for interpolation
      double LastBearing2{LastBearing};
      double HorizontalX2{Horizontal.X};
      if (fabs(HorizontalX2 - LastBearing2) > 180)
      {
        if (HorizontalX2 > LastBearing2)
          LastBearing2 += 360;
        else
          HorizontalX2 += 360;
      }

      event.Bearing = CAACoordinateTransformation::MapTo0To360Range(LastBearing2 + (fraction*(HorizontalX2 - LastBearing2)));
      events.push_back(event);
    }
  }
  if (LastAltitudeForDetectingRiseSet != -90)
  {
    if ((LastAltitudeForDetectingRiseSet < 0) && (AltitudeForDetectingRiseSet >= 0)) //We have just rose above the horizon
    {
      CAARiseTransitSetDetails2 event;
      event.type = CAARiseTransitSetDetails2::Type::Rise;
      const double fraction{(0 - LastAltitudeForInterpolation + h0)/(Horizontal.Y - LastAltitudeForInterpolation)};
      event.JD = LastJD + (fraction*StepInterval);

      //Ensure the LastBearing and Horizontal.X values are correct for interpolation
      double LastBearing2{LastBearing};
      double HorizontalX2{Horizontal.X};
      if (fabs(HorizontalX2 - LastBearing2) > 180)
      {
        if (HorizontalX2 > LastBearing2)
          LastBearing2 += 360;
        else
          HorizontalX2 += 360;
      }

      event.Bearing = CAACoordinateTransformation::MapTo0To360Range(LastBearing2 + (fraction*(HorizontalX2 - LastBearing2)));
      events.push_back(event);
    }
    else if ((LastAltitudeForDetectingRiseSet > 0) && (AltitudeForDetectingRiseSet <= 0)) //We have just set below the horizon
    {
      CAARiseTransitSetDetails2 event;
      event.type = CAARiseTransitSetDetails2::Type::Set;
      const double fraction{(0 - LastAltitudeForInterpolation + h0)/(Horizontal.Y - LastAltitudeForInterpolation)};
      event.JD = LastJD + (fraction*StepInterval);

      //Ensure the LastBearing and Horizontal.X values are correct for interpolation
      double LastBearing2{LastBearing};
      double HorizontalX2{Horizontal.X};
      if (fabs(HorizontalX2 - LastBearing2) > 180)
      {
        if (HorizontalX2 > LastBearing2)
          LastBearing2 += 360;
        else
          HorizontalX2 += 360;
      }

      event.Bearing = CAACoordinateTransformation::MapTo0To360Range(LastBearing2 + (fraction*(HorizontalX2 - LastBearing2)));
      events.push_back(event);
    }
  }
  if (LastBearing != -1)
  {
    if ((LastBearing > 270) && (Horizontal.X >= 0) && (Horizontal.X <= 90)) //We have just crossed the southern meridian from east to west
    {
      CAARiseTransitSetDetails2 event;
      event.type = CAARiseTransitSetDetails2::Type::SouthernTransit;
      const double fraction{(360 - LastBearing)/(Horizontal.X + (360 - LastBearing))};
      event.JD = LastJD + (fraction*StepInterval);
      event.GeometricAltitude = LastAltitudeForInterpolation + (fraction*(Horizontal.Y - LastAltitudeForInterpolation));
      event.bAboveHorizon = (AltitudeForDetectingRiseSet > 0);
      events.push_back(event);
    }
    else if ((LastBearing < 90) && (Horizontal.X >= 270) && (Horizontal.X <= 360)) //We have just crossed the southern meridian from west to east
    {
      CAARiseTransitSetDetails2 event;
      event.type = CAARiseTransitSetDetails2::Type::SouthernTransit;
      const double fraction{LastBearing/(360 - Horizontal.X + LastBearing)};
      event.JD = LastJD + (fraction*StepInterval);
      event.GeometricAltitude = LastAltitudeForInterpolation + (fraction*(Horizontal.Y - LastAltitudeForInterpolation));
      event.bAboveHorizon = (AltitudeForDetectingRiseSet > 0);
      events.push_back(event);
    }
    else if ((LastBearing < 180) && (Horizontal.X >= 180)) //We have just crossed the northern meridian from west to east
    {
      CAARiseTransitSetDetails2 event;
      event.type = CAARiseTransitSetDetails2::Type::NorthernTransit;
      const double fraction{(180 - LastBearing)/(Horizontal.X - LastBearing)};
      event.JD = LastJD + (fraction*StepInterval);
      event.GeometricAltitude = LastAltitudeForInterpolation + (fraction*(Horizontal.Y - LastAltitudeForInterpolation));
      event.bAboveHorizon = (AltitudeForDetectingRiseSet > 0);
      events.push_back(event);
    }
    else if ((LastBearing > 180) && (Horizontal.X <= 180)) //We have just crossed the northern meridian from east to west
    {
      CAARiseTransitSetDetails2 event;
      event.type = CAARiseTransitSetDetails2::Type::NorthernTransit;
      const double fraction{((LastBearing - 180)/(LastBearing - Horizontal.X))};
      event.JD = LastJD + (fraction*StepInterval);
      event.GeometricAltitude = LastAltitudeForInterpolation + (fraction*(Horizontal.Y - LastAltitudeForInterpolation));
      event.bAboveHorizon = (AltitudeForDetectingRiseSet > 0);
      events.push_back(event);
    }
  }
}

std::vector<CAARiseTransitSetDetails2> CAARiseTransitSet2::Calculate(double StartJD, double EndJD, Object object, double Longitude, double Latitude, double h0, double StepInterval, bool bHighPrecision)
{
  //What will be the return value
  std::vector<CAARiseTransitSetDetails2> events;

  const double LongtitudeAsHourAngle{CAACoordinateTransformation::DegreesToHours(Longitude)};
  double JD{StartJD};
  double LastJD{0};
  double LastAltitudeForDetectingRiseSet{-90};
  double LastAltitudeForInterpolation{-90};
  double LastAltitudeForDetectingTwilight{-90};
  double LastBearing = -1;
  while (JD < EndJD)
  {
    CAAEllipticalPlanetaryDetails details;
    CAA2DCoordinate Topo;
    switch (object)
    {
      case Object::SUN:
      {
        const double Long{CAASun::ApparentEclipticLongitude(JD, bHighPrecision)};
        const double Lat{CAASun::ApparentEclipticLatitude(JD, bHighPrecision)};
        const CAA2DCoordinate Equatorial{CAACoordinateTransformation::Ecliptic2Equatorial(Long, Lat, CAANutation::TrueObliquityOfEcliptic(JD))};
        const double SunRad{CAAEarth::RadiusVector(JD, bHighPrecision)};
        Topo = CAAParallax::Equatorial2Topocentric(Equatorial.X, Equatorial.Y, SunRad, Longitude, Latitude, 0, JD);
        break;
      }
      case Object::MOON:
      {
        const double Long{CAAMoon::EclipticLongitude(JD)};
        const double Lat{CAAMoon::EclipticLatitude(JD)};
        const CAA2DCoordinate Equatorial{CAACoordinateTransformation::Ecliptic2Equatorial(Long, Lat, CAANutation::TrueObliquityOfEcliptic(JD))};
        const double MoonRad{CAAMoon::RadiusVector(JD)/149597871}; //Convert Kms to AUs
        Topo = CAAParallax::Equatorial2Topocentric(Equatorial.X, Equatorial.Y, MoonRad, Longitude, Latitude, 0, JD);
        break;
      }
      case Object::MERCURY:
      {
        details = CAAElliptical::Calculate(JD, CAAElliptical::Object::MERCURY, bHighPrecision);
        Topo = CAAParallax::Equatorial2Topocentric(details.ApparentGeocentricRA, details.ApparentGeocentricDeclination, details.ApparentGeocentricDistance, Longitude, Latitude, 0, JD);
        break;
      }
      case Object::VENUS:
      {
        details = CAAElliptical::Calculate(JD, CAAElliptical::Object::VENUS, bHighPrecision);
        Topo = CAAParallax::Equatorial2Topocentric(details.ApparentGeocentricRA, details.ApparentGeocentricDeclination, details.ApparentGeocentricDistance, Longitude, Latitude, 0, JD);
        break;
      }
      case Object::MARS:
      {
        details = CAAElliptical::Calculate(JD, CAAElliptical::Object::MARS, bHighPrecision);
        Topo = CAAParallax::Equatorial2Topocentric(details.ApparentGeocentricRA, details.ApparentGeocentricDeclination, details.ApparentGeocentricDistance, Longitude, Latitude, 0, JD);
        break;
      }
      case Object::JUPITER:
      {
        details = CAAElliptical::Calculate(JD, CAAElliptical::Object::JUPITER, bHighPrecision);
        Topo = CAAParallax::Equatorial2Topocentric(details.ApparentGeocentricRA, details.ApparentGeocentricDeclination, details.ApparentGeocentricDistance, Longitude, Latitude, 0, JD);
        break;
      }
      case Object::SATURN:
      {
        details = CAAElliptical::Calculate(JD, CAAElliptical::Object::SATURN, bHighPrecision);
        Topo = CAAParallax::Equatorial2Topocentric(details.ApparentGeocentricRA, details.ApparentGeocentricDeclination, details.ApparentGeocentricDistance, Longitude, Latitude, 0, JD);
        break;
      }
      case Object::URANUS:
      {
        details = CAAElliptical::Calculate(JD, CAAElliptical::Object::URANUS, bHighPrecision);
        Topo = CAAParallax::Equatorial2Topocentric(details.ApparentGeocentricRA, details.ApparentGeocentricDeclination, details.ApparentGeocentricDistance, Longitude, Latitude, 0, JD);
        break;
      }
      case Object::NEPTUNE:
      {
        details = CAAElliptical::Calculate(JD, CAAElliptical::Object::NEPTUNE, bHighPrecision);
        Topo = CAAParallax::Equatorial2Topocentric(details.ApparentGeocentricRA, details.ApparentGeocentricDeclination, details.ApparentGeocentricDistance, Longitude, Latitude, 0, JD);
        break;
      }
      default:
      {
        assert(false);
        break;
      }
    }
    const double AST{CAASidereal::ApparentGreenwichSiderealTime(JD)};
    const double LocalHourAngle{AST - LongtitudeAsHourAngle - Topo.X};
    const CAA2DCoordinate Horizontal{CAACoordinateTransformation::Equatorial2Horizontal(LocalHourAngle, Topo.Y, Latitude)};
    const double AltitudeForDetectingRiseSet{Horizontal.Y - h0};

    //Call the helper method to add any found events
    AddEvents(events, LastAltitudeForDetectingRiseSet, AltitudeForDetectingRiseSet, LastAltitudeForInterpolation, h0, Horizontal, LastJD, StepInterval, LastBearing, object, LastAltitudeForDetectingTwilight, Horizontal.Y);

    //Prepare for the next loop
    LastAltitudeForDetectingRiseSet = AltitudeForDetectingRiseSet;
    LastAltitudeForInterpolation = Horizontal.Y;
    LastAltitudeForDetectingTwilight = Horizontal.Y;
    LastBearing = Horizontal.X;
    LastJD = JD;
    JD += StepInterval;
  }

  return events;
}

//The higher accuracy version for the moon where the "standard altitude" is not treated as a constant
std::vector<CAARiseTransitSetDetails2> CAARiseTransitSet2::CalculateMoon(double StartJD, double EndJD, double Longitude, double Latitude, double RefractionAtHorizon, double StepInterval, MoonAlgorithm algorithm)
{
  //What will be the return value
  std::vector<CAARiseTransitSetDetails2> events;

  const double LongtitudeAsHourAngle{CAACoordinateTransformation::DegreesToHours(Longitude)};
  double JD{StartJD};
  double LastJD{0};
  double LastAltitudeForDetectingRiseSet{-90};
  double LastAltitudeForInterpolation{-90};
  double LastBearing{-1};
  while (JD < EndJD)
  {
    CAA2DCoordinate MoonPos;
    double MoonRad{0};
    switch (algorithm)
    {
      case MoonAlgorithm::MeeusTruncated:
      {
        MoonPos.X = CAAMoon::EclipticLongitude(JD);
        MoonPos.Y = CAAMoon::EclipticLatitude(JD);
        MoonRad = CAAMoon::RadiusVector(JD);
        break;
      }
#ifndef AAPLUS_NO_ELP2000
      case MoonAlgorithm::ELP2000:
      {
        MoonPos = CAAPrecession::PrecessEcliptic(CAAELP2000::EclipticLongitude(JD), CAAELP2000::EclipticLatitude(JD), 2451545.0, JD);
        MoonRad = CAAELP2000::RadiusVector(JD);
        break;
      }
#endif //#ifndef AAPLUS_NO_ELP2000
#ifndef AAPLUS_NO_ELPMPP02
      case MoonAlgorithm::ELPMPP02Nominal:
      {
        MoonPos = CAAPrecession::PrecessEcliptic(CAAELPMPP02::EclipticLongitude(JD, CAAELPMPP02::Correction::Nominal), CAAELPMPP02::EclipticLatitude(JD, CAAELPMPP02::Correction::Nominal), 2451545.0, JD);
        MoonRad = CAAELPMPP02::RadiusVector(JD, CAAELPMPP02::Correction::Nominal);
        break;
      }
      case MoonAlgorithm::ELPMPP02LLR:
      {
        MoonPos = CAAPrecession::PrecessEcliptic(CAAELPMPP02::EclipticLongitude(JD, CAAELPMPP02::Correction::LLR), CAAELPMPP02::EclipticLatitude(JD, CAAELPMPP02::Correction::LLR), 2451545.0, JD);
        MoonRad = CAAELPMPP02::RadiusVector(JD, CAAELPMPP02::Correction::LLR);
        break;
      }
      case MoonAlgorithm::ELPMPP02DE405:
      {
        MoonPos = CAAPrecession::PrecessEcliptic(CAAELPMPP02::EclipticLongitude(JD, CAAELPMPP02::Correction::DE405), CAAELPMPP02::EclipticLatitude(JD, CAAELPMPP02::Correction::DE405), 2451545.0, JD);
        MoonRad = CAAELPMPP02::RadiusVector(JD, CAAELPMPP02::Correction::DE405);
        break;
      }
      case MoonAlgorithm::ELPMPP02DE406:
      {
        MoonPos = CAAPrecession::PrecessEcliptic(CAAELPMPP02::EclipticLongitude(JD, CAAELPMPP02::Correction::DE406), CAAELPMPP02::EclipticLatitude(JD, CAAELPMPP02::Correction::DE406), 2451545.0, JD);
        MoonRad = CAAELPMPP02::RadiusVector(JD, CAAELPMPP02::Correction::DE406);
        break;
      }
#endif //#ifndef AAPLUS_NO_ELPMPP02
      default:
      {
        assert(false);
        break;
      }
    }

    const CAA2DCoordinate Equatorial{CAACoordinateTransformation::Ecliptic2Equatorial(MoonPos.X, MoonPos.Y, CAANutation::TrueObliquityOfEcliptic(JD))};
    const CAA2DCoordinate Topo{CAAParallax::Equatorial2Topocentric(Equatorial.X, Equatorial.Y, MoonRad/149597871, Longitude, Latitude, 0, JD)};
    const double AST{CAASidereal::ApparentGreenwichSiderealTime(JD)};
    const double LocalHourAngle{AST - LongtitudeAsHourAngle - Topo.X};
    const CAA2DCoordinate Horizontal{CAACoordinateTransformation::Equatorial2Horizontal(LocalHourAngle, Topo.Y, Latitude)};
    const double h0{RefractionAtHorizon - CAACoordinateTransformation::RadiansToDegrees(asin(1737.4/MoonRad))};
    const double AltitudeForDetectingRiseSet{Horizontal.Y - h0};

    //Call the helper method to add any found events
    AddEvents(events, LastAltitudeForDetectingRiseSet, AltitudeForDetectingRiseSet, LastAltitudeForInterpolation, h0, Horizontal, LastJD, StepInterval, LastBearing, Object::MOON, 0, 0);

    //Prepare for the next loop
    LastAltitudeForDetectingRiseSet = AltitudeForDetectingRiseSet;
    LastAltitudeForInterpolation = Horizontal.Y;
    LastBearing = Horizontal.X;
    LastJD = JD;
    JD += StepInterval;
  }

  return events;
}


//A version for a stationary object such as a star
std::vector<CAARiseTransitSetDetails2> CAARiseTransitSet2::CalculateStationary(double StartJD, double EndJD, double Alpha, double Delta, double Longitude, double Latitude, double h0, double StepInterval)
{
  //What will be the return value
  std::vector<CAARiseTransitSetDetails2> events;

  const double LongtitudeAsHourAngle{CAACoordinateTransformation::DegreesToHours(Longitude)};
  double JD{StartJD};
  double LastJD{0};
  double LastAltitudeForDetectingRiseSet{-90};
  double LastAltitudeForInterpolation{-90};
  double LastBearing{-1};
  while (JD < EndJD)
  {
    const double AST{CAASidereal::ApparentGreenwichSiderealTime(JD)};
    const double LocalHourAngle{AST - LongtitudeAsHourAngle - Alpha};
    const CAA2DCoordinate Horizontal{CAACoordinateTransformation::Equatorial2Horizontal(LocalHourAngle, Delta, Latitude)};
    const double AltitudeForDetectingRiseSet{Horizontal.Y - h0};

    //Call the helper method to add any found event
    AddEvents(events, LastAltitudeForDetectingRiseSet, AltitudeForDetectingRiseSet, LastAltitudeForInterpolation, h0, Horizontal, LastJD, StepInterval, LastBearing, Object::STAR, 0, 0);

    //Prepare for the next loop
    LastAltitudeForDetectingRiseSet = AltitudeForDetectingRiseSet;
    LastAltitudeForInterpolation = Horizontal.Y;
    LastBearing = Horizontal.X;
    LastJD = JD;
    JD += StepInterval;
  }

  return events;
}
