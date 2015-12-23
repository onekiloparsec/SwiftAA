#include "stdafx.h"
#define _USE_MATH_DEFINES
#include "AA+.h"
#include <cstdio>
#include <cmath>
#include <memory.h>
using namespace std;


#ifndef UNREFERENCED_PARAMETER
#define UNREFERENCED_PARAMETER(x) ((void)(x))
#endif //#ifndef UNREFERENCED_PARAMETER


void GetSolarRaDecByJulian(double JD, bool bHighPrecision, double& RA, double& Dec)
{
  double JDSun = CAADynamicalTime::UTC2TT(JD);
  double lambda = CAASun::ApparentEclipticLongitude(JDSun, bHighPrecision);
  double beta = CAASun::ApparentEclipticLatitude(JDSun, bHighPrecision);
  double epsilon = CAANutation::TrueObliquityOfEcliptic(JDSun);
  CAA2DCoordinate Solarcoord = CAACoordinateTransformation::Ecliptic2Equatorial(lambda, beta, epsilon);
  RA = Solarcoord.X;
  Dec = Solarcoord.Y;
}

void GetLunarRaDecByJulian(double JD, double& RA, double& Dec)
{
  double JDMoon = CAADynamicalTime::UTC2TT(JD);
  double lambda = CAAMoon::EclipticLongitude(JDMoon);
  double beta = CAAMoon::EclipticLatitude(JDMoon);
  double epsilon = CAANutation::TrueObliquityOfEcliptic(JDMoon);
  CAA2DCoordinate Lunarcoord = CAACoordinateTransformation::Ecliptic2Equatorial(lambda, beta, epsilon);
  RA = Lunarcoord.X;
  Dec = Lunarcoord.Y;
}

CAARiseTransitSetDetails GetSunRiseTransitSet(double JD, double longitude, double latitude, bool bHighPrecision)
{
  double alpha1 = 0;
  double delta1 = 0;
  GetSolarRaDecByJulian(JD - 1, bHighPrecision, alpha1, delta1);
  double alpha2 = 0;
  double delta2 = 0;
  GetSolarRaDecByJulian(JD, bHighPrecision, alpha2, delta2);
  double alpha3 = 0;
  double delta3 = 0;
  GetSolarRaDecByJulian(JD + 1, bHighPrecision, alpha3, delta3);
  return CAARiseTransitSet::Calculate(CAADynamicalTime::UTC2TT(JD), alpha1, delta1, alpha2, delta2, alpha3, delta3, longitude, latitude, -0.8333);
}

CAARiseTransitSetDetails GetMoonRiseTransitSet(double JD, double longitude, double latitude)
{
  double alpha1 = 0;
  double delta1 = 0;
  GetLunarRaDecByJulian(JD - 1, alpha1, delta1);
  double alpha2 = 0;
  double delta2 = 0;
  GetLunarRaDecByJulian(JD, alpha2, delta2);
  double alpha3 = 0;
  double delta3 = 0;
  GetLunarRaDecByJulian(JD + 1, alpha3, delta3);
  return CAARiseTransitSet::Calculate(CAADynamicalTime::UTC2TT(JD), alpha1, delta1, alpha2, delta2, alpha3, delta3, longitude, latitude, 0.125);
}

void PrintTime(double JD, const char* msg)
{
  CAADate date_time(JD, true);
  long year = 0;
  long month = 0;
  long day = 0;
  long hour = 0;
  long minute = 0;
  double second = 0;
  date_time.Get(year, month, day, hour, minute, second);
  printf("%s: %d-%d-%d %02d:%02d:%02d\n", msg, static_cast<int>(year), static_cast<int>(month), static_cast<int>(day), static_cast<int>(hour), static_cast<int>(minute), static_cast<int>(second));
}

void PrintRiseTransitSet(double JD, CAARiseTransitSetDetails& rise_transit_set)
{
  if (rise_transit_set.bRiseValid)
  {
    double riseJD = (JD + (rise_transit_set.Rise / 24.00));
    PrintTime(riseJD, "Rise");
  }

  double transitJD = (JD + (rise_transit_set.Transit / 24.00));
  PrintTime(transitJD, "Transit");

  if (rise_transit_set.bSetValid)
  {
    double setJD = (JD + (rise_transit_set.Set / 24.00));
    PrintTime(setJD, "Set");
  }
}

void PrintRiseTransitSet2(double JD, int time_zone_offset, CAARiseTransitSetDetails& rise_transit_set)
{
  if (rise_transit_set.bRiseValid)
  {
    double riseJD = (JD + ((rise_transit_set.Rise) / 24.00));
    PrintTime(riseJD, "Rise (UTC)");
    riseJD += ((time_zone_offset) / 24.00);
    PrintTime(riseJD, "Rise (Local)");
  }

  double transitJD = (JD + ((rise_transit_set.Transit) / 24.00));
  PrintTime(transitJD, "Transit (UTC)");
  transitJD += ((time_zone_offset) / 24.00);
  PrintTime(transitJD, "Transit (Local)");

  if (rise_transit_set.bSetValid)
  {
    double setJD = (JD + ((rise_transit_set.Set) / 24.00));
    PrintTime(setJD, "Set (UTC)");
    setJD += ((time_zone_offset) / 24.00);
    PrintTime(setJD, "Set (Local)");
  }
}

void GetMoonIllumination(double JD, bool bHighPrecision, double& illuminated_fraction, double& position_angle, double& phase_angle)
{
  double moon_alpha = 0;
  double moon_delta = 0;
  GetLunarRaDecByJulian(JD, moon_alpha, moon_delta);
  double sun_alpha = 0;
  double sun_delta = 0;
  GetSolarRaDecByJulian(JD, bHighPrecision, sun_alpha, sun_delta);
  double geo_elongation = CAAMoonIlluminatedFraction::GeocentricElongation(moon_alpha, moon_delta, sun_alpha, sun_delta);

  position_angle = CAAMoonIlluminatedFraction::PositionAngle(sun_alpha, sun_delta, moon_alpha, moon_delta);
  phase_angle = CAAMoonIlluminatedFraction::PhaseAngle(geo_elongation, 368410.0, 149971520.0);
  illuminated_fraction = CAAMoonIlluminatedFraction::IlluminatedFraction(phase_angle);
}

void ASCIIPlot(char* buf, int buf_w, int x, int y, bool b)
{
  buf[x + y * buf_w] = b ? 'X' : ' ';
}

void DrawFilledEllipse(char* buf, int buf_w, int c_x, int c_y, int w, int h, bool half_l, bool half_r, bool b)
{
  int hh = h * h;
  int ww = w * w;
  int hhww = hh * ww;
  int x0 = w;
  int dx = 0;

  //do the horizontal diameter
  if (half_l)
  {
    for (int x = 0; x <= w; x++)
      ASCIIPlot(buf, buf_w, c_x - x, c_y, b);
  }
  if (half_r)
  {
    for (int x = -w; x <= 0; x++)
      ASCIIPlot(buf, buf_w, c_x - x, c_y, b);
  }
  //now do both halves at the same time, away from the diameter
  for (int y = 1; y <= h; y++)
  {
    int x1 = x0 - (dx - 1);  //try slopes of dx - 1 or more
    for ( ; x1 > 0; x1--)
    {
      if (x1*x1*hh + y*y*ww <= hhww)
        break;
    }
    dx = x0 - x1;  // current approximation of the slope
    x0 = x1;

    for (int x = -x0; x <= x0; x++)
    {
      if ((half_l && x <= 0) || (half_r && x >= 0))
      {
        ASCIIPlot(buf, buf_w, c_x + x, c_y - y, b);
        ASCIIPlot(buf, buf_w, c_x + x, c_y + y, b);
      }
    }
  }
}

double MapRange(double new_min, double new_max, double old_min, double old_max, double old_val)
{
  return (((old_val - old_min) * (new_max - new_min)) / (old_max - old_min)) + new_min;
}

void PrintMoonPhase(double position_angle, double phase_angle)
{
  //Phase:
  //right side illuminated: 0 - 180 degrees
  //left side illuminated:  180 - 360 degrees
  //0 degrees = new moon
  //90 degrees = first quarter (right half illuminated)
  //180 degrees = full moon
  //270 degrees = last quarter (left half illuminated)
  double phase(position_angle < 180 ? phase_angle + 180 : 180 - phase_angle);

  const int buf_w = 80;
  const int buf_h = 40;
  char buf[buf_w * buf_h];
  memset(buf, ' ', sizeof(buf));

  int center_x = buf_w / 2;
  int center_y = buf_h / 2;
  int radius_w = (buf_w - 1) / 2;
  int radius_h = (buf_h - 1) / 2;

  if (phase < 90)
  {
    //round right + cut out right
    DrawFilledEllipse(buf, buf_w, center_x, center_y, radius_w, radius_h, false, true, true);
    DrawFilledEllipse(buf, buf_w, center_x, center_y,
      static_cast<int>(radius_w * sin(MapRange(M_PI_2, 0.0f, 0.0f, 90.0f, phase))), radius_h,
      false, true, false);
  }
  else if (phase >= 90 && phase < 180)
  {
    //round right + addition left
    DrawFilledEllipse(buf, buf_w, center_x, center_y, radius_w, radius_h, false, true, true);
    DrawFilledEllipse(buf, buf_w, center_x, center_y,
      static_cast<int>(radius_w * sin(MapRange(0.0f, M_PI_2, 90.0f, 180.0f, phase))), radius_h,
      true, false, true);
  }
  else if (phase >= 180 && phase < 270)
  {
    //round left + addition right
    DrawFilledEllipse(buf, buf_w, center_x, center_y, radius_w, radius_h, true, false, true);
    DrawFilledEllipse(buf, buf_w, center_x, center_y,
      static_cast<int>(radius_w * sin(MapRange(M_PI_2, 0.0f, 180.0f, 270.0f, phase))), radius_h,
      false, true, true);
  }
  else
  {
    //round left + cut out left
    DrawFilledEllipse(buf, buf_w, center_x, center_y, radius_w, radius_h, true, false, true);
    DrawFilledEllipse(buf, buf_w, center_x, center_y,
      static_cast<int>(radius_w * sin(MapRange(0.0f, M_PI_2, 270.0f, 360.0f, phase))), radius_h,
      true, false, false);
  }

  for (int y=0; y<buf_h; ++y)
  {
    for (int x=0; x<buf_w; ++x)
      printf("%c", buf[x + buf_w * y]);
    printf("\n");
  }
}

void PrintMoonIlluminationAndPhase(double JD, bool bHighPrecision)
{
  double illuminated_fraction = 0;
  double position_angle = 0;
  double phase_angle = 0;
  GetMoonIllumination(JD, bHighPrecision, illuminated_fraction, position_angle, phase_angle);
  printf("Moon illumination: %d%%\n", static_cast<int>((illuminated_fraction * 100) + 0.5));
  PrintMoonPhase(position_angle, phase_angle);
}

void PrintSunAndMoonInfo(long year, long month, long day, double longitude, double latitude, bool bHighPrecision)
{
  CAADate CalcDate(year, month, day, true);
  double JD = CalcDate.Julian();
  printf("Times are in UTC\n");
  CAARiseTransitSetDetails sun_rise_transit_set(GetSunRiseTransitSet(JD, longitude, latitude, bHighPrecision));
  printf("Sun:\n");
  PrintRiseTransitSet(JD, sun_rise_transit_set);
  printf("Moon:\n");
  CAARiseTransitSetDetails moon_rise_transit_set(GetMoonRiseTransitSet(JD, longitude, latitude));
  PrintRiseTransitSet(JD, moon_rise_transit_set);
  PrintMoonIlluminationAndPhase(JD, bHighPrecision);
}

void PrintSunAndMoonInfo2(const char* city_name, int year, int month, int day, int time_offset, double longitude, double latitude, bool bHighPrecision)
{
  CAADate CalcDate(year, month, day, true);
  double JD = CalcDate.Julian();
  printf("Information for %s.  Times are offset %d hrs from UTC\n", city_name, time_offset);
  CAARiseTransitSetDetails sun_rise_transit_set(GetSunRiseTransitSet(JD, longitude, latitude, bHighPrecision));
  printf("\nSun:\n");
  PrintRiseTransitSet2(JD, time_offset, sun_rise_transit_set);
  printf("\nMoon:\n");
  CAARiseTransitSetDetails moon_rise_transit_set(GetMoonRiseTransitSet(JD, longitude, latitude));
  PrintRiseTransitSet2(JD, time_offset, moon_rise_transit_set);
  printf("\n\nxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\n\n");
}

void GetMercuryRaDecByJulian(double JD, bool bHighPrecision, double& RA, double& Dec)
{
  double JDMercury = CAADynamicalTime::UTC2TT(JD);
  double lambda = CAAMercury::EclipticLongitude(JDMercury, bHighPrecision);
  double beta = CAAMercury::EclipticLatitude(JDMercury, bHighPrecision);
  double epsilon = CAANutation::TrueObliquityOfEcliptic(JDMercury);
  CAA2DCoordinate Mercurycoord = CAACoordinateTransformation::Ecliptic2Equatorial(lambda, beta, epsilon);
  RA = Mercurycoord.X;
  Dec = Mercurycoord.Y;
}

CAARiseTransitSetDetails GetMercuryRiseTransitSet(double JD, double longitude, double latitude, bool bHighPrecision)
{
  double alpha1 = 0;
  double delta1 = 0;
  GetMercuryRaDecByJulian(JD - 1, bHighPrecision, alpha1, delta1);
  double alpha2 = 0;
  double delta2 = 0;
  GetMercuryRaDecByJulian(JD, bHighPrecision, alpha2, delta2);
  double alpha3 = 0;
  double delta3 = 0;
  GetMercuryRaDecByJulian(JD + 1, bHighPrecision, alpha3, delta3);

  printf("%f,%f,%f\n", alpha1, alpha2, alpha3);

  return CAARiseTransitSet::Calculate(CAADynamicalTime::UTC2TT(JD), alpha1, delta1, alpha2, delta2, alpha3, delta3, longitude, latitude, -0.5667);
}

void PrintTransit(double JD, CAARiseTransitSetDetails& rise_transit_set)
{
  double transitJD = (JD + (rise_transit_set.Transit / 24.00));
  PrintTime(transitJD, "Transit");
}

void PrintMercuryInfo(double JD, double longitude, double latitude, bool bHighPrecision)
{
  CAARiseTransitSetDetails Mercury_rise_transit_set(GetMercuryRiseTransitSet(JD, longitude, latitude, bHighPrecision));
  PrintTransit(JD, Mercury_rise_transit_set);
}

int main()
{
  double MappedValue = CAACoordinateTransformation::MapTo0To2PIRange(-7);
  UNREFERENCED_PARAMETER(MappedValue);
  MappedValue = CAACoordinateTransformation::MapTo0To2PIRange(-1);
  MappedValue = CAACoordinateTransformation::MapTo0To2PIRange(1);
  MappedValue = CAACoordinateTransformation::MapTo0To2PIRange(2);
  MappedValue = CAACoordinateTransformation::MapTo0To2PIRange(7);

  MappedValue = CAACoordinateTransformation::MapTo0To360Range(-361);
  MappedValue = CAACoordinateTransformation::MapTo0To360Range(-150);
  MappedValue = CAACoordinateTransformation::MapTo0To360Range(-50);
  MappedValue = CAACoordinateTransformation::MapTo0To360Range(50);
  MappedValue = CAACoordinateTransformation::MapTo0To360Range(150);
  MappedValue = CAACoordinateTransformation::MapTo0To360Range(250);
  MappedValue = CAACoordinateTransformation::MapTo0To360Range(370);
  MappedValue = CAACoordinateTransformation::MapTo0To360Range(770);

  MappedValue = CAACoordinateTransformation::MapTo0To24Range(-26);
  MappedValue = CAACoordinateTransformation::MapTo0To24Range(-15);
  MappedValue = CAACoordinateTransformation::MapTo0To24Range(-5);
  MappedValue = CAACoordinateTransformation::MapTo0To24Range(5);
  MappedValue = CAACoordinateTransformation::MapTo0To24Range(15);
  MappedValue = CAACoordinateTransformation::MapTo0To24Range(25);
  MappedValue = CAACoordinateTransformation::MapTo0To24Range(37);
  MappedValue = CAACoordinateTransformation::MapTo0To24Range(77);

  MappedValue = CAACoordinateTransformation::MapToMinus90To90Range(0);
  MappedValue = CAACoordinateTransformation::MapToMinus90To90Range(0.1);
  MappedValue = CAACoordinateTransformation::MapToMinus90To90Range(1);
  MappedValue = CAACoordinateTransformation::MapToMinus90To90Range(7);
  MappedValue = CAACoordinateTransformation::MapToMinus90To90Range(40);
  MappedValue = CAACoordinateTransformation::MapToMinus90To90Range(87);
  MappedValue = CAACoordinateTransformation::MapToMinus90To90Range(90);
  MappedValue = CAACoordinateTransformation::MapToMinus90To90Range(170);
  MappedValue = CAACoordinateTransformation::MapToMinus90To90Range(180);
  MappedValue = CAACoordinateTransformation::MapToMinus90To90Range(185);
  MappedValue = CAACoordinateTransformation::MapToMinus90To90Range(269);
  MappedValue = CAACoordinateTransformation::MapToMinus90To90Range(272);
  MappedValue = CAACoordinateTransformation::MapToMinus90To90Range(360);
  MappedValue = CAACoordinateTransformation::MapToMinus90To90Range(361);
  MappedValue = CAACoordinateTransformation::MapToMinus90To90Range(-361);
  MappedValue = CAACoordinateTransformation::MapToMinus90To90Range(-360);
  MappedValue = CAACoordinateTransformation::MapToMinus90To90Range(-272);
  MappedValue = CAACoordinateTransformation::MapToMinus90To90Range(-269);
  MappedValue = CAACoordinateTransformation::MapToMinus90To90Range(-185);
  MappedValue = CAACoordinateTransformation::MapToMinus90To90Range(-180);
  MappedValue = CAACoordinateTransformation::MapToMinus90To90Range(-170);
  MappedValue = CAACoordinateTransformation::MapToMinus90To90Range(-97);
  MappedValue = CAACoordinateTransformation::MapToMinus90To90Range(-90);
  MappedValue = CAACoordinateTransformation::MapToMinus90To90Range(-87);
  MappedValue = CAACoordinateTransformation::MapToMinus90To90Range(-40);
  MappedValue = CAACoordinateTransformation::MapToMinus90To90Range(-7);
  MappedValue = CAACoordinateTransformation::MapToMinus90To90Range(-1);

  //Print out the rise transit and set times for Mercury for 60 days starting from the 1st of March in 2038.
  double JD = 2465483.5000000000;
  for (int i=0; i<60; ++i)
  {
    PrintMercuryInfo(JD, 0, 0, false);
    PrintMercuryInfo(JD, 0, 0, true);
    JD += 1;
  }

  //Print out the rise transit and set times for the Moon and Sun for each city
  //Date is for October 31, 2012
  long Year = 2012;
  long Month = 10;
  long Day = 31;
  long Hour = 0;
  long Minute = 0;
  double Second = 0;

  //Array for city name
  const char* city_names[] = {"Buenos Aires", "Moscow", "Dublin", "Tampa", "Cape Town", "North Pole", "Tasmania"};

  //Array for longitudes / latitudes {longitude, latitude}
  //east longitude and south latitude are negative values
  double longitudes_latitudes[7][2] = {{58.3817, -34.6036}, {-37.6178, 55.7517}, {6.2661, 53.3428}, {82.4586, 27.9472}, {-18.4244, -33.9767}, {0.0, 90.0}, {-146, -41} };

  //Array for time offsets {time zone. daylight savings}
  int time_offsets[7][2] = { {-3, 0}, {4, 0}, {0, 1}, {-5, 1}, {2, 0}, {0, 0}, {10, 0} };

  //Print out rise and set details for all of the locations
  for (int i=0; i<static_cast<int>(sizeof(city_names)/sizeof(char*)); ++i)
  {
    int time_zone_offset = time_offsets[i][0];
    int daylight_savings = time_offsets[i][1];
    int time_offset = time_zone_offset + daylight_savings;

    PrintSunAndMoonInfo2(city_names[i], Year, Month, Day, time_offset, longitudes_latitudes[i][0], longitudes_latitudes[i][1], false);
    PrintSunAndMoonInfo2(city_names[i], Year, Month, Day, time_offset, longitudes_latitudes[i][0], longitudes_latitudes[i][1], true);
  }


  //Print out the rise transit and set times for the Moon and Sun for Tampa for May 11, 2012
  Year = 2012;
  Month = 5;
  Day = 11;

  //Array for city name
  const char* city_names2[] = {"Tampa"};

  //Array for longitudes / latitudes {longitude, latitude}
  //east longitude and south latitude are negative values
  double longitudes_latitudes2[1][2] = { {82.4586, 27.9472} };

  //Array for time offsets {time zone. daylight savings}
  int time_offsets2[7][2] = { {-5, 1} };

  //Print out rise and set details for all of the locations
  for (int i=0; i<static_cast<int>(sizeof(city_names2)/sizeof(char*)); ++i)
  {
    int time_zone_offset = time_offsets2[i][0];
    int daylight_savings = time_offsets2[i][1];
    int time_offset = time_zone_offset + daylight_savings;

    PrintSunAndMoonInfo2(city_names2[i], Year, Month, Day, time_offset, longitudes_latitudes2[i][0], longitudes_latitudes2[i][1], false);
    PrintSunAndMoonInfo2(city_names2[i], Year, Month, Day, time_offset, longitudes_latitudes2[i][0], longitudes_latitudes2[i][1], true);
  }



  //Print out the rise transit and set times for the Moon and Sun as well as a ASCII graphic of the
  //moon phase for the month of April 2012 for the location of Wexford, Ireland. Thanks to Roger Dahl
  //for providing this nice addition to AA+.
  Year = 2012;
  Month = 4;
  int days_in_month = 30;
  double longitude = 6.5;
  double latitude = 52.5;
  for (int i=1; i <= days_in_month; ++i)
  {
    Day = i;
    PrintSunAndMoonInfo(Year, Month, Day, longitude, latitude, false);
    PrintSunAndMoonInfo(Year, Month, Day, longitude, latitude, true);
  }


  /*
  //Code to write out all the JD of year values from 2012 to 2023
  year = 2012;
  bool bContinue = true;
  while (bContinue)
  {
    CAADate date(year, 1, 1, true);
    double DaysInYear = date.DaysInYear();
    double JD = date.Julian();
    printf("%f\n", JD);
    printf("%f\n", JD + DaysInYear/4);
    printf("%f\n", JD + DaysInYear/2);
    printf("%f\n", JD + DaysInYear*3/4);

    //Prepare for the next loop
    ++year;
    if (year > 2023)
      bContinue = false;
  }
  return 0;
  */

  /*
  //Code to write out the values of UT1-UTC for a specific range
  CAADate Datex(1972, 1, 1, true);
  double JDUT1 = Datex.Julian();
  bool bContinue2 = true;
  while (bContinue2)
  {
    printf("%f\t%f\n", JDUT1, CAADynamicalTime::UT1MinusUTC(JDUT1));

    //Prepare for the next loop
    ++JDUT1;
    if (JDUT1 >= 2460494.000000)
      bContinue2 = false;
  }
  return 0;
  */

  /*
  //Code to write out the values of DeltaT for a specific range
  double JDD = 2441014.5;
  bool bContinue3 = true;
  while (bContinue3)
  {
    double LeapSeconds = CAADynamicalTime::CumulativeLeapSeconds(JDD);
    double TTC = LeapSeconds + 32.184;
    double DeltaT = CAADynamicalTime::DeltaT(JDD);
    CAADate date(JDD, true);
    date.Get(Year, Month, Day, Hour, Minute, Second);
    printf("%04d/%02d/%02d\t%f\t%f\t%f\t%f\t%f\n", Year, Month, Day, JDD, DeltaT, LeapSeconds, TTC, TTC - DeltaT);

    //Prepare for the next loop
    ++JDD;
    if (JDD >= 2460494.000000)
      bContinue3 = false;
  }
  return 0;
  */

  //Calculate the topocentric horizontal position of the Sun for Palomar Observatory on midnight UTC for the 21st of September 2007
  CAADate dateSunCalc(2007, 9, 21, true);
  double JDSun = CAADynamicalTime::UTC2TT(dateSunCalc.Julian());
  double SunLong = CAASun::ApparentEclipticLongitude(JDSun, false);
  double SunLong2 = CAASun::ApparentEclipticLongitude(JDSun, true);
  double SunLat = CAASun::ApparentEclipticLatitude(JDSun, false);
  double SunLat2 = CAASun::ApparentEclipticLatitude(JDSun, true);
  CAA2DCoordinate Equatorial = CAACoordinateTransformation::Ecliptic2Equatorial(SunLong, SunLat, CAANutation::TrueObliquityOfEcliptic(JDSun));
  double SunRad = CAAEarth::RadiusVector(JDSun, false);
  double SunRad2 = CAAEarth::RadiusVector(JDSun, true);
  UNREFERENCED_PARAMETER(SunRad2);
  double Longitude = CAACoordinateTransformation::DMSToDegrees(116, 51, 45); //West is considered positive
  double Latitude = CAACoordinateTransformation::DMSToDegrees(33, 21, 22);
  double Height = 1706;
  CAA2DCoordinate SunTopo = CAAParallax::Equatorial2Topocentric(Equatorial.X, Equatorial.Y, SunRad, Longitude, Latitude, Height, JDSun);
  double AST = CAASidereal::ApparentGreenwichSiderealTime(dateSunCalc.Julian());
  double LongtitudeAsHourAngle = CAACoordinateTransformation::DegreesToHours(Longitude);
  double LocalHourAngle = AST - LongtitudeAsHourAngle - SunTopo.X;
  CAA2DCoordinate SunHorizontal = CAACoordinateTransformation::Equatorial2Horizontal(LocalHourAngle, SunTopo.Y, Latitude);
  SunHorizontal.Y += CAARefraction::RefractionFromTrue(SunHorizontal.Y, 1013, 10);

  //The result above should be that we have a setting Sun at 21 degrees above the horizon at azimuth 14 degrees south of the westerly horizon


  //Calculate the topocentric horizontal position of the Moon for Palomar Observatory on midnight UTC for the 21st of September 2007
  CAADate dateMoonCalc(2007, 9, 21, true);
  double JDMoon = CAADynamicalTime::UTC2TT(dateMoonCalc.Julian());
  double MoonLong = CAAMoon::EclipticLongitude(JDMoon);
  double MoonLat = CAAMoon::EclipticLatitude(JDMoon);
  Equatorial = CAACoordinateTransformation::Ecliptic2Equatorial(MoonLong, MoonLat, CAANutation::TrueObliquityOfEcliptic(JDMoon));
  double MoonRad = CAAMoon::RadiusVector(JDMoon);
  MoonRad /= 149597870.691; //Convert KM to AU
  Longitude = CAACoordinateTransformation::DMSToDegrees(116, 51, 45); //West is considered positive
  Latitude = CAACoordinateTransformation::DMSToDegrees(33, 21, 22);
  Height = 1706;
  CAA2DCoordinate MoonTopo = CAAParallax::Equatorial2Topocentric(Equatorial.X, Equatorial.Y, MoonRad, Longitude, Latitude, Height, JDMoon);
  AST = CAASidereal::ApparentGreenwichSiderealTime(dateMoonCalc.Julian());
  LongtitudeAsHourAngle = CAACoordinateTransformation::DegreesToHours(Longitude);
  LocalHourAngle = AST - LongtitudeAsHourAngle - MoonTopo.X;
  CAA2DCoordinate MoonHorizontal = CAACoordinateTransformation::Equatorial2Horizontal(LocalHourAngle, MoonTopo.Y, Latitude);
  MoonHorizontal.Y += CAARefraction::RefractionFromTrue(MoonHorizontal.Y, 1013, 10);

  //The result above should be that we have a rising Moon at 17 degrees above the horizon at azimuth 38 degrees east of the southern horizon


  //Do a full round trip test on CAADate across a nice wide range. Note we should expect
  //some printfs to appear during this test (Specifically a monotonic error for 15 October 1582)
  double prevJulian = -1;
  for (int YYYY=-4712; YYYY<5000; YYYY++) //Change the end YYYY value if you would like to test a longer range
  {
    if ((YYYY % 1000) == 0)
      printf("Doing date tests on year %d\n", YYYY);
    for (int MMMM=1; MMMM<=12; MMMM++)
    {
      bool bLeap = CAADate::IsLeap(YYYY, (YYYY >= 1582));
      for (int DDDD=1; DDDD<=CAADate::DaysInMonth(MMMM, bLeap); DDDD++)
      {
        bool bGregorian = CAADate::AfterPapalReform(YYYY, MMMM, DDDD);
        CAADate date(YYYY, MMMM, DDDD, 12, 0, 0, bGregorian);
        if ((date.Year() != YYYY) || (date.Month() != MMMM)|| (date.Day() != DDDD))
          printf("Round trip bug with date %d-%d-%d\n", YYYY, MMMM, DDDD);
        double currentJulian = date.Julian();
        if ((prevJulian != -1) && ((prevJulian + 1) != currentJulian))
          printf("Julian Day monotonic bug with date %d-%d-%d\n", YYYY, MMMM, DDDD);
        prevJulian = currentJulian;

        //Only do round trip tests between the Julian and Gregorian calendars after the papal
        //reform. This is because the CAADate class does not support the propalactic Gregorian
        //calendar, while it does fully support the propalactic Julian calendar.
        if (bGregorian)
        {
          CAACalendarDate GregorianDate(CAADate::JulianToGregorian(YYYY, MMMM, DDDD));
          CAACalendarDate JulianDate(CAADate::GregorianToJulian(GregorianDate.Year, GregorianDate.Month, GregorianDate.Day));
          if ((JulianDate.Year != YYYY) || (JulianDate.Month != MMMM)|| (JulianDate.Day != DDDD))
            printf("Round trip bug with Julian -> Gregorian Calendar %d-%d-%d\n", YYYY, MMMM, DDDD);
        }
      }
    }
  }
  printf("Date tests completed\n");

  //Test out the AADate class
  CAADate date;
  date.Set(2000, 1, 1, 12, 1, 2.3, true);
  date.Get(Year, Month, Day, Hour, Minute, Second);
  long DaysInMonth = date.DaysInMonth();
  UNREFERENCED_PARAMETER(DaysInMonth);
  long DaysInYear = date.DaysInYear();
  UNREFERENCED_PARAMETER(DaysInYear);
  bool bLeap = date.Leap();
  UNREFERENCED_PARAMETER(bLeap);
  double Julian = date.Julian();
  UNREFERENCED_PARAMETER(Julian);
  double FractionalYear = date.FractionalYear();
  UNREFERENCED_PARAMETER(FractionalYear);
  double DayOfYear = date.DayOfYear();
  UNREFERENCED_PARAMETER(DayOfYear);
  CAADate::DAY_OF_WEEK dow = date.DayOfWeek();
  UNREFERENCED_PARAMETER(dow);
  Year = date.Year();
  Month = date.Month();
  Day = date.Day();
  Hour = date.Hour();
  Minute = date.Minute();
  Second = date.Second();
  double Julian2 = date;
  UNREFERENCED_PARAMETER(Julian2);

  date.Set(1978, 11, 14, 0, 0, 0, true);
  long DayNumber = static_cast<long>(date.DayOfYear());
  date.DayOfYearToDayAndMonth(DayNumber, date.Leap(), Day, Month);
  Year = date.Year();

  //Test out the AAEaster class
  CAAEasterDetails easterDetails = CAAEaster::Calculate(1991, true);
  UNREFERENCED_PARAMETER(easterDetails);
  CAAEasterDetails easterDetails2 = CAAEaster::Calculate(1818, true);
  UNREFERENCED_PARAMETER(easterDetails2);
  CAAEasterDetails easterDetails3 = CAAEaster::Calculate(179, false);
  UNREFERENCED_PARAMETER(easterDetails3);

  //Test out the AADynamicalTime class
  date.Set(1977, 2, 18, 3, 37, 40, true);
  double DeltaT = CAADynamicalTime::DeltaT(date.Julian());
  date.Set(333, 2, 6, 6, 0, 0, false);
  DeltaT = CAADynamicalTime::DeltaT(date.Julian());
  UNREFERENCED_PARAMETER(DeltaT);

  //Test out the AAGlobe class
  double rhosintheta = CAAGlobe::RhoSinThetaPrime(33.356111, 1706);
  UNREFERENCED_PARAMETER(rhosintheta);
  double rhocostheta = CAAGlobe::RhoCosThetaPrime(33.356111, 1706);
  UNREFERENCED_PARAMETER(rhocostheta);
  double RadiusOfLatitude = CAAGlobe::RadiusOfParallelOfLatitude(42);
  UNREFERENCED_PARAMETER(RadiusOfLatitude);
  double RadiusOfCurvature = CAAGlobe::RadiusOfCurvature(42);
  UNREFERENCED_PARAMETER(RadiusOfCurvature);
  double Distance = CAAGlobe::DistanceBetweenPoints(CAACoordinateTransformation::DMSToDegrees(48, 50, 11), CAACoordinateTransformation::DMSToDegrees(2, 20, 14, false),
                                                    CAACoordinateTransformation::DMSToDegrees(38, 55, 17), CAACoordinateTransformation::DMSToDegrees(77, 3, 56));
  UNREFERENCED_PARAMETER(Distance);


  double Distance1 = CAAGlobe::DistanceBetweenPoints(50, 0, 50, 60);
  UNREFERENCED_PARAMETER(Distance1);
  double Distance2 = CAAGlobe::DistanceBetweenPoints(50, 0, 50, 1);
  UNREFERENCED_PARAMETER(Distance2);
  double Distance3 = CAAGlobe::DistanceBetweenPoints(CAACoordinateTransformation::DMSToDegrees(89, 59, 0), 0, CAACoordinateTransformation::DMSToDegrees(89, 59, 0), 1);
  UNREFERENCED_PARAMETER(Distance3);
  double Distance4 = CAAGlobe::DistanceBetweenPoints(CAACoordinateTransformation::DMSToDegrees(89, 59, 0), 0, CAACoordinateTransformation::DMSToDegrees(89, 59, 0), 180);
  UNREFERENCED_PARAMETER(Distance4);
  double Distance5 = CAAGlobe::DistanceBetweenPoints(CAACoordinateTransformation::DMSToDegrees(89, 59, 0), 0, CAACoordinateTransformation::DMSToDegrees(89, 59, 0), 90);
  UNREFERENCED_PARAMETER(Distance5);


  //Test out the AASidereal class
  date.Set(1987, 4, 10, 0, 0, 0, true);
  double MST = CAASidereal::MeanGreenwichSiderealTime(date.Julian());
  AST = CAASidereal::ApparentGreenwichSiderealTime(date.Julian());
  UNREFERENCED_PARAMETER(AST);
  date.Set(1987, 4, 10, 19, 21, 0, true);
  MST = CAASidereal::MeanGreenwichSiderealTime(date.Julian());
  UNREFERENCED_PARAMETER(MST);

  //Test out the AACoordinateTransformation class
  CAA2DCoordinate Ecliptic = CAACoordinateTransformation::Equatorial2Ecliptic(CAACoordinateTransformation::DMSToDegrees(7, 45, 18.946), CAACoordinateTransformation::DMSToDegrees(28, 01, 34.26), 23.4392911);
  Equatorial = CAACoordinateTransformation::Ecliptic2Equatorial(Ecliptic.X, Ecliptic.Y, 23.4392911);
  CAA2DCoordinate Galactic = CAACoordinateTransformation::Equatorial2Galactic(CAACoordinateTransformation::DMSToDegrees(17, 48, 59.74), CAACoordinateTransformation::DMSToDegrees(14, 43, 8.2, false));
  CAA2DCoordinate Equatorial2 = CAACoordinateTransformation::Galactic2Equatorial(Galactic.X, Galactic.Y);
  UNREFERENCED_PARAMETER(Equatorial2);
  date.Set(1987, 4, 10, 19, 21, 0, true);
  AST = CAASidereal::ApparentGreenwichSiderealTime(date.Julian());
  LongtitudeAsHourAngle = CAACoordinateTransformation::DegreesToHours(CAACoordinateTransformation::DMSToDegrees(77, 3, 56));
  double Alpha = CAACoordinateTransformation::DMSToDegrees(23, 9, 16.641);
  LocalHourAngle = AST - LongtitudeAsHourAngle - Alpha;
  CAA2DCoordinate Horizontal = CAACoordinateTransformation::Equatorial2Horizontal(LocalHourAngle, CAACoordinateTransformation::DMSToDegrees(6, 43, 11.61, false), CAACoordinateTransformation::DMSToDegrees(38, 55, 17));
  CAA2DCoordinate Equatorial3 = CAACoordinateTransformation::Horizontal2Equatorial(Horizontal.X, Horizontal.Y, CAACoordinateTransformation::DMSToDegrees(38, 55, 17));
  double alpha2 = CAACoordinateTransformation::MapTo0To24Range(AST - Equatorial3.X - LongtitudeAsHourAngle);
  UNREFERENCED_PARAMETER(alpha2);

  //Test out the CAANutation class (on its own)
  date.Set(1987, 4, 10, 0, 0, 0, true);
  double Obliquity = CAANutation::MeanObliquityOfEcliptic(date.Julian());
  UNREFERENCED_PARAMETER(Obliquity);
  double NutationInLongitude = CAANutation::NutationInLongitude(date.Julian());
  UNREFERENCED_PARAMETER(NutationInLongitude);
  double NutationInEcliptic = CAANutation::NutationInObliquity(date.Julian());
  UNREFERENCED_PARAMETER(NutationInEcliptic);

  //Test out the CAAParallactic class
  double HourAngle = CAAParallactic::ParallacticAngle(-3, 10, 20);
  UNREFERENCED_PARAMETER(HourAngle);
  double EclipticLongitude = CAAParallactic::EclipticLongitudeOnHorizon(5, 23.44, 51);
  UNREFERENCED_PARAMETER(EclipticLongitude);
  double EclipticAngle = CAAParallactic::AngleBetweenEclipticAndHorizon(5, 23.44, 51);
  UNREFERENCED_PARAMETER(EclipticAngle);
  double Angle = CAAParallactic::AngleBetweenNorthCelestialPoleAndNorthPoleOfEcliptic(90, 0, 23.44);
  UNREFERENCED_PARAMETER(Angle);

  //Test out the CAARefraction class
  double R1 = CAARefraction::RefractionFromApparent(0.5);
  double R2 = CAARefraction::RefractionFromTrue(0.5 - R1 + CAACoordinateTransformation::DMSToDegrees(0, 32, 0));
  UNREFERENCED_PARAMETER(R2);
  double R3 = CAARefraction::RefractionFromApparent(90);
  UNREFERENCED_PARAMETER(R3);

  //Test out the CAAAngularSeparation class
  double AngularSeparation = CAAAngularSeparation::Separation(CAACoordinateTransformation::DMSToDegrees(14, 15, 39.7), CAACoordinateTransformation::DMSToDegrees(19, 10, 57),
                                                              CAACoordinateTransformation::DMSToDegrees(13, 25, 11.6), CAACoordinateTransformation::DMSToDegrees(11, 9, 41, false));
  UNREFERENCED_PARAMETER(AngularSeparation);
  double AngularSeparation2 = CAAAngularSeparation::Separation(CAACoordinateTransformation::DMSToDegrees(2, 0, 0), CAACoordinateTransformation::DMSToDegrees(0, 0, 0),
                                                               CAACoordinateTransformation::DMSToDegrees(2, 0, 0), CAACoordinateTransformation::DMSToDegrees(0, 0, 0));
  UNREFERENCED_PARAMETER(AngularSeparation2);
  double AngularSeparation3 = CAAAngularSeparation::Separation(CAACoordinateTransformation::DMSToDegrees(2, 0, 0), CAACoordinateTransformation::DMSToDegrees(0, 0, 0),
                                                               CAACoordinateTransformation::DMSToDegrees(14, 0, 0), CAACoordinateTransformation::DMSToDegrees(0, 0, 0));
  UNREFERENCED_PARAMETER(AngularSeparation3);

  double PA0 = CAAAngularSeparation::PositionAngle(CAACoordinateTransformation::DMSToDegrees(5, 32, 0.4), CAACoordinateTransformation::DMSToDegrees(0, 17, 56.9, false),
                                                               CAACoordinateTransformation::DMSToDegrees(5, 36, 12.81), CAACoordinateTransformation::DMSToDegrees(1, 12, 7, false));
  UNREFERENCED_PARAMETER(PA0);

  double PA1 = CAAAngularSeparation::PositionAngle(CAACoordinateTransformation::DMSToDegrees(5, 40, 45.52), CAACoordinateTransformation::DMSToDegrees(1, 56, 33.3, false),
                                                               CAACoordinateTransformation::DMSToDegrees(5, 36, 12.81), CAACoordinateTransformation::DMSToDegrees(1, 12, 7, false));
  UNREFERENCED_PARAMETER(PA1);


  double distance = CAAAngularSeparation::DistanceFromGreatArc(CAACoordinateTransformation::DMSToDegrees(5, 32, 0.4), CAACoordinateTransformation::DMSToDegrees(0, 17, 56.9, false),
                                                               CAACoordinateTransformation::DMSToDegrees(5, 40, 45.52), CAACoordinateTransformation::DMSToDegrees(1, 56, 33.3, false),
                                                               CAACoordinateTransformation::DMSToDegrees(5, 36, 12.81), CAACoordinateTransformation::DMSToDegrees(1, 12, 7, false));
  UNREFERENCED_PARAMETER(distance);

  bool bType1;
  double separation = CAAAngularSeparation::SmallestCircle(CAACoordinateTransformation::DMSToDegrees(12, 41, 8.63), CAACoordinateTransformation::DMSToDegrees(5, 37, 54.2, false),
                                                           CAACoordinateTransformation::DMSToDegrees(12, 52, 5.21), CAACoordinateTransformation::DMSToDegrees(4, 22, 26.2, false),
                                                           CAACoordinateTransformation::DMSToDegrees(12, 39, 28.11), CAACoordinateTransformation::DMSToDegrees(1, 50, 3.7, false), bType1);

  separation = CAAAngularSeparation::SmallestCircle(CAACoordinateTransformation::DMSToDegrees(9, 5, 41.44), CAACoordinateTransformation::DMSToDegrees(18, 30, 30),
                                                    CAACoordinateTransformation::DMSToDegrees(9, 9, 29), CAACoordinateTransformation::DMSToDegrees(17, 43, 56.7),
                                                    CAACoordinateTransformation::DMSToDegrees(8, 59, 47.14), CAACoordinateTransformation::DMSToDegrees(17, 49, 36.8), bType1);
  UNREFERENCED_PARAMETER(separation);

  Alpha = CAACoordinateTransformation::DMSToDegrees(2, 44, 11.986);
  double Delta = CAACoordinateTransformation::DMSToDegrees(49, 13, 42.48);
  CAA2DCoordinate PA = CAAPrecession::AdjustPositionUsingUniformProperMotion((2462088.69-2451545)/365.25, Alpha, Delta, 0.03425, -0.0895);

  CAA2DCoordinate Precessed = CAAPrecession::PrecessEquatorial(PA.X, PA.Y, 2451545, 2462088.69);
  UNREFERENCED_PARAMETER(Precessed);

  Alpha = CAACoordinateTransformation::DMSToDegrees(2, 31, 48.704);
  Delta = CAACoordinateTransformation::DMSToDegrees(89, 15, 50.72);
  CAA2DCoordinate PA2 = CAAPrecession::AdjustPositionUsingUniformProperMotion((2415020.3135-2451545)/365.25, Alpha, Delta, 0.19877, -0.0152);
  //CAA2DCoordinate Precessed2 = CAAPrecession::PrecessEquatorialFK4(PA2.X, PA2.Y, 2451545, 2415020.3135);
  UNREFERENCED_PARAMETER(PA2);

  CAA2DCoordinate PM = CAAPrecession::EquatorialPMToEcliptic(0, 0, 0, 1, 1, 23);
  UNREFERENCED_PARAMETER(PM);


  CAA2DCoordinate PA3 = CAAPrecession::AdjustPositionUsingMotionInSpace(2.64, -7.6, -1000, CAACoordinateTransformation::DMSToDegrees(6, 45, 8.871), CAACoordinateTransformation::DMSToDegrees(16, 42, 57.99, false), -0.03847, -1.2053);
  UNREFERENCED_PARAMETER(PA3);
  CAA2DCoordinate PA4 = CAAPrecession::AdjustPositionUsingUniformProperMotion(-1000, CAACoordinateTransformation::DMSToDegrees(6, 45, 8.871), CAACoordinateTransformation::DMSToDegrees(16, 42, 57.99, false), -0.03847, -1.2053);
  UNREFERENCED_PARAMETER(PA4);

  CAA2DCoordinate PA5 = CAAPrecession::AdjustPositionUsingMotionInSpace(2.64, -7.6, -12000, CAACoordinateTransformation::DMSToDegrees(6, 45, 8.871), CAACoordinateTransformation::DMSToDegrees(16, 42, 57.99, false), -0.03847, -1.2053);
  UNREFERENCED_PARAMETER(PA5);
  CAA2DCoordinate PA6 = CAAPrecession::AdjustPositionUsingUniformProperMotion(-12000, CAACoordinateTransformation::DMSToDegrees(6, 45, 8.871), CAACoordinateTransformation::DMSToDegrees(16, 42, 57.99, false), -0.03847, -1.2053);
  UNREFERENCED_PARAMETER(PA6);

  Alpha = CAACoordinateTransformation::DMSToDegrees(2, 44, 11.986);
  Delta = CAACoordinateTransformation::DMSToDegrees(49, 13, 42.48);
  CAA2DCoordinate PA7 = CAAPrecession::AdjustPositionUsingUniformProperMotion((2462088.69-2451545)/365.25, Alpha, Delta, 0.03425, -0.0895);
  CAA3DCoordinate EarthVelocity = CAAAberration::EarthVelocity(2462088.69, false);
  UNREFERENCED_PARAMETER(EarthVelocity);
  CAA3DCoordinate EarthVelocity2 = CAAAberration::EarthVelocity(2462088.69, true);
  UNREFERENCED_PARAMETER(EarthVelocity2);
  CAA2DCoordinate Aberration = CAAAberration::EquatorialAberration(PA7.X, PA7.Y, 2462088.69, false);
  PA7.X += Aberration.X;
  PA7.Y += Aberration.Y;
  CAA2DCoordinate Aberration2 = CAAAberration::EquatorialAberration(PA7.X, PA7.Y, 2462088.69, true);
  UNREFERENCED_PARAMETER(Aberration2);
  PA7 = CAAPrecession::PrecessEquatorial(PA7.X, PA7.Y, 2451545, 2462088.69);

  Obliquity = CAANutation::MeanObliquityOfEcliptic(2462088.69);
  NutationInLongitude = CAANutation::NutationInLongitude(2462088.69);
  NutationInEcliptic = CAANutation::NutationInObliquity(2462088.69);
  double AlphaNutation = CAANutation::NutationInRightAscension(PA7.X, PA7.Y, Obliquity, NutationInLongitude, NutationInEcliptic);
  double DeltaNutation = CAANutation::NutationInDeclination(PA7.X, Obliquity, NutationInLongitude, NutationInEcliptic);
  PA7.X += CAACoordinateTransformation::DMSToDegrees(0, 0, AlphaNutation/15);
  PA7.Y += CAACoordinateTransformation::DMSToDegrees(0, 0, DeltaNutation);


  //Try out the AA kepler class
  double E0 = CAAKepler::Calculate(5, 0.1, 100);
  UNREFERENCED_PARAMETER(E0);
  double E02 = CAAKepler::Calculate(5, 0.9, 100);
  UNREFERENCED_PARAMETER(E02);
  //double E03 = CAAKepler::Calculate(


  //Try out the binary star class
  CAABinaryStarDetails bsdetails = CAABinaryStar::Calculate(1980, 41.623, 1934.008, 0.2763, 0.907, 59.025, 23.717, 219.907);
  UNREFERENCED_PARAMETER(bsdetails);
  double ApparentE = CAABinaryStar::ApparentEccentricity(0.2763, 59.025, 219.907);
  UNREFERENCED_PARAMETER(ApparentE);


  //Test out the CAAStellarMagnitudes class
  double CombinedMag = CAAStellarMagnitudes::CombinedMagnitude(1.96, 2.89);
  UNREFERENCED_PARAMETER(CombinedMag);
  double Mags[] = { 4.73, 5.22, 5.60 };
  double CombinedMag2 = CAAStellarMagnitudes::CombinedMagnitude(3, Mags);
  UNREFERENCED_PARAMETER(CombinedMag2);
  double BrightnessRatio = CAAStellarMagnitudes::BrightnessRatio(0.14, 2.12);
  double MagDiff = CAAStellarMagnitudes::MagnitudeDifference(BrightnessRatio);
  UNREFERENCED_PARAMETER(MagDiff);
  double MagDiff2 = CAAStellarMagnitudes::MagnitudeDifference(500);
  UNREFERENCED_PARAMETER(MagDiff2);


  //Test out the CAAVenus class
  double VenusLong = CAAVenus::EclipticLongitude(2448976.5, false);
  UNREFERENCED_PARAMETER(VenusLong);
  double VenusLong2 = CAAVenus::EclipticLongitude(2448976.5, true);
  UNREFERENCED_PARAMETER(VenusLong2);
  double VenusLat = CAAVenus::EclipticLatitude(2448976.5, false);
  UNREFERENCED_PARAMETER(VenusLat);
  double VenusLat2 = CAAVenus::EclipticLatitude(2448976.5, true);
  UNREFERENCED_PARAMETER(VenusLat2);
  double VenusRadius = CAAVenus::RadiusVector(2448976.5, false);
  UNREFERENCED_PARAMETER(VenusRadius);
  double VenusRadius2 = CAAVenus::RadiusVector(2448976.5, true);
  UNREFERENCED_PARAMETER(VenusRadius2);


  //Test out the CAAMercury class
  double MercuryLong = CAAMercury::EclipticLongitude(2448976.5, false);
  UNREFERENCED_PARAMETER(MercuryLong);
  double MercuryLong2 = CAAMercury::EclipticLongitude(2448976.5, true);
  UNREFERENCED_PARAMETER(MercuryLong2);
  double MercuryLat = CAAMercury::EclipticLatitude(2448976.5, false);
  UNREFERENCED_PARAMETER(MercuryLat);
  double MercuryLat2 = CAAMercury::EclipticLatitude(2448976.5, true);
  UNREFERENCED_PARAMETER(MercuryLat2);
  double MercuryRadius = CAAMercury::RadiusVector(2448976.5, false);
  UNREFERENCED_PARAMETER(MercuryRadius);
  double MercuryRadius2 = CAAMercury::RadiusVector(2448976.5, true);
  UNREFERENCED_PARAMETER(MercuryRadius2);


  //Test out the CAAEarth class
  double EarthLong = CAAEarth::EclipticLongitude(2448908.5, false);
  UNREFERENCED_PARAMETER(EarthLong);
  double EarthLong2 = CAAEarth::EclipticLongitude(2448908.5, true);
  UNREFERENCED_PARAMETER(EarthLong2);
  double EarthLat = CAAEarth::EclipticLatitude(2448908.5, false);
  UNREFERENCED_PARAMETER(EarthLat);
  double EarthLat2 = CAAEarth::EclipticLatitude(2448908.5, true);
  UNREFERENCED_PARAMETER(EarthLat2);
  double EarthRadius = CAAEarth::RadiusVector(2448908.5, false);
  UNREFERENCED_PARAMETER(EarthRadius);
  double EarthRadius2 = CAAEarth::RadiusVector(2448908.5, true);
  UNREFERENCED_PARAMETER(EarthRadius2);

  double EarthLong3 = CAAEarth::EclipticLongitudeJ2000(2448908.5, false);
  UNREFERENCED_PARAMETER(EarthLong3);
  double EarthLong4 = CAAEarth::EclipticLongitudeJ2000(2448908.5, true);
  UNREFERENCED_PARAMETER(EarthLong4);
  double EarthLat3 = CAAEarth::EclipticLatitudeJ2000(2448908.5, false);
  UNREFERENCED_PARAMETER(EarthLat3);
  double EarthLat4 = CAAEarth::EclipticLatitudeJ2000(2448908.5, true);
  UNREFERENCED_PARAMETER(EarthLat4);


  //Test out the CAASun class
  SunLong = CAASun::GeometricEclipticLongitude(2448908.5, false);
  SunLong2 = CAASun::GeometricEclipticLongitude(2448908.5, true);
  UNREFERENCED_PARAMETER(SunLong2);
  SunLat = CAASun::GeometricEclipticLatitude(2448908.5, false);
  SunLat2 = CAASun::GeometricEclipticLatitude(2448908.5, true);
  UNREFERENCED_PARAMETER(SunLat2);

  double SunLongCorrection = CAAFK5::CorrectionInLongitude(SunLong, SunLat, 2448908.5);
  UNREFERENCED_PARAMETER(SunLongCorrection);
  double SunLatCorrection = CAAFK5::CorrectionInLatitude(SunLong, 2448908.5);
  UNREFERENCED_PARAMETER(SunLatCorrection);

  SunLong = CAASun::ApparentEclipticLongitude(2448908.5, false);
  SunLong2 = CAASun::ApparentEclipticLongitude(2448908.5, true);
  SunLat = CAASun::ApparentEclipticLatitude(2448908.5, false);
  SunLat2 = CAASun::ApparentEclipticLatitude(2448908.5, true);
  Equatorial = CAACoordinateTransformation::Ecliptic2Equatorial(SunLong, SunLat, CAANutation::TrueObliquityOfEcliptic(2448908.5));

  CAA3DCoordinate SunCoord = CAASun::EquatorialRectangularCoordinatesMeanEquinox(2448908.5, false);
  UNREFERENCED_PARAMETER(SunCoord);
  CAA3DCoordinate SunCoord2 = CAASun::EquatorialRectangularCoordinatesMeanEquinox(2448908.5, true);
  UNREFERENCED_PARAMETER(SunCoord2);
  CAA3DCoordinate SunCoord3 = CAASun::EquatorialRectangularCoordinatesJ2000(2448908.5, false);
  UNREFERENCED_PARAMETER(SunCoord3);
  CAA3DCoordinate SunCoord4 = CAASun::EquatorialRectangularCoordinatesJ2000(2448908.5, true);
  UNREFERENCED_PARAMETER(SunCoord4);
  CAA3DCoordinate SunCoord5 = CAASun::EquatorialRectangularCoordinatesAnyEquinox(2448908.5, 2467616.0, false);
  UNREFERENCED_PARAMETER(SunCoord5);
  CAA3DCoordinate SunCoord6 = CAASun::EquatorialRectangularCoordinatesAnyEquinox(2448908.5, 2467616.0, true);
  UNREFERENCED_PARAMETER(SunCoord6);
  CAA3DCoordinate SunCoord7 = CAASun::EquatorialRectangularCoordinatesMeanEquinox(2448908.5, false);
  UNREFERENCED_PARAMETER(SunCoord7);
  CAA3DCoordinate SunCoord8 = CAASun::EquatorialRectangularCoordinatesMeanEquinox(2448908.5, true);
  UNREFERENCED_PARAMETER(SunCoord8);
  CAA3DCoordinate SunCoord9 = CAASun::EquatorialRectangularCoordinatesB1950(2448908.5, false);
  UNREFERENCED_PARAMETER(SunCoord9);
  CAA3DCoordinate SunCoord10 = CAASun::EquatorialRectangularCoordinatesB1950(2448908.5, true);
  UNREFERENCED_PARAMETER(SunCoord10);


  //Test out the CAAMars class
  double MarsLong = CAAMars::EclipticLongitude(2448935.500683, false);
  UNREFERENCED_PARAMETER(MarsLong);
  double MarsLong2 = CAAMars::EclipticLongitude(2448935.500683, true);
  UNREFERENCED_PARAMETER(MarsLong2);
  double MarsLat = CAAMars::EclipticLatitude(2448935.500683, false);
  UNREFERENCED_PARAMETER(MarsLat);
  double MarsLat2 = CAAMars::EclipticLatitude(2448935.500683, true);
  UNREFERENCED_PARAMETER(MarsLat2);
  double MarsRadius = CAAMars::RadiusVector(2448935.500683, false);
  UNREFERENCED_PARAMETER(MarsRadius);
  double MarsRadius2 = CAAMars::RadiusVector(2448935.500683, true);
  UNREFERENCED_PARAMETER(MarsRadius2);


  //Test out the CAAJupiter class
  double JupiterLong = CAAJupiter::EclipticLongitude(2448972.50068, false);
  UNREFERENCED_PARAMETER(JupiterLong);
  double JupiterLong2 = CAAJupiter::EclipticLongitude(2448972.50068, true);
  UNREFERENCED_PARAMETER(JupiterLong2);
  double JupiterLat = CAAJupiter::EclipticLatitude(2448972.50068, false);
  UNREFERENCED_PARAMETER(JupiterLat);
  double JupiterLat2 = CAAJupiter::EclipticLatitude(2448972.50068, true);
  UNREFERENCED_PARAMETER(JupiterLat2);
  double JupiterRadius = CAAJupiter::RadiusVector(2448972.50068, false);
  UNREFERENCED_PARAMETER(JupiterRadius);
  double JupiterRadius2 = CAAJupiter::RadiusVector(2448972.50068, true);
  UNREFERENCED_PARAMETER(JupiterRadius2);


  //Test out the CAANeptune class
  double NeptuneLong = CAANeptune::EclipticLongitude(2448935.500683, false);
  UNREFERENCED_PARAMETER(NeptuneLong);
  double NeptuneLong2 = CAANeptune::EclipticLongitude(2448935.500683, true);
  UNREFERENCED_PARAMETER(NeptuneLong2);
  double NeptuneLat = CAANeptune::EclipticLatitude(2448935.500683, false);
  UNREFERENCED_PARAMETER(NeptuneLat);
  double NeptuneLat2 = CAANeptune::EclipticLatitude(2448935.500683, true);
  UNREFERENCED_PARAMETER(NeptuneLat2);
  double NeptuneRadius = CAANeptune::RadiusVector(2448935.500683, false);
  UNREFERENCED_PARAMETER(NeptuneRadius);
  double NeptuneRadius2 = CAANeptune::RadiusVector(2448935.500683, true);
  UNREFERENCED_PARAMETER(NeptuneRadius2);


  //Test out the CAAUranus class
  double UranusLong = CAAUranus::EclipticLongitude(2448976.5, false);
  UNREFERENCED_PARAMETER(UranusLong);
  double UranusLong2 = CAAUranus::EclipticLongitude(2448976.5, true);
  UNREFERENCED_PARAMETER(UranusLong2);
  double UranusLat = CAAUranus::EclipticLatitude(2448976.5, false);
  UNREFERENCED_PARAMETER(UranusLat);
  double UranusLat2 = CAAUranus::EclipticLatitude(2448976.5, true);
  UNREFERENCED_PARAMETER(UranusLat2);
  double UranusRadius = CAAUranus::RadiusVector(2448976.5, false);
  UNREFERENCED_PARAMETER(UranusRadius);
  double UranusRadius2 = CAAUranus::RadiusVector(2448976.5, true);
  UNREFERENCED_PARAMETER(UranusRadius2);


  //Test out the CAASaturn class
  double SaturnLong = CAASaturn::EclipticLongitude(2448972.50068, false);
  UNREFERENCED_PARAMETER(SaturnLong);
  double SaturnLong2 = CAASaturn::EclipticLongitude(2448972.50068, true);
  UNREFERENCED_PARAMETER(SaturnLong2);
  double SaturnLat = CAASaturn::EclipticLatitude(2448972.50068, false);
  UNREFERENCED_PARAMETER(SaturnLat);
  double SaturnLat2 = CAASaturn::EclipticLatitude(2448972.50068, true);
  UNREFERENCED_PARAMETER(SaturnLat2);
  double SaturnRadius = CAASaturn::RadiusVector(2448972.50068, false);
  UNREFERENCED_PARAMETER(SaturnRadius);
  double SaturnRadius2 = CAASaturn::RadiusVector(2448972.50068, true);
  UNREFERENCED_PARAMETER(SaturnRadius2);

  SaturnLong = CAASaturn::EclipticLongitude(2451385.5, false);
  SaturnLong2 = CAASaturn::EclipticLongitude(2451385.5, true);
  SaturnLat = CAASaturn::EclipticLatitude(2451385.5, false);
  SaturnLat2 = CAASaturn::EclipticLatitude(2451385.5, true);
  SaturnRadius = CAASaturn::RadiusVector(2451385.5, false);
  SaturnRadius2 = CAASaturn::RadiusVector(2451385.5, true);



  //Test out the CAAPluto class
  double PlutoLong = CAAPluto::EclipticLongitude(2448908.5);
  UNREFERENCED_PARAMETER(PlutoLong);
  double PlutoLat = CAAPluto::EclipticLatitude(2448908.5);
  UNREFERENCED_PARAMETER(PlutoLat);
  double PlutoRadius = CAAPluto::RadiusVector(2448908.5);
  UNREFERENCED_PARAMETER(PlutoRadius);


  //Test out the CAAMoon class
  MoonLong = CAAMoon::EclipticLongitude(2448724.5);
  MoonLat = CAAMoon::EclipticLatitude(2448724.5);
  double MoonRadius = CAAMoon::RadiusVector(2448724.5);
  double MoonParallax = CAAMoon::RadiusVectorToHorizontalParallax(MoonRadius);
  UNREFERENCED_PARAMETER(MoonParallax);
  double MoonMeanAscendingNode = CAAMoon::MeanLongitudeAscendingNode(2448724.5);
  UNREFERENCED_PARAMETER(MoonMeanAscendingNode);
  double TrueMeanAscendingNode = CAAMoon::TrueLongitudeAscendingNode(2448724.5);
  UNREFERENCED_PARAMETER(TrueMeanAscendingNode);
  double MoonMeanPerigee = CAAMoon::MeanLongitudePerigee(2448724.5);
  UNREFERENCED_PARAMETER(MoonMeanPerigee);

  //Test out the CAAPlanetPerihelionAphelion class
  long VenusK = CAAPlanetPerihelionAphelion::VenusK(1978.79);
  double VenusPerihelion = CAAPlanetPerihelionAphelion::VenusPerihelion(VenusK);
  UNREFERENCED_PARAMETER(VenusPerihelion);

  long MarsK = CAAPlanetPerihelionAphelion::MarsK(2032);
  double MarsAphelion = CAAPlanetPerihelionAphelion::MarsAphelion(MarsK);
  UNREFERENCED_PARAMETER(MarsAphelion);

  long SaturnK = CAAPlanetPerihelionAphelion::SaturnK(1925);
  double SaturnAphelion = CAAPlanetPerihelionAphelion::SaturnAphelion(SaturnK);
  UNREFERENCED_PARAMETER(SaturnAphelion);
  SaturnK = CAAPlanetPerihelionAphelion::SaturnK(1940);
  double SaturnPerihelion = CAAPlanetPerihelionAphelion::SaturnPerihelion(SaturnK);
  UNREFERENCED_PARAMETER(SaturnPerihelion);

  long UranusK = CAAPlanetPerihelionAphelion::UranusK(1750);
  double UranusAphelion = CAAPlanetPerihelionAphelion::UranusAphelion(UranusK);
  UNREFERENCED_PARAMETER(UranusAphelion);
  UranusK = CAAPlanetPerihelionAphelion::UranusK(1890);
  double UranusPerihelion = CAAPlanetPerihelionAphelion::UranusPerihelion(UranusK);
  UranusK = CAAPlanetPerihelionAphelion::UranusK(2060);
  UranusPerihelion = CAAPlanetPerihelionAphelion::UranusPerihelion(UranusK);
  UNREFERENCED_PARAMETER(UranusPerihelion);

  double EarthPerihelion = CAAPlanetPerihelionAphelion::EarthPerihelion(-10, true);
  UNREFERENCED_PARAMETER(EarthPerihelion);
  double EarthPerihelion2 = CAAPlanetPerihelionAphelion::EarthPerihelion(-10, false);
  UNREFERENCED_PARAMETER(EarthPerihelion2);


  //Test out the CAAMoonPerigeeApogee
  double MoonK = CAAMoonPerigeeApogee::K(1988.75);
  double MoonApogee = CAAMoonPerigeeApogee::MeanApogee(-148.5);
  UNREFERENCED_PARAMETER(MoonApogee);
  double MoonApogee2 = CAAMoonPerigeeApogee::TrueApogee(-148.5);
  UNREFERENCED_PARAMETER(MoonApogee2);
  double MoonApogeeParallax = CAAMoonPerigeeApogee::ApogeeParallax(-148.5);
  double MoonApogeeDistance = CAAMoon::HorizontalParallaxToRadiusVector(MoonApogeeParallax);
  UNREFERENCED_PARAMETER(MoonApogeeDistance);
  MoonK = CAAMoonPerigeeApogee::K(2015 + 9.0/12);
  MoonApogee = CAAMoonPerigeeApogee::MeanApogee(208.5); //Corresponds to Moon Apogee around September 2015
  MoonApogee = CAADynamicalTime::TT2UTC(MoonApogee);
  MoonApogee2 = CAAMoonPerigeeApogee::TrueApogee(208.5);
  MoonApogee2 = CAADynamicalTime::TT2UTC(MoonApogee2);
  MoonApogeeParallax = CAAMoonPerigeeApogee::ApogeeParallax(208.5);
  MoonApogeeDistance = CAAMoon::HorizontalParallaxToRadiusVector(MoonApogeeParallax);
  MoonK = CAAMoonPerigeeApogee::K(1990.9);
  double MoonPerigee = CAAMoonPerigeeApogee::MeanPerigee(-120);
  UNREFERENCED_PARAMETER(MoonPerigee);
  double MoonPerigee2 = CAAMoonPerigeeApogee::TruePerigee(-120);
  UNREFERENCED_PARAMETER(MoonPerigee2);
  MoonK = CAAMoonPerigeeApogee::K(1930.0);
  UNREFERENCED_PARAMETER(MoonK);
  double MoonPerigee3 = CAAMoonPerigeeApogee::TruePerigee(-927);
  UNREFERENCED_PARAMETER(MoonPerigee3);
  double MoonPerigeeParallax = CAAMoonPerigeeApogee::PerigeeParallax(-927);
  double MoonRadiusVector = CAAMoon::HorizontalParallaxToRadiusVector(MoonPerigeeParallax);
  UNREFERENCED_PARAMETER(MoonRadiusVector);
  double MoonRadiusVector2 = CAAMoon::HorizontalParallaxToRadiusVector(0.991990);
  double MoonParallax2 = CAAMoon::RadiusVectorToHorizontalParallax(MoonRadiusVector2);
  UNREFERENCED_PARAMETER(MoonParallax2);


  //Test out the CAAEclipticalElements class
  CAAEclipticalElementDetails ed1 = CAAEclipticalElements::Calculate(47.1220, 151.4486, 45.7481, 2358042.5305, 2433282.4235);
  UNREFERENCED_PARAMETER(ed1);
  CAAEclipticalElementDetails ed2 = CAAEclipticalElements::Calculate(11.93911, 186.24444, 334.04096, 2433282.4235, 2451545.0);
  UNREFERENCED_PARAMETER(ed2);
  CAAEclipticalElementDetails ed3 = CAAEclipticalElements::FK4B1950ToFK5J2000(11.93911, 186.24444, 334.04096);
  UNREFERENCED_PARAMETER(ed3);
  CAAEclipticalElementDetails ed4 = CAAEclipticalElements::FK4B1950ToFK5J2000(145, 186.24444, 334.04096);
  UNREFERENCED_PARAMETER(ed4);


  //Test out the CAAEquationOfTime class
  double E = CAAEquationOfTime::Calculate(2448908.5, false);
  UNREFERENCED_PARAMETER(E);
  double E2 = CAAEquationOfTime::Calculate(2448908.5, true);
  UNREFERENCED_PARAMETER(E2);


  //Test out the CAAPhysicalSun class
  CAAPhysicalSunDetails psd = CAAPhysicalSun::Calculate(2448908.50068, false);
  UNREFERENCED_PARAMETER(psd);
  CAAPhysicalSunDetails psd2 = CAAPhysicalSun::Calculate(2448908.50068, true);
  UNREFERENCED_PARAMETER(psd2);
  double JED = CAAPhysicalSun::TimeOfStartOfRotation(1699);
  UNREFERENCED_PARAMETER(JED);


  //Test out the CAAEquinoxesAndSolstices class
  for (Year = 1962; Year < 2021; Year++)
  {
    double NorthwardEquinox = CAAEquinoxesAndSolstices::NorthwardEquinox(Year, false);
    double NorthwardEquinox4 = CAAEquinoxesAndSolstices::NorthwardEquinox(Year, true);
    UNREFERENCED_PARAMETER(NorthwardEquinox4);

    //For testing purposes lets also try out the various timeframe mapping methods of CAADynamicalTime for the "NorthwardEquinox" values
    printf("Testing TT -> UTC roundtripping\n");
    date.Set(NorthwardEquinox, true);
    date.Get(Year, Month, Day, Hour, Minute, Second);
    double NorthwardEquinox2 = CAADynamicalTime::TT2UTC(NorthwardEquinox);
    date.Set(NorthwardEquinox2, true);
    long Year2 = 0;
    long Month2 = 0;
    long Day2 = 0;
    long Hour2 = 0;
    long Minute2 = 0;
    double Second2 = 0;
    date.Get(Year2, Month2, Day2, Hour2, Minute2, Second2);
    printf("%d-%d-%d %02d:%02d:%f TT is %d-%d-%d %02d:%02d:%f UTC\n", static_cast<int>(Year), static_cast<int>(Month), static_cast<int>(Day), static_cast<int>(Hour), static_cast<int>(Minute), Second,
           static_cast<int>(Year2), static_cast<int>(Month2), static_cast<int>(Day2), static_cast<int>(Hour2), static_cast<int>(Minute2), Second2);
    double NorthwardEquinox3 = CAADynamicalTime::UTC2TT(NorthwardEquinox2);
    date.Set(NorthwardEquinox3, true);
    long Year3 = 0;
    long Month3 = 0;
    long Day3 = 0;
    long Hour3 = 0;
    long Minute3 = 0;
    double Second3 = 0;
    date.Get(Year3, Month3, Day3, Hour3, Minute3, Second3);
    printf("%d-%d-%d %02d:%02d:%f UTC is %d-%d-%d %02d:%02d:%f TT\n", static_cast<int>(Year2), static_cast<int>(Month2), static_cast<int>(Day2), static_cast<int>(Hour2), static_cast<int>(Minute2), Second2,
           static_cast<int>(Year3), static_cast<int>(Month3), static_cast<int>(Day3), static_cast<int>(Hour3), static_cast<int>(Minute3), Second3);

    NorthwardEquinox2 = CAADynamicalTime::TT2TAI(NorthwardEquinox);
    date.Set(NorthwardEquinox2, true);
    date.Get(Year2, Month2, Day2, Hour2, Minute2, Second2);
    printf("%d-%d-%d %02d:%02d:%f TT is %d-%d-%d %02d:%02d:%f TAI\n", static_cast<int>(Year), static_cast<int>(Month), static_cast<int>(Day), static_cast<int>(Hour), static_cast<int>(Minute), Second,
           static_cast<int>(Year2), static_cast<int>(Month2), static_cast<int>(Day2), static_cast<int>(Hour2), static_cast<int>(Minute2), Second2);

    NorthwardEquinox3 = CAADynamicalTime::TAI2TT(NorthwardEquinox2);
    date.Set(NorthwardEquinox3, true);
    date.Get(Year3, Month3, Day3, Hour3, Minute3, Second3);
    printf("%d-%d-%d %02d:%02d:%f TAI is %d-%d-%d %02d:%02d:%f TT\n", static_cast<int>(Year2), static_cast<int>(Month2), static_cast<int>(Day2), static_cast<int>(Hour2), static_cast<int>(Minute2), Second2,
           static_cast<int>(Year3), static_cast<int>(Month3), static_cast<int>(Day3), static_cast<int>(Hour3), static_cast<int>(Minute3), Second3);

    NorthwardEquinox2 = CAADynamicalTime::TT2UT1(NorthwardEquinox);
    date.Set(NorthwardEquinox2, true);
    date.Get(Year2, Month2, Day2, Hour2, Minute2, Second2);
    printf("%d-%d-%d %02d:%02d:%f TT is %d-%d-%d %02d:%02d:%f UT1\n", static_cast<int>(Year), static_cast<int>(Month), static_cast<int>(Day), static_cast<int>(Hour), static_cast<int>(Minute), Second,
           static_cast<int>(Year2), static_cast<int>(Month2), static_cast<int>(Day2), static_cast<int>(Hour2), static_cast<int>(Minute2), Second2);

    NorthwardEquinox3 = CAADynamicalTime::UT12TT(NorthwardEquinox2);
    date.Set(NorthwardEquinox3, true);
    date.Get(Year3, Month3, Day3, Hour3, Minute3, Second3);
    printf("%d-%d-%d %02d:%02d:%f UT1 is %d-%d-%d %02d:%02d:%f TT\n", static_cast<int>(Year2), static_cast<int>(Month2), static_cast<int>(Day2), static_cast<int>(Hour2), static_cast<int>(Minute2), Second2,
           static_cast<int>(Year3), static_cast<int>(Month3), static_cast<int>(Day3), static_cast<int>(Hour3), static_cast<int>(Minute3), Second3);

    date.Set(NorthwardEquinox, true);
    date.Get(Year, Month, Day, Hour, Minute, Second);
    printf("The Northward Equinox for %d occurs on %d-%d-%d %02d:%02d:%f TT\n", static_cast<int>(Year), static_cast<int>(Year), static_cast<int>(Month), static_cast<int>(Day), static_cast<int>(Hour), static_cast<int>(Minute), Second);
    NorthwardEquinox = CAADynamicalTime::TT2UTC(NorthwardEquinox);
    date.Set(NorthwardEquinox, true);
    date.Get(Year, Month, Day, Hour, Minute, Second);
    printf("The Northward Equinox for %d occurs on %d-%d-%d %02d:%02d:%f UTC\n", static_cast<int>(Year), static_cast<int>(Year), static_cast<int>(Month), static_cast<int>(Day), static_cast<int>(Hour), static_cast<int>(Minute), Second);

    double NorthernSolstice = CAAEquinoxesAndSolstices::NorthernSolstice(Year, false);
    double NorthernSolstice2 = CAAEquinoxesAndSolstices::NorthernSolstice(Year, true);
    UNREFERENCED_PARAMETER(NorthernSolstice2);
    date.Set(NorthernSolstice, true);
    date.Get(Year, Month, Day, Hour, Minute, Second);
    printf("The Northern Solstice for %d occurs on %d-%d-%d %02d:%02d:%f TT\n", static_cast<int>(Year), static_cast<int>(Year), static_cast<int>(Month), static_cast<int>(Day), static_cast<int>(Hour), static_cast<int>(Minute), Second);
    NorthernSolstice = CAADynamicalTime::TT2UTC(NorthernSolstice);
    date.Set(NorthernSolstice, true);
    date.Get(Year, Month, Day, Hour, Minute, Second);
    printf("The Northern Solstice for %d occurs on %d-%d-%d %02d:%02d:%f UTC\n", static_cast<int>(Year), static_cast<int>(Year), static_cast<int>(Month), static_cast<int>(Day), static_cast<int>(Hour), static_cast<int>(Minute), Second);

    double SouthwardEquinox = CAAEquinoxesAndSolstices::SouthwardEquinox(Year, false);
    double SouthwardEquinox2 = CAAEquinoxesAndSolstices::SouthwardEquinox(Year, true);
    UNREFERENCED_PARAMETER(SouthwardEquinox2);
    date.Set(SouthwardEquinox, true);
    date.Get(Year, Month, Day, Hour, Minute, Second);
    printf("The Southward Equinox for %d occurs on %d-%d-%d %02d:%02d:%f TT\n", static_cast<int>(Year), static_cast<int>(Year), static_cast<int>(Month), static_cast<int>(Day), static_cast<int>(Hour), static_cast<int>(Minute), Second);
    SouthwardEquinox = CAADynamicalTime::TT2UTC(SouthwardEquinox);
    date.Set(SouthwardEquinox, true);
    date.Get(Year, Month, Day, Hour, Minute, Second);
    printf("The Southward Equinox for %d occurs on %d-%d-%d %02d:%02d:%f UTC\n", static_cast<int>(Year), static_cast<int>(Year), static_cast<int>(Month), static_cast<int>(Day), static_cast<int>(Hour), static_cast<int>(Minute), Second);

    double SouthernSolstice = CAAEquinoxesAndSolstices::SouthernSolstice(Year, false);
    double SouthernSolstice2 = CAAEquinoxesAndSolstices::SouthernSolstice(Year, true);
    UNREFERENCED_PARAMETER(SouthernSolstice2);
    date.Set(SouthernSolstice, true);
    date.Get(Year, Month, Day, Hour, Minute, Second);
    printf("The Southern Solstice for %d occurs on %d-%d-%d %02d:%02d:%f TT\n", static_cast<int>(Year), static_cast<int>(Year), static_cast<int>(Month), static_cast<int>(Day), static_cast<int>(Hour), static_cast<int>(Minute), Second);
    SouthernSolstice = CAADynamicalTime::TT2UTC(SouthernSolstice);
    date.Set(SouthernSolstice, true);
    date.Get(Year, Month, Day, Hour, Minute, Second);
    printf("The Southern Solstice for %d occurs on %d-%d-%d %02d:%02d:%f UTC\n", static_cast<int>(Year), static_cast<int>(Year), static_cast<int>(Month), static_cast<int>(Day), static_cast<int>(Hour), static_cast<int>(Minute), Second);

    double SeasonLength = CAAEquinoxesAndSolstices::LengthOfSpring(Year, true, false);
    double SeasonLength2 = CAAEquinoxesAndSolstices::LengthOfSpring(Year, true, true);
    UNREFERENCED_PARAMETER(SeasonLength2);
    printf("Spring (for a northern hemisphere observer) in %d is %f days\n", static_cast<int>(Year), SeasonLength);
    SeasonLength = CAAEquinoxesAndSolstices::LengthOfSummer(Year, true, false);
    SeasonLength2 = CAAEquinoxesAndSolstices::LengthOfSummer(Year, true, true);
    printf("Summer (for a northern hemisphere observer) in %d is %f days\n", static_cast<int>(Year), SeasonLength);
    SeasonLength = CAAEquinoxesAndSolstices::LengthOfAutumn(Year, true, false);
    SeasonLength2 = CAAEquinoxesAndSolstices::LengthOfAutumn(Year, true, true);
    printf("Autumn/Fall (for a northern Hemisphere observer) in %d is %f days\n", static_cast<int>(Year), SeasonLength);
    SeasonLength = CAAEquinoxesAndSolstices::LengthOfWinter(Year, true, false);
    SeasonLength2 = CAAEquinoxesAndSolstices::LengthOfWinter(Year, true, true);
    printf("Winter (for a northern hemisphere observer) in %d is %f days\n", static_cast<int>(Year), SeasonLength);
    SeasonLength = CAAEquinoxesAndSolstices::LengthOfSpring(Year, false, false);
    SeasonLength2 = CAAEquinoxesAndSolstices::LengthOfSpring(Year, false, true);
    printf("Spring (for a southern hemisphere observer) in %d is %f days\n", static_cast<int>(Year), SeasonLength);
    SeasonLength = CAAEquinoxesAndSolstices::LengthOfSummer(Year, false, false);
    SeasonLength2 = CAAEquinoxesAndSolstices::LengthOfSummer(Year, false, true);
    printf("Summer (for a southern hemisphere observer) in %d is %f days\n", static_cast<int>(Year), SeasonLength);
    SeasonLength = CAAEquinoxesAndSolstices::LengthOfAutumn(Year, false, false);
    SeasonLength2 = CAAEquinoxesAndSolstices::LengthOfAutumn(Year, false, true);
    printf("Autumn/Fall (for a southern hemisphere observer) in %d is %f days\n", static_cast<int>(Year), SeasonLength);
    SeasonLength = CAAEquinoxesAndSolstices::LengthOfWinter(Year, false, false);
    SeasonLength2 = CAAEquinoxesAndSolstices::LengthOfWinter(Year, false, true);
    printf("Winter (for a southern hemisphere observer) in %d is %f days\n", static_cast<int>(Year), SeasonLength);
  }

  double SpringLength2 = CAAEquinoxesAndSolstices::LengthOfSpring(-2000, true, false);
  double SpringLength3 = CAAEquinoxesAndSolstices::LengthOfSpring(-2000, true, true);
  double SummerLength2 = CAAEquinoxesAndSolstices::LengthOfSummer(-2000, true, false);
  double SummerLength3 = CAAEquinoxesAndSolstices::LengthOfSummer(-2000, true, true);
  double AutumnLength2 = CAAEquinoxesAndSolstices::LengthOfAutumn(-2000, true, false);
  double AutumnLength3 = CAAEquinoxesAndSolstices::LengthOfAutumn(-2000, true, true);
  double WinterLength2 = CAAEquinoxesAndSolstices::LengthOfWinter(-2000, true, false);
  double WinterLength3 = CAAEquinoxesAndSolstices::LengthOfWinter(-2000, true, true);
  SpringLength2 = CAAEquinoxesAndSolstices::LengthOfSpring(4000, true, false);
  UNREFERENCED_PARAMETER(SpringLength2);
  SpringLength3 = CAAEquinoxesAndSolstices::LengthOfSpring(4000, true, true);
  UNREFERENCED_PARAMETER(SpringLength3);
  SummerLength2 = CAAEquinoxesAndSolstices::LengthOfSummer(4000, true, false);
  UNREFERENCED_PARAMETER(SummerLength2);
  SummerLength3 = CAAEquinoxesAndSolstices::LengthOfSummer(4000, true, true);
  UNREFERENCED_PARAMETER(SummerLength3);
  AutumnLength2 = CAAEquinoxesAndSolstices::LengthOfAutumn(4000, true, false);
  UNREFERENCED_PARAMETER(AutumnLength2);
  AutumnLength3 = CAAEquinoxesAndSolstices::LengthOfAutumn(4000, true, true);
  UNREFERENCED_PARAMETER(AutumnLength3);
  WinterLength2 = CAAEquinoxesAndSolstices::LengthOfWinter(4000, true, false);
  UNREFERENCED_PARAMETER(WinterLength2);
  WinterLength3 = CAAEquinoxesAndSolstices::LengthOfWinter(4000, true, true);
  UNREFERENCED_PARAMETER(WinterLength3);


  //Test out the CAAElementsPlanetaryOrbit class
  double Mer_L = CAAElementsPlanetaryOrbit::MercuryMeanLongitude(2475460.5);
  UNREFERENCED_PARAMETER(Mer_L);
  double Mer_a = CAAElementsPlanetaryOrbit::MercurySemimajorAxis(2475460.5);
  UNREFERENCED_PARAMETER(Mer_a);
  Mer_a = CAAElementsPlanetaryOrbit::MercurySemimajorAxis(2451545);
  double Mer_e = CAAElementsPlanetaryOrbit::MercuryEccentricity(2475460.5);
  UNREFERENCED_PARAMETER(Mer_e);
  double Mer_i = CAAElementsPlanetaryOrbit::MercuryInclination(2475460.5);
  UNREFERENCED_PARAMETER(Mer_i);
  double Mer_omega = CAAElementsPlanetaryOrbit::MercuryLongitudeAscendingNode(2475460.5);
  UNREFERENCED_PARAMETER(Mer_omega);
  double Mer_pi = CAAElementsPlanetaryOrbit::MercuryLongitudePerihelion(2475460.5);
  UNREFERENCED_PARAMETER(Mer_pi);

  double Ven_L = CAAElementsPlanetaryOrbit::VenusMeanLongitude(2475460.5);
  UNREFERENCED_PARAMETER(Ven_L);
  double Ven_a = CAAElementsPlanetaryOrbit::VenusSemimajorAxis(2475460.5);
  UNREFERENCED_PARAMETER(Ven_a);
  Ven_a = CAAElementsPlanetaryOrbit::VenusSemimajorAxis(2451545);
  double Ven_e = CAAElementsPlanetaryOrbit::VenusEccentricity(2475460.5);
  UNREFERENCED_PARAMETER(Ven_e);
  Ven_e = CAAElementsPlanetaryOrbit::VenusEccentricity(2451545);
  double Ven_i = CAAElementsPlanetaryOrbit::VenusInclination(2475460.5);
  UNREFERENCED_PARAMETER(Ven_i);
  double Ven_omega = CAAElementsPlanetaryOrbit::VenusLongitudeAscendingNode(2475460.5);
  UNREFERENCED_PARAMETER(Ven_omega);
  double Ven_pi = CAAElementsPlanetaryOrbit::VenusLongitudePerihelion(2475460.5);
  UNREFERENCED_PARAMETER(Ven_pi);

  double Ea_L = CAAElementsPlanetaryOrbit::EarthMeanLongitude(2475460.5);
  UNREFERENCED_PARAMETER(Ea_L);
  double Ea_a = CAAElementsPlanetaryOrbit::EarthSemimajorAxis(2451545);
  UNREFERENCED_PARAMETER(Ea_a);
  Ea_a = CAAElementsPlanetaryOrbit::EarthSemimajorAxis(2475460.5);
  UNREFERENCED_PARAMETER(Ea_a);
  double Ea_e = CAAElementsPlanetaryOrbit::EarthEccentricity(2475460.5);
  Ea_e = CAAElementsPlanetaryOrbit::EarthEccentricity(2451545);
  UNREFERENCED_PARAMETER(Ea_e);
  double Ea_i = CAAElementsPlanetaryOrbit::EarthInclination(2475460.5);
  UNREFERENCED_PARAMETER(Ea_i);
  double Ea_pi = CAAElementsPlanetaryOrbit::EarthLongitudePerihelion(2475460.5);
  UNREFERENCED_PARAMETER(Ea_pi);

  double Mars_L = CAAElementsPlanetaryOrbit::MarsMeanLongitude(2475460.5);
  UNREFERENCED_PARAMETER(Mars_L);
  double Mars_a = CAAElementsPlanetaryOrbit::MarsSemimajorAxis(2475460.5);
  UNREFERENCED_PARAMETER(Mars_a);
  Mars_a = CAAElementsPlanetaryOrbit::MarsSemimajorAxis(2451545);
  double Mars_e = CAAElementsPlanetaryOrbit::MarsEccentricity(2475460.5);
  UNREFERENCED_PARAMETER(Mars_e);
  Mars_e = CAAElementsPlanetaryOrbit::MarsEccentricity(2451545);
  double Mars_i = CAAElementsPlanetaryOrbit::MarsInclination(2475460.5);
  UNREFERENCED_PARAMETER(Mars_i);
  double Mars_omega = CAAElementsPlanetaryOrbit::MarsLongitudeAscendingNode(2475460.5);
  UNREFERENCED_PARAMETER(Mars_omega);
  double Mars_pi = CAAElementsPlanetaryOrbit::MarsLongitudePerihelion(2475460.5);
  UNREFERENCED_PARAMETER(Mars_pi);

  double Jup_L = CAAElementsPlanetaryOrbit::JupiterMeanLongitude(2475460.5);
  UNREFERENCED_PARAMETER(Jup_L);
  double Jup_a = CAAElementsPlanetaryOrbit::JupiterSemimajorAxis(2475460.5);
  UNREFERENCED_PARAMETER(Jup_a);
  Jup_a = CAAElementsPlanetaryOrbit::JupiterSemimajorAxis(2451545);
  double Jup_e = CAAElementsPlanetaryOrbit::JupiterEccentricity(2475460.5);
  UNREFERENCED_PARAMETER(Jup_e);
  Jup_e = CAAElementsPlanetaryOrbit::JupiterEccentricity(2451545);
  double Jup_i = CAAElementsPlanetaryOrbit::JupiterInclination(2475460.5);
  UNREFERENCED_PARAMETER(Jup_i);
  double Jup_omega = CAAElementsPlanetaryOrbit::JupiterLongitudeAscendingNode(2475460.5);
  UNREFERENCED_PARAMETER(Jup_omega);
  double Jup_pi = CAAElementsPlanetaryOrbit::JupiterLongitudePerihelion(2475460.5);
  UNREFERENCED_PARAMETER(Jup_pi);

  double Sat_L = CAAElementsPlanetaryOrbit::SaturnMeanLongitude(2475460.5);
  UNREFERENCED_PARAMETER(Sat_L);
  double Sat_a = CAAElementsPlanetaryOrbit::SaturnSemimajorAxis(2475460.5);
  UNREFERENCED_PARAMETER(Sat_a);
  Sat_a = CAAElementsPlanetaryOrbit::SaturnSemimajorAxis(2451545);
  double Sat_e = CAAElementsPlanetaryOrbit::SaturnEccentricity(2475460.5);
  UNREFERENCED_PARAMETER(Sat_e);
  Sat_e = CAAElementsPlanetaryOrbit::SaturnEccentricity(2451545);
  double Sat_i = CAAElementsPlanetaryOrbit::SaturnInclination(2475460.5);
  UNREFERENCED_PARAMETER(Sat_i);
  double Sat_omega = CAAElementsPlanetaryOrbit::SaturnLongitudeAscendingNode(2475460.5);
  UNREFERENCED_PARAMETER(Sat_omega);
  double Sat_pi = CAAElementsPlanetaryOrbit::SaturnLongitudePerihelion(2475460.5);
  UNREFERENCED_PARAMETER(Sat_pi);

  double Ura_L = CAAElementsPlanetaryOrbit::UranusMeanLongitude(2475460.5);
  UNREFERENCED_PARAMETER(Ura_L);
  double Ura_a = CAAElementsPlanetaryOrbit::UranusSemimajorAxis(2475460.5);
  UNREFERENCED_PARAMETER(Ura_a);
  Ura_a = CAAElementsPlanetaryOrbit::UranusSemimajorAxis(2451545);
  double Ura_e = CAAElementsPlanetaryOrbit::UranusEccentricity(2475460.5);
  UNREFERENCED_PARAMETER(Ura_e);
  Ura_e = CAAElementsPlanetaryOrbit::UranusEccentricity(2451545);
  double Ura_i = CAAElementsPlanetaryOrbit::UranusInclination(2475460.5);
  UNREFERENCED_PARAMETER(Ura_i);
  double Ura_omega = CAAElementsPlanetaryOrbit::UranusLongitudeAscendingNode(2475460.5);
  UNREFERENCED_PARAMETER(Ura_omega);
  double Ura_pi = CAAElementsPlanetaryOrbit::UranusLongitudePerihelion(2475460.5);
  UNREFERENCED_PARAMETER(Ura_pi);

  double Nep_L = CAAElementsPlanetaryOrbit::NeptuneMeanLongitude(2475460.5);
  UNREFERENCED_PARAMETER(Nep_L);
  double Nep_a = CAAElementsPlanetaryOrbit::NeptuneSemimajorAxis(2475460.5);
  UNREFERENCED_PARAMETER(Nep_a);
  Nep_a = CAAElementsPlanetaryOrbit::NeptuneSemimajorAxis(2451545);
  double Nep_e = CAAElementsPlanetaryOrbit::NeptuneEccentricity(2475460.5);
  Nep_e = CAAElementsPlanetaryOrbit::NeptuneEccentricity(2451545);
  UNREFERENCED_PARAMETER(Nep_e);
  double Nep_i = CAAElementsPlanetaryOrbit::NeptuneInclination(2475460.5);
  UNREFERENCED_PARAMETER(Nep_i);
  double Nep_omega = CAAElementsPlanetaryOrbit::NeptuneLongitudeAscendingNode(2475460.5);
  UNREFERENCED_PARAMETER(Nep_omega);
  double Nep_pi = CAAElementsPlanetaryOrbit::NeptuneLongitudePerihelion(2475460.5);
  UNREFERENCED_PARAMETER(Nep_pi);


  double Mer_L2 = CAAElementsPlanetaryOrbit::MercuryMeanLongitudeJ2000(2475460.5);
  UNREFERENCED_PARAMETER(Mer_L2);
  Mer_L2 = CAAElementsPlanetaryOrbit::MercuryMeanLongitudeJ2000(2451545);
  double Mer_i2 = CAAElementsPlanetaryOrbit::MercuryInclinationJ2000(2475460.5);
  UNREFERENCED_PARAMETER(Mer_i2);
  double Mer_omega2 = CAAElementsPlanetaryOrbit::MercuryLongitudeAscendingNodeJ2000(2475460.5);
  UNREFERENCED_PARAMETER(Mer_omega2);
  Mer_omega2 = CAAElementsPlanetaryOrbit::MercuryLongitudeAscendingNodeJ2000(2451545);
  double Mer_pi2 = CAAElementsPlanetaryOrbit::MercuryLongitudePerihelionJ2000(2475460.5);
  UNREFERENCED_PARAMETER(Mer_pi2);
  Mer_pi2 = CAAElementsPlanetaryOrbit::MercuryLongitudePerihelionJ2000(2451545);

  double Ven_L2 = CAAElementsPlanetaryOrbit::VenusMeanLongitudeJ2000(2475460.5);
  UNREFERENCED_PARAMETER(Ven_L2);
  Ven_L2 = CAAElementsPlanetaryOrbit::VenusMeanLongitudeJ2000(2451545);
  double Ven_i2 = CAAElementsPlanetaryOrbit::VenusInclinationJ2000(2475460.5);
  UNREFERENCED_PARAMETER(Ven_i2);
  double Ven_omega2 = CAAElementsPlanetaryOrbit::VenusLongitudeAscendingNodeJ2000(2475460.5);
  UNREFERENCED_PARAMETER(Ven_omega2);
  Ven_omega2 = CAAElementsPlanetaryOrbit::VenusLongitudeAscendingNodeJ2000(2451545);
  double Ven_pi2 = CAAElementsPlanetaryOrbit::VenusLongitudePerihelionJ2000(2475460.5);
  UNREFERENCED_PARAMETER(Ven_pi2);
  Ven_pi2 = CAAElementsPlanetaryOrbit::VenusLongitudePerihelionJ2000(2451545);

  double Ea_L2 = CAAElementsPlanetaryOrbit::EarthMeanLongitudeJ2000(2475460.5);
  UNREFERENCED_PARAMETER(Ea_L2);
  Ea_L2 = CAAElementsPlanetaryOrbit::EarthMeanLongitudeJ2000(2451545);
  double Ea_i2 = CAAElementsPlanetaryOrbit::EarthInclinationJ2000(2475460.5);
  UNREFERENCED_PARAMETER(Ea_i2);
  double Ea_omega2 = CAAElementsPlanetaryOrbit::EarthLongitudeAscendingNodeJ2000(2475460.5);
  UNREFERENCED_PARAMETER(Ea_omega2);
  Ea_omega2 = CAAElementsPlanetaryOrbit::EarthLongitudeAscendingNodeJ2000(2451545);
  double Ea_pi2 = CAAElementsPlanetaryOrbit::EarthLongitudePerihelionJ2000(2475460.5);
  UNREFERENCED_PARAMETER(Ea_pi2);
  Ea_pi2 = CAAElementsPlanetaryOrbit::EarthLongitudePerihelionJ2000(2451545);

  double Mars_L2 = CAAElementsPlanetaryOrbit::MarsMeanLongitudeJ2000(2475460.5);
  UNREFERENCED_PARAMETER(Mars_L2);
  Mars_L2 = CAAElementsPlanetaryOrbit::MarsMeanLongitudeJ2000(2451545);
  double Mars_i2 = CAAElementsPlanetaryOrbit::MarsInclinationJ2000(2475460.5);
  UNREFERENCED_PARAMETER(Mars_i2);
  double Mars_omega2 = CAAElementsPlanetaryOrbit::MarsLongitudeAscendingNodeJ2000(2475460.5);
  UNREFERENCED_PARAMETER(Mars_omega2);
  Mars_omega2 = CAAElementsPlanetaryOrbit::MarsLongitudeAscendingNodeJ2000(2451545);
  double Mars_pi2 = CAAElementsPlanetaryOrbit::MarsLongitudePerihelionJ2000(2475460.5);
  UNREFERENCED_PARAMETER(Mars_pi2);
  Mars_pi2 = CAAElementsPlanetaryOrbit::MarsLongitudePerihelionJ2000(2451545);

  double Jup_L2 = CAAElementsPlanetaryOrbit::JupiterMeanLongitudeJ2000(2475460.5);
  UNREFERENCED_PARAMETER(Jup_L2);
  Jup_L2 = CAAElementsPlanetaryOrbit::JupiterMeanLongitudeJ2000(2451545);
  double Jup_i2 = CAAElementsPlanetaryOrbit::JupiterInclinationJ2000(2475460.5);
  UNREFERENCED_PARAMETER(Jup_i2);
  double Jup_omega2 = CAAElementsPlanetaryOrbit::JupiterLongitudeAscendingNodeJ2000(2475460.5);
  UNREFERENCED_PARAMETER(Jup_omega2);
  Jup_omega2 = CAAElementsPlanetaryOrbit::JupiterLongitudeAscendingNodeJ2000(2451545);
  double Jup_pi2 = CAAElementsPlanetaryOrbit::JupiterLongitudePerihelionJ2000(2475460.5);
  UNREFERENCED_PARAMETER(Jup_pi2);
  Jup_pi2 = CAAElementsPlanetaryOrbit::JupiterLongitudePerihelionJ2000(2451545);

  double Sat_L2 = CAAElementsPlanetaryOrbit::SaturnMeanLongitudeJ2000(2475460.5);
  UNREFERENCED_PARAMETER(Sat_L2);
  Sat_L2 = CAAElementsPlanetaryOrbit::SaturnMeanLongitudeJ2000(2451545);
  double Sat_i2 = CAAElementsPlanetaryOrbit::SaturnInclinationJ2000(2475460.5);
  UNREFERENCED_PARAMETER(Sat_i2);
  double Sat_omega2 = CAAElementsPlanetaryOrbit::SaturnLongitudeAscendingNodeJ2000(2475460.5);
  UNREFERENCED_PARAMETER(Sat_omega2);
  Sat_omega2 = CAAElementsPlanetaryOrbit::SaturnLongitudeAscendingNodeJ2000(2451545);
  double Sat_pi2 = CAAElementsPlanetaryOrbit::SaturnLongitudePerihelionJ2000(2475460.5);
  UNREFERENCED_PARAMETER(Sat_pi2);
  Sat_pi2 = CAAElementsPlanetaryOrbit::SaturnLongitudePerihelionJ2000(2451545);

  double Ura_L2 = CAAElementsPlanetaryOrbit::UranusMeanLongitudeJ2000(2475460.5);
  UNREFERENCED_PARAMETER(Ura_L2);
  Ura_L2 = CAAElementsPlanetaryOrbit::UranusMeanLongitudeJ2000(2451545);
  double Ura_i2 = CAAElementsPlanetaryOrbit::UranusInclinationJ2000(2475460.5);
  UNREFERENCED_PARAMETER(Ura_i2);
  double Ura_omega2 = CAAElementsPlanetaryOrbit::UranusLongitudeAscendingNodeJ2000(2475460.5);
  UNREFERENCED_PARAMETER(Ura_omega2);
  Ura_omega2 = CAAElementsPlanetaryOrbit::UranusLongitudeAscendingNodeJ2000(2451545);
  double Ura_pi2 = CAAElementsPlanetaryOrbit::UranusLongitudePerihelionJ2000(2475460.5);
  UNREFERENCED_PARAMETER(Ura_pi2);
  Ura_pi2 = CAAElementsPlanetaryOrbit::UranusLongitudePerihelionJ2000(2451545);

  double Nep_L2 = CAAElementsPlanetaryOrbit::NeptuneMeanLongitudeJ2000(2475460.5);
  UNREFERENCED_PARAMETER(Nep_L2);
  Nep_L2 = CAAElementsPlanetaryOrbit::NeptuneMeanLongitudeJ2000(2451545);
  double Nep_i2 = CAAElementsPlanetaryOrbit::NeptuneInclinationJ2000(2475460.5);
  UNREFERENCED_PARAMETER(Nep_i2);
  double Nep_omega2 = CAAElementsPlanetaryOrbit::NeptuneLongitudeAscendingNodeJ2000(2475460.5);
  UNREFERENCED_PARAMETER(Nep_omega2);
  Nep_omega2 = CAAElementsPlanetaryOrbit::NeptuneLongitudeAscendingNodeJ2000(2451545);
  double Nep_pi2 = CAAElementsPlanetaryOrbit::NeptuneLongitudePerihelionJ2000(2475460.5);
  UNREFERENCED_PARAMETER(Nep_pi2);
  Nep_pi2 = CAAElementsPlanetaryOrbit::NeptuneLongitudePerihelionJ2000(2451545);

  double MoonGeocentricElongation = CAAMoonIlluminatedFraction::GeocentricElongation(8.97922, 13.7684, 1.377194, 8.6964);
  double MoonPhaseAngle = CAAMoonIlluminatedFraction::PhaseAngle(MoonGeocentricElongation, 368410, 149971520);
  double MoonIlluminatedFraction = CAAMoonIlluminatedFraction::IlluminatedFraction(MoonPhaseAngle);
  UNREFERENCED_PARAMETER(MoonIlluminatedFraction);
  double MoonPositionAngle = CAAMoonIlluminatedFraction::PositionAngle(CAACoordinateTransformation::DMSToDegrees(1, 22, 37.9), 8.6964, 134.6885/15, 13.7684);
  UNREFERENCED_PARAMETER(MoonPositionAngle);

  double JDVenus = CAADynamicalTime::TT2UTC(2448976.5);
  UNREFERENCED_PARAMETER(JDVenus);
  CAAEllipticalPlanetaryDetails VenusDetails = CAAElliptical::Calculate(2448976.5, CAAElliptical::VENUS, false);
  UNREFERENCED_PARAMETER(VenusDetails);
  CAAEllipticalPlanetaryDetails VenusDetails2 = CAAElliptical::Calculate(2448976.5, CAAElliptical::VENUS, true);
  UNREFERENCED_PARAMETER(VenusDetails2);
  CAAEllipticalPlanetaryDetails VenusDetails3 = CAAElliptical::Calculate(CAADynamicalTime::UTC2TT(2453149.5), CAAElliptical::VENUS, false);
  UNREFERENCED_PARAMETER(VenusDetails3);
  CAAEllipticalPlanetaryDetails VenusDetails4 = CAAElliptical::Calculate(CAADynamicalTime::UTC2TT(2453149.5), CAAElliptical::VENUS, true);
  UNREFERENCED_PARAMETER(VenusDetails4);
  CAAEllipticalPlanetaryDetails VenusDetails5 = CAAElliptical::Calculate(CAADynamicalTime::UTC2TT(2457214.6), CAAElliptical::VENUS, false);
  UNREFERENCED_PARAMETER(VenusDetails5);
  CAAEllipticalPlanetaryDetails VenusDetails6 = CAAElliptical::Calculate(CAADynamicalTime::UTC2TT(2457214.6), CAAElliptical::VENUS, true);
  UNREFERENCED_PARAMETER(VenusDetails6);

  CAAEllipticalPlanetaryDetails SunDetails  = CAAElliptical::Calculate(CAADynamicalTime::UTC2TT(2453149.5), CAAElliptical::SUN, false);
  UNREFERENCED_PARAMETER(SunDetails);
  CAAEllipticalPlanetaryDetails SunDetails2 = CAAElliptical::Calculate(CAADynamicalTime::UTC2TT(2453149.5), CAAElliptical::SUN, true);
  UNREFERENCED_PARAMETER(SunDetails2);
  CAAEllipticalPlanetaryDetails SunDetails3 = CAAElliptical::Calculate(CAADynamicalTime::UTC2TT(2457214.6), CAAElliptical::SUN, false);
  UNREFERENCED_PARAMETER(SunDetails3);
  CAAEllipticalPlanetaryDetails SunDetails4 = CAAElliptical::Calculate(CAADynamicalTime::UTC2TT(2457214.6), CAAElliptical::SUN, true);
  UNREFERENCED_PARAMETER(SunDetails4);
  CAAEllipticalPlanetaryDetails SunDetails5 = CAAElliptical::Calculate(2448908.5, CAAElliptical::SUN, false);
  UNREFERENCED_PARAMETER(SunDetails5);
  CAAEllipticalPlanetaryDetails SunDetails6 = CAAElliptical::Calculate(2448908.5, CAAElliptical::SUN, true);
  UNREFERENCED_PARAMETER(SunDetails6);
  CAAEllipticalPlanetaryDetails SunDetails7 = CAAElliptical::Calculate(CAADynamicalTime::UTC2TT(2457213.875), CAAElliptical::SUN, false);
  UNREFERENCED_PARAMETER(SunDetails7);
  CAAEllipticalPlanetaryDetails SunDetails8 = CAAElliptical::Calculate(CAADynamicalTime::UTC2TT(2457213.875), CAAElliptical::SUN, true);
  UNREFERENCED_PARAMETER(SunDetails8);

  CAAEllipticalObjectElements elements;
  elements.a = 2.2091404;
  elements.e = 0.8502196;
  elements.i = 11.94524;
  elements.omega = 334.75006;
  elements.w = 186.23352;
  elements.T = 2448192.5 + 0.54502;
  elements.JDEquinox = 2451544.5;
  CAAEllipticalObjectDetails details = CAAElliptical::Calculate(2448170.5, elements, false);
  UNREFERENCED_PARAMETER(details);
  CAAEllipticalObjectDetails details8 = CAAElliptical::Calculate(2448170.5, elements, true);
  UNREFERENCED_PARAMETER(details8);

  double Velocity1 = CAAElliptical::InstantaneousVelocity(1, 17.9400782);
  UNREFERENCED_PARAMETER(Velocity1);
  double Velocity2 = CAAElliptical::VelocityAtPerihelion(0.96727426, 17.9400782);
  UNREFERENCED_PARAMETER(Velocity2);
  double Velocity3 = CAAElliptical::VelocityAtAphelion(0.96727426, 17.9400782);
  UNREFERENCED_PARAMETER(Velocity3);

  double Length = CAAElliptical::LengthOfEllipse(0.96727426, 17.9400782);
  UNREFERENCED_PARAMETER(Length);

  double Mag1 = CAAElliptical::MinorPlanetMagnitude(3.34, 1.6906631928, 0.12, 2.6154983761, 120);
  UNREFERENCED_PARAMETER(Mag1);
  double Mag2 = CAAElliptical::CometMagnitude(5.5, 0.378, 10, 0.658);
  UNREFERENCED_PARAMETER(Mag2);
  double Mag3 = CAAElliptical::CometMagnitude(5.5, 1.1017, 10, 1.5228);
  UNREFERENCED_PARAMETER(Mag3);

  CAAParabolicObjectElements elements2; //Sample taken from http://www.stjarnhimlen.se/comp/tutorial.html for comet Levy
  elements2.q = 0.93858;
  elements2.i = 131.5856;
  elements2.omega = 139.2313;
  elements2.w = 242.6797;
  elements2.T = CAADate::DateToJD(1990, 10, 24.6954, true);
  elements2.JDEquinox = elements2.T; //Of the day
  double JDCalc = CAADynamicalTime::UTC2TT(CAADate::DateToJD(1990, 8, 22.0, true));
  CAAParabolicObjectDetails details2 = CAAParabolic::Calculate(JDCalc, elements2, false);
  UNREFERENCED_PARAMETER(details2);
  CAAParabolicObjectDetails details5 = CAAParabolic::Calculate(JDCalc, elements2, true);
  UNREFERENCED_PARAMETER(details5);

  CAAEllipticalObjectElements elements3;
  elements3.a = 17.9400782;
  elements3.e = 0.96727426;
  elements3.i = 0; //Not required
  elements3.omega = 0; //Not required
  elements3.w = 111.84644;
  elements3.T = 2446470.5 + 0.45891;
  elements3.JDEquinox = 0; //Not required
  CAANodeObjectDetails nodedetails = CAANodes::PassageThroAscendingNode(elements3);
  UNREFERENCED_PARAMETER(nodedetails);
  CAANodeObjectDetails nodedetails2 = CAANodes::PassageThroDescendingNode(elements3);
  UNREFERENCED_PARAMETER(nodedetails2);

  CAAParabolicObjectElements elements4;
  elements4.q = 1.324502;
  elements4.i = 0; //Not required
  elements4.omega = 0; //Not required
  elements4.w = 154.9103;
  elements4.T = 2447758.5 + 0.2910;
  elements4.JDEquinox = 0; //Not required
  CAANodeObjectDetails nodedetails3 = CAANodes::PassageThroAscendingNode(elements4);
  UNREFERENCED_PARAMETER(nodedetails3);
  CAANodeObjectDetails nodedetails4 = CAANodes::PassageThroDescendingNode(elements4);
  UNREFERENCED_PARAMETER(nodedetails4);


  CAAEllipticalObjectElements elements5;
  elements5.a = 0.723329820;
  elements5.e = 0.00678195;
  elements5.i = 0; //Not required
  elements5.omega = 0; //Not required
  elements5.w = 54.778485;
  elements5.T = 2443873.704;
  elements5.JDEquinox = 0; //Not required
  CAANodeObjectDetails nodedetails5 = CAANodes::PassageThroAscendingNode(elements5);
  UNREFERENCED_PARAMETER(nodedetails5);


  double MoonK2 = CAAMoonNodes::K(1987.37);
  UNREFERENCED_PARAMETER(MoonK2);
  double MoonJD = CAAMoonNodes::PassageThroNode(-170);
  UNREFERENCED_PARAMETER(MoonJD);


  double Y = CAAInterpolate::Interpolate(0.18125, 0.884226, 0.877366, 0.870531);
  UNREFERENCED_PARAMETER(Y);

  double NM;
  double YM = CAAInterpolate::Extremum(1.3814294, 1.3812213, 1.3812453, NM);
  UNREFERENCED_PARAMETER(YM);

  double N0 = CAAInterpolate::Zero(-1693.4, 406.3, 2303.2);
  UNREFERENCED_PARAMETER(N0);

  double N02 = CAAInterpolate::Zero2(-2, 3, 2);
  UNREFERENCED_PARAMETER(N02);

  double Y2 = CAAInterpolate::Interpolate(0.2777778, 36.125, 24.606, 15.486, 8.694, 4.133);
  UNREFERENCED_PARAMETER(Y2);

  double N03 = CAAInterpolate::Zero(CAACoordinateTransformation::DMSToDegrees(1, 11, 21.23, false), CAACoordinateTransformation::DMSToDegrees(0, 28, 12.31, false), CAACoordinateTransformation::DMSToDegrees(0, 16, 7.02), CAACoordinateTransformation::DMSToDegrees(1, 1, 0.13), CAACoordinateTransformation::DMSToDegrees(1, 45, 46.33));
  UNREFERENCED_PARAMETER(N03);

  double N04 = CAAInterpolate::Zero(CAACoordinateTransformation::DMSToDegrees(0, 28, 12.31, false), CAACoordinateTransformation::DMSToDegrees(0, 16, 7.02), CAACoordinateTransformation::DMSToDegrees(1, 1, 0.13));
  UNREFERENCED_PARAMETER(N04);

  double N05 = CAAInterpolate::Zero2(-13, -2, 3, 2, -5);
  UNREFERENCED_PARAMETER(N05);

  double Y3 = CAAInterpolate::InterpolateToHalves(1128.732, 1402.835, 1677.247, 1951.983);
  UNREFERENCED_PARAMETER(Y3);

  double X1[] = { 29.43, 30.97, 27.69, 28.11, 31.58, 33.05 };
  double Y1[] = { 0.4913598528, 0.5145891926, 0.4646875083, 0.4711658342, 0.5236885653, 0.5453707057 };
  double Y4 = CAAInterpolate::LagrangeInterpolate(30, 6, X1, Y1);
  UNREFERENCED_PARAMETER(Y4);
  double Y5 = CAAInterpolate::LagrangeInterpolate(0, 6, X1, Y1);
  UNREFERENCED_PARAMETER(Y5);
  double Y6 = CAAInterpolate::LagrangeInterpolate(90, 6, X1, Y1);
  UNREFERENCED_PARAMETER(Y6);

  double Alpha1 = CAACoordinateTransformation::DMSToDegrees(2, 42, 43.25);
  double Alpha2 = CAACoordinateTransformation::DMSToDegrees(2, 46, 55.51);
  double Alpha3 = CAACoordinateTransformation::DMSToDegrees(2, 51, 07.69);
  double Delta1 = CAACoordinateTransformation::DMSToDegrees(18, 02, 51.4);
  double Delta2 = CAACoordinateTransformation::DMSToDegrees(18, 26, 27.3);
  double Delta3 = CAACoordinateTransformation::DMSToDegrees(18, 49, 38.7);
  double JD2 = 2447240.5;
  Longitude = 71.0833;
  Latitude = 42.3333;
  CAARiseTransitSetDetails RiseTransitSetTime = CAARiseTransitSet::Calculate(JD2, Alpha1, Delta1, Alpha2, Delta2, Alpha3, Delta3, Longitude, Latitude, -0.5667);
  if (RiseTransitSetTime.bRiseValid)
  {
    double riseJD = (JD2 + (RiseTransitSetTime.Rise / 24.00));
    CAADate rtsDate(riseJD, true);
    rtsDate.Get(Year, Month, Day, Hour, Minute, Second);
    printf("Venus rise for Boston for UTC %d-%d-%d occurs at %02d:%02d:%02d\n", static_cast<int>(Year), static_cast<int>(Month), static_cast<int>(Day), static_cast<int>(Hour), static_cast<int>(Minute), static_cast<int>(Second));
  }
  else
  {
    CAADate rtsDate(JD2, true);
    rtsDate.Get(Year, Month, Day, Hour, Minute, Second);
    printf("Venus does not rise for Boston for UTC %d-%d-%d\n", static_cast<int>(Year), static_cast<int>(Month), static_cast<int>(Day));
  }
  double transitJD = (JD2 + (RiseTransitSetTime.Transit / 24.00));
  CAADate rtsDate(transitJD, true);
  rtsDate.Get(Year, Month, Day, Hour, Minute, Second);
  if (RiseTransitSetTime.bTransitAboveHorizon)
    printf("Venus transit for Boston for UTC %d-%d-%d occurs at %02d:%02d:%02d\n", static_cast<int>(Year), static_cast<int>(Month), static_cast<int>(Day), static_cast<int>(Hour), static_cast<int>(Minute), static_cast<int>(Second));
  else
    printf("Venus transit for Boston (below horizon) for UTC %d-%d-%d occurs at %02d:%02d:%02d\n", static_cast<int>(Year), static_cast<int>(Month), static_cast<int>(Day), static_cast<int>(Hour), static_cast<int>(Minute), static_cast<int>(Second));
  if (RiseTransitSetTime.bSetValid)
  {
    double setJD = (JD2 + (RiseTransitSetTime.Set / 24.00));
    rtsDate = CAADate(setJD, true);
    rtsDate.Get(Year, Month, Day, Hour, Minute, Second);
    printf("Venus set for Boston UTC %d-%d-%d occurs at %02d:%02d:%02d\n", static_cast<int>(Year), static_cast<int>(Month), static_cast<int>(Day), static_cast<int>(Hour), static_cast<int>(Minute), static_cast<int>(Second));
  }
  else
  {
    rtsDate = CAADate(JD2, true);
    rtsDate.Get(Year, Month, Day, Hour, Minute, Second);
    printf("Venus does not set for Boston for UTC %d-%d-%d\n", static_cast<int>(Year), static_cast<int>(Month), static_cast<int>(Day));
  }

  //Calculate the time of moon set for 11th of August 2009 UTC for Palomar Observatory
  int YYYY = 2009;
  int MM = 8;
  int DD = 11;
  CAADate CalcDate(YYYY, MM, DD, true);
  JD2 = CalcDate.Julian();
  GetLunarRaDecByJulian(JD2 - 1, Alpha1, Delta1);
  GetLunarRaDecByJulian(JD2, Alpha2, Delta2);
  GetLunarRaDecByJulian(JD2 + 1, Alpha3, Delta3);
  Longitude = CAACoordinateTransformation::DMSToDegrees(116, 51, 45); //West is considered positive
  Latitude = CAACoordinateTransformation::DMSToDegrees(33, 21, 22);
  RiseTransitSetTime = CAARiseTransitSet::Calculate(JD2, Alpha1, Delta1, Alpha2, Delta2, Alpha3, Delta3, Longitude, Latitude, 0.125);
  if (RiseTransitSetTime.bRiseValid)
  {
    double riseJD = (JD2 + (RiseTransitSetTime.Rise / 24.00));
    rtsDate = CAADate(riseJD, true);
    rtsDate.Get(Year, Month, Day, Hour, Minute, Second);
    printf("Moon rise for Palomar Observatory for UTC %d-%d-%d occurs at %02d:%02d:%02d\n", static_cast<int>(Year), static_cast<int>(Month), static_cast<int>(Day), static_cast<int>(Hour), static_cast<int>(Minute), static_cast<int>(Second));
  }
  else
  {
    rtsDate = CAADate(JD2, true);
    rtsDate.Get(Year, Month, Day, Hour, Minute, Second);
    printf("Moon does not rise for Palomar Observatory for UTC %d-%d-%d\n", static_cast<int>(Year), static_cast<int>(Month), static_cast<int>(Day));
  }
  transitJD = (JD2 + (RiseTransitSetTime.Transit / 24.00));
  rtsDate = CAADate(transitJD, true);
  rtsDate.Get(Year, Month, Day, Hour, Minute, Second);
  if (RiseTransitSetTime.bTransitAboveHorizon)
    printf("Moon transit for Palomar Observatory for UTC %d-%d-%d occurs at %02d:%02d:%02d\n", static_cast<int>(Year), static_cast<int>(Month), static_cast<int>(Day), static_cast<int>(Hour), static_cast<int>(Minute), static_cast<int>(Second));
  else
    printf("Moon transit for Palomar Observatory (below horizon) for UTC %d-%d-%d occurs at %02d:%02d:%02d\n", static_cast<int>(Year), static_cast<int>(Month), static_cast<int>(Day), static_cast<int>(Hour), static_cast<int>(Minute), static_cast<int>(Second));
  if (RiseTransitSetTime.bSetValid)
  {
    double setJD = (JD2 + (RiseTransitSetTime.Set / 24.00));
    rtsDate = CAADate(setJD, true);
    rtsDate.Get(Year, Month, Day, Hour, Minute, Second);
    printf("Moon set for Palomar Observatory for UTC %d-%d-%d occurs at %02d:%02d:%02d\n", static_cast<int>(Year), static_cast<int>(Month), static_cast<int>(Day), static_cast<int>(Hour), static_cast<int>(Minute), static_cast<int>(Second));
  }
  else
  {
    rtsDate = CAADate(JD2, true);
    rtsDate.Get(Year, Month, Day, Hour, Minute, Second);
    printf("Moon does not set for Palomar Observatory for UTC %d-%d-%d\n", static_cast<int>(Year), static_cast<int>(Month), static_cast<int>(Day));
  }

  double Kpp = CAAPlanetaryPhenomena::K(1993.75, CAAPlanetaryPhenomena::MERCURY, CAAPlanetaryPhenomena::INFERIOR_CONJUNCTION);
  double MercuryInferiorConjunction = CAAPlanetaryPhenomena::Mean(Kpp, CAAPlanetaryPhenomena::MERCURY, CAAPlanetaryPhenomena::INFERIOR_CONJUNCTION);
  UNREFERENCED_PARAMETER(MercuryInferiorConjunction);
  double MercuryInferiorConjunction2 = CAAPlanetaryPhenomena::True(Kpp, CAAPlanetaryPhenomena::MERCURY, CAAPlanetaryPhenomena::INFERIOR_CONJUNCTION);
  UNREFERENCED_PARAMETER(MercuryInferiorConjunction2);

  double Kpp2 = CAAPlanetaryPhenomena::K(2125.5, CAAPlanetaryPhenomena::SATURN, CAAPlanetaryPhenomena::CONJUNCTION);
  double SaturnConjunction = CAAPlanetaryPhenomena::Mean(Kpp2, CAAPlanetaryPhenomena::SATURN, CAAPlanetaryPhenomena::CONJUNCTION);
  UNREFERENCED_PARAMETER(SaturnConjunction);
  double SaturnConjunction2 = CAAPlanetaryPhenomena::True(Kpp2, CAAPlanetaryPhenomena::SATURN, CAAPlanetaryPhenomena::CONJUNCTION);
  UNREFERENCED_PARAMETER(SaturnConjunction2);

  double MercuryWesternElongation = CAAPlanetaryPhenomena::True(Kpp, CAAPlanetaryPhenomena::MERCURY, CAAPlanetaryPhenomena::WESTERN_ELONGATION);
  UNREFERENCED_PARAMETER(MercuryWesternElongation);
  double MercuryWesternElongationValue = CAAPlanetaryPhenomena::ElongationValue(Kpp, CAAPlanetaryPhenomena::MERCURY, false);
  UNREFERENCED_PARAMETER(MercuryWesternElongationValue);

  double MarsStation2 = CAAPlanetaryPhenomena::True(-2, CAAPlanetaryPhenomena::MARS, CAAPlanetaryPhenomena::STATION2);
  UNREFERENCED_PARAMETER(MarsStation2);

  double MercuryK = CAAPlanetaryPhenomena::K(1631.8, CAAPlanetaryPhenomena::MERCURY, CAAPlanetaryPhenomena::INFERIOR_CONJUNCTION);
  double MercuryIC = CAAPlanetaryPhenomena::True(MercuryK, CAAPlanetaryPhenomena::MERCURY, CAAPlanetaryPhenomena::INFERIOR_CONJUNCTION);
  UNREFERENCED_PARAMETER(MercuryIC);

  double VenusKpp = CAAPlanetaryPhenomena::K(1882.9, CAAPlanetaryPhenomena::VENUS, CAAPlanetaryPhenomena::INFERIOR_CONJUNCTION);
  double VenusIC = CAAPlanetaryPhenomena::True(VenusKpp, CAAPlanetaryPhenomena::VENUS, CAAPlanetaryPhenomena::INFERIOR_CONJUNCTION);
  UNREFERENCED_PARAMETER(VenusIC);

  double MarsKpp = CAAPlanetaryPhenomena::K(2729.65, CAAPlanetaryPhenomena::MARS, CAAPlanetaryPhenomena::OPPOSITION);
  double MarsOP = CAAPlanetaryPhenomena::True(MarsKpp, CAAPlanetaryPhenomena::MARS, CAAPlanetaryPhenomena::OPPOSITION);
  UNREFERENCED_PARAMETER(MarsOP);

  double JupiterKpp = CAAPlanetaryPhenomena::K(-5, CAAPlanetaryPhenomena::JUPITER, CAAPlanetaryPhenomena::OPPOSITION);
  double JupiterOP = CAAPlanetaryPhenomena::True(JupiterKpp, CAAPlanetaryPhenomena::JUPITER, CAAPlanetaryPhenomena::OPPOSITION);
  UNREFERENCED_PARAMETER(JupiterOP);

  double SaturnKpp = CAAPlanetaryPhenomena::K(-5, CAAPlanetaryPhenomena::SATURN, CAAPlanetaryPhenomena::OPPOSITION);
  double SaturnOP = CAAPlanetaryPhenomena::True(SaturnKpp, CAAPlanetaryPhenomena::SATURN, CAAPlanetaryPhenomena::OPPOSITION);
  UNREFERENCED_PARAMETER(SaturnOP);

  double UranusKpp = CAAPlanetaryPhenomena::K(1780.6, CAAPlanetaryPhenomena::URANUS, CAAPlanetaryPhenomena::OPPOSITION);
  double UranusOP = CAAPlanetaryPhenomena::True(UranusKpp, CAAPlanetaryPhenomena::URANUS, CAAPlanetaryPhenomena::OPPOSITION);
  UNREFERENCED_PARAMETER(UranusOP);

  double NeptuneKpp = CAAPlanetaryPhenomena::K(1846.5, CAAPlanetaryPhenomena::NEPTUNE, CAAPlanetaryPhenomena::OPPOSITION);
  double NeptuneOP = CAAPlanetaryPhenomena::True(NeptuneKpp, CAAPlanetaryPhenomena::NEPTUNE, CAAPlanetaryPhenomena::OPPOSITION);
  UNREFERENCED_PARAMETER(NeptuneOP);

  CAA2DCoordinate TopocentricDelta = CAAParallax::Equatorial2TopocentricDelta(CAACoordinateTransformation::DMSToDegrees(22, 38, 7.25), -15.771083, 0.37276, CAACoordinateTransformation::DMSToDegrees(7, 47, 27)*15, CAACoordinateTransformation::DMSToDegrees(33, 21, 22), 1706, 2452879.63681);
  UNREFERENCED_PARAMETER(TopocentricDelta);
  CAA2DCoordinate Topocentric = CAAParallax::Equatorial2Topocentric(CAACoordinateTransformation::DMSToDegrees(22, 38, 7.25), -15.771083, 0.37276, CAACoordinateTransformation::DMSToDegrees(7, 47, 27)*15, CAACoordinateTransformation::DMSToDegrees(33, 21, 22), 1706, 2452879.63681);
  UNREFERENCED_PARAMETER(Topocentric);


  double distance2 = CAAParallax::ParallaxToDistance(CAACoordinateTransformation::DMSToDegrees(0, 59, 27.7));
  double parallax2 = CAAParallax::DistanceToParallax(distance2);
  UNREFERENCED_PARAMETER(parallax2);

  CAATopocentricEclipticDetails TopocentricDetails = CAAParallax::Ecliptic2Topocentric(CAACoordinateTransformation::DMSToDegrees(181, 46, 22.5), CAACoordinateTransformation::DMSToDegrees(2, 17, 26.2),
                                                                                       CAACoordinateTransformation::DMSToDegrees(0, 16, 15.5), CAAParallax::ParallaxToDistance(CAACoordinateTransformation::DMSToDegrees(0, 59, 27.7)), CAACoordinateTransformation::DMSToDegrees(23, 28, 0.8),
                                                                                       CAACoordinateTransformation::DMSToDegrees(50, 5, 7.8), 0, 2452879.150858);
  UNREFERENCED_PARAMETER(TopocentricDetails);

  double k = CAAIlluminatedFraction::IlluminatedFraction(0.724604, 0.983824, 0.910947);
  UNREFERENCED_PARAMETER(k);
  double pa1 = CAAIlluminatedFraction::PhaseAngle(0.724604, 0.983824, 0.910947);
  UNREFERENCED_PARAMETER(pa1);
  double pa = CAAIlluminatedFraction::PhaseAngle(0.724604, 0.983824, -2.62070, 26.11428, 88.35704, 0.910947);
  double k2 = CAAIlluminatedFraction::IlluminatedFraction(pa);
  UNREFERENCED_PARAMETER(k2);
  double pa2 = CAAIlluminatedFraction::PhaseAngleRectangular(0.621746, -0.664810, -0.033134, -2.62070, 26.11428, 0.910947);
  double k3 = CAAIlluminatedFraction::IlluminatedFraction(pa2);
  UNREFERENCED_PARAMETER(k3);

  double VenusMag = CAAIlluminatedFraction::VenusMagnitudeMuller(0.724604, 0.910947, 72.96);
  UNREFERENCED_PARAMETER(VenusMag);
  double VenusMag2 = CAAIlluminatedFraction::VenusMagnitudeAA(0.724604, 0.910947, 72.96);
  UNREFERENCED_PARAMETER(VenusMag2);

  double SaturnMag = CAAIlluminatedFraction::SaturnMagnitudeMuller(9.867882, 10.464606, 4.198, 16.442);
  UNREFERENCED_PARAMETER(SaturnMag);
  double SaturnMag2 = CAAIlluminatedFraction::SaturnMagnitudeAA(9.867882, 10.464606, 4.198, 16.442);
  UNREFERENCED_PARAMETER(SaturnMag2);


  CAAPhysicalMarsDetails MarsDetails = CAAPhysicalMars::Calculate(2448935.500683, false);
  UNREFERENCED_PARAMETER(MarsDetails);
  CAAPhysicalMarsDetails MarsDetails2 = CAAPhysicalMars::Calculate(2448935.500683, true);
  UNREFERENCED_PARAMETER(MarsDetails2);

  CAAPhysicalJupiterDetails JupiterDetails = CAAPhysicalJupiter::Calculate(2448972.50068, false);
  UNREFERENCED_PARAMETER(JupiterDetails);
  CAAPhysicalJupiterDetails JupiterDetails2 = CAAPhysicalJupiter::Calculate(2448972.50068, true);
  UNREFERENCED_PARAMETER(JupiterDetails2);

  //The example as given in the book
  CAAGalileanMoonsDetails GalileanDetails = CAAGalileanMoons::Calculate(2448972.50068, false);
  UNREFERENCED_PARAMETER(GalileanDetails);
  CAAGalileanMoonsDetails GalileanDetails2 = CAAGalileanMoons::Calculate(2448972.50068, true);
  UNREFERENCED_PARAMETER(GalileanDetails2);

  //Calculate the Eclipse Disappearance of Satellite 1 on February 1 2004 at 13:32 UCT
  JD = 2453037.05903;
  int i;
  for (i=0; i<10; i++)
  {
    CAAGalileanMoonsDetails GalileanDetails1 = CAAGalileanMoons::Calculate(JD, false);
    UNREFERENCED_PARAMETER(GalileanDetails1);
    CAAGalileanMoonsDetails GalileanDetails3 = CAAGalileanMoons::Calculate(JD, true);
    UNREFERENCED_PARAMETER(GalileanDetails3);
    JD += (1.0/1440);
  }

  //Calculate the Shadow Egress of Satellite 1 on February 2  2004 at 13:07 UT
  JD = 2453038.04236;
  for (i=0; i<10; i++)
  {
    CAAGalileanMoonsDetails GalileanDetails1 = CAAGalileanMoons::Calculate(JD, false);
    UNREFERENCED_PARAMETER(GalileanDetails1);
    CAAGalileanMoonsDetails GalileanDetails3 = CAAGalileanMoons::Calculate(JD, true);
    UNREFERENCED_PARAMETER(GalileanDetails3);
    JD += (1.0/1440);
  }

  //Calculate the Shadow Ingress of Satellite 4 on February 6 2004 at 22:59 UCT
  JD = 2453042.45486;
  for (i=0; i<10; i++)
  {
    CAAGalileanMoonsDetails GalileanDetails1 = CAAGalileanMoons::Calculate(JD, false);
    UNREFERENCED_PARAMETER(GalileanDetails1);
    CAAGalileanMoonsDetails GalileanDetails3 = CAAGalileanMoons::Calculate(JD, true);
    UNREFERENCED_PARAMETER(GalileanDetails3);
    JD += (1.0/1440);
  }

  //Calculate the Shadow Egress of Satellite 4 on February 7 2004 at 2:41 UCT
  JD = 2453042.61042;
  for (i=0; i<10; i++)
  {
    CAAGalileanMoonsDetails GalileanDetails1 = CAAGalileanMoons::Calculate(JD, false);
    UNREFERENCED_PARAMETER(GalileanDetails1);
    CAAGalileanMoonsDetails GalileanDetails3 = CAAGalileanMoons::Calculate(JD, true);
    UNREFERENCED_PARAMETER(GalileanDetails3);
    JD += (1.0/1440);
  }

  //Calculate the Transit Ingress of Satellite 4 on February 7 2004 at 5:07 UCT
  JD = 2453042.71181;
  for (i=0; i<10; i++)
  {
    CAAGalileanMoonsDetails GalileanDetails1 = CAAGalileanMoons::Calculate(JD, false);
    UNREFERENCED_PARAMETER(GalileanDetails1);
    CAAGalileanMoonsDetails GalileanDetails3 = CAAGalileanMoons::Calculate(JD, true);
    UNREFERENCED_PARAMETER(GalileanDetails3);
    JD += (1.0/1440);
  }

  //Calculate the Transit Egress of Satellite 4 on February 7 2004 at 7:46 UT
  JD = 2453042.82222;
  for (i=0; i<10; i++)
  {
    CAAGalileanMoonsDetails GalileanDetails1 = CAAGalileanMoons::Calculate(JD, false);
    UNREFERENCED_PARAMETER(GalileanDetails1);
    CAAGalileanMoonsDetails GalileanDetails3 = CAAGalileanMoons::Calculate(JD, true);
    UNREFERENCED_PARAMETER(GalileanDetails3);
    JD += (1.0/1440);
  }

  CAASaturnRingDetails saturnrings = CAASaturnRings::Calculate(2448972.50068, false);
  UNREFERENCED_PARAMETER(saturnrings);
  CAASaturnRingDetails saturnrings2 = CAASaturnRings::Calculate(2448972.50068, true);
  UNREFERENCED_PARAMETER(saturnrings2);

  /*
  //Code to write out the Saturn Ring values for a specific range
  CAADate Datex(2024, 4, 1, true);
  double JDUT3 = Datex.Julian();
  bool bContinue4 = true;
  while (bContinue4)
  {
    saturnrings = CAASaturnRings::Calculate(JDUT3);
    printf("%f\t%f\t%f\t%f\n", JDUT3, saturnrings.U1, saturnrings.U2, saturnrings.DeltaU);

    //Prepare for the next loop
    JDUT3 += 5;
    if (JDUT3 >= 2469136.500000)
      bContinue4 = false;
  }
  */

  CAASaturnMoonsDetails saturnMoons = CAASaturnMoons::Calculate(2451439.50074, false);
  UNREFERENCED_PARAMETER(saturnMoons);
  CAASaturnMoonsDetails saturnMoons2 = CAASaturnMoons::Calculate(2451439.50074, true);
  UNREFERENCED_PARAMETER(saturnMoons2);

  double ApproxK = CAAMoonPhases::K(1977.125);
  UNREFERENCED_PARAMETER(ApproxK);
  double NewMoonJD = CAAMoonPhases::TruePhase(-283);
  UNREFERENCED_PARAMETER(NewMoonJD);

  ApproxK = CAAMoonPhases::K(1952.88);
  double LastQuarterJD = CAAMoonPhases::TruePhase(-583 + 0.75);
  UNREFERENCED_PARAMETER(LastQuarterJD);

  double ApproxK2 = CAAMoonPhases::K(2044);
  UNREFERENCED_PARAMETER(ApproxK2);
  LastQuarterJD = CAAMoonPhases::TruePhase(544.75);

  double MoonDeclinationK = CAAMoonMaxDeclinations::K(1988.95);
  UNREFERENCED_PARAMETER(MoonDeclinationK);

  double MoonNorthDec = CAAMoonMaxDeclinations::TrueGreatestDeclination(-148, true);
  UNREFERENCED_PARAMETER(MoonNorthDec);
  double MoonNorthDecValue = CAAMoonMaxDeclinations::TrueGreatestDeclinationValue(-148, true);
  UNREFERENCED_PARAMETER(MoonNorthDecValue);

  double MoonSouthDec = CAAMoonMaxDeclinations::TrueGreatestDeclination(659, false);
  UNREFERENCED_PARAMETER(MoonSouthDec);
  double MoonSouthDecValue = CAAMoonMaxDeclinations::TrueGreatestDeclinationValue(659, false);
  UNREFERENCED_PARAMETER(MoonSouthDecValue);

  double MoonNorthDec2 = CAAMoonMaxDeclinations::TrueGreatestDeclination(-26788, true);
  UNREFERENCED_PARAMETER(MoonNorthDec2);
  double MoonNorthDecValue2 = CAAMoonMaxDeclinations::TrueGreatestDeclinationValue(-26788, true);
  UNREFERENCED_PARAMETER(MoonNorthDecValue2);

  double sd1 = CAADiameters::SunSemidiameterA(1);
  UNREFERENCED_PARAMETER(sd1);
  double sd2 = CAADiameters::SunSemidiameterA(2);
  UNREFERENCED_PARAMETER(sd2);

  double sd3 = CAADiameters::VenusSemidiameterA(1);
  UNREFERENCED_PARAMETER(sd3);
  double sd4 = CAADiameters::VenusSemidiameterA(2);
  UNREFERENCED_PARAMETER(sd4);
  double sd5 = CAADiameters::VenusSemidiameterB(1);
  UNREFERENCED_PARAMETER(sd5);
  double sd6 = CAADiameters::VenusSemidiameterB(2);
  UNREFERENCED_PARAMETER(sd6);

  double sd11 = CAADiameters::MarsSemidiameterA(1);
  UNREFERENCED_PARAMETER(sd11);
  double sd12 = CAADiameters::MarsSemidiameterA(2);
  UNREFERENCED_PARAMETER(sd12);
  double sd13 = CAADiameters::MarsSemidiameterB(1);
  UNREFERENCED_PARAMETER(sd13);
  double sd14 = CAADiameters::MarsSemidiameterB(2);
  UNREFERENCED_PARAMETER(sd14);

  double sd15 = CAADiameters::JupiterEquatorialSemidiameterA(1);
  UNREFERENCED_PARAMETER(sd15);
  double sd16 = CAADiameters::JupiterEquatorialSemidiameterA(2);
  UNREFERENCED_PARAMETER(sd16);
  double sd17 = CAADiameters::JupiterEquatorialSemidiameterB(1);
  UNREFERENCED_PARAMETER(sd17);
  double sd18 = CAADiameters::JupiterEquatorialSemidiameterB(2);
  UNREFERENCED_PARAMETER(sd18);

  double sd19 = CAADiameters::JupiterPolarSemidiameterA(1);
  UNREFERENCED_PARAMETER(sd19);
  double sd20 = CAADiameters::JupiterPolarSemidiameterA(2);
  UNREFERENCED_PARAMETER(sd20);
  double sd21 = CAADiameters::JupiterPolarSemidiameterB(1);
  UNREFERENCED_PARAMETER(sd21);
  double sd22 = CAADiameters::JupiterPolarSemidiameterB(2);
  UNREFERENCED_PARAMETER(sd22);

  double sd23 = CAADiameters::SaturnEquatorialSemidiameterA(1);
  UNREFERENCED_PARAMETER(sd23);
  double sd24 = CAADiameters::SaturnEquatorialSemidiameterA(2);
  UNREFERENCED_PARAMETER(sd24);
  double sd25 = CAADiameters::SaturnEquatorialSemidiameterB(1);
  UNREFERENCED_PARAMETER(sd25);
  double sd26 = CAADiameters::SaturnEquatorialSemidiameterB(2);
  UNREFERENCED_PARAMETER(sd26);

  double sd27 = CAADiameters::SaturnPolarSemidiameterA(1);
  UNREFERENCED_PARAMETER(sd27);
  double sd28 = CAADiameters::SaturnPolarSemidiameterA(2);
  UNREFERENCED_PARAMETER(sd28);
  double sd29 = CAADiameters::SaturnPolarSemidiameterB(1);
  UNREFERENCED_PARAMETER(sd29);
  double sd30 = CAADiameters::SaturnPolarSemidiameterB(2);
  UNREFERENCED_PARAMETER(sd30);

  double sd31 = CAADiameters::ApparentSaturnPolarSemidiameterA(1, 16.442);
  UNREFERENCED_PARAMETER(sd31);
  double sd32 = CAADiameters::ApparentSaturnPolarSemidiameterA(2, 16.442);
  UNREFERENCED_PARAMETER(sd32);

  double sd33 = CAADiameters::UranusSemidiameterA(1);
  UNREFERENCED_PARAMETER(sd33);
  double sd34 = CAADiameters::UranusSemidiameterA(2);
  UNREFERENCED_PARAMETER(sd34);
  double sd35 = CAADiameters::UranusSemidiameterB(1);
  UNREFERENCED_PARAMETER(sd35);
  double sd36 = CAADiameters::UranusSemidiameterB(2);
  UNREFERENCED_PARAMETER(sd36);

  double sd37 = CAADiameters::NeptuneSemidiameterA(1);
  UNREFERENCED_PARAMETER(sd37);
  double sd38 = CAADiameters::NeptuneSemidiameterA(2);
  UNREFERENCED_PARAMETER(sd38);
  double sd39 = CAADiameters::NeptuneSemidiameterB(1);
  UNREFERENCED_PARAMETER(sd39);
  double sd40 = CAADiameters::NeptuneSemidiameterB(2);
  UNREFERENCED_PARAMETER(sd40);

  double sd41 = CAADiameters::PlutoSemidiameterB(1);
  UNREFERENCED_PARAMETER(sd41);
  double sd42 = CAADiameters::PlutoSemidiameterB(2);
  UNREFERENCED_PARAMETER(sd42);
  double sd43 = CAADiameters::GeocentricMoonSemidiameter(368407.9);
  UNREFERENCED_PARAMETER(sd43);
  double sd44 = CAADiameters::GeocentricMoonSemidiameter(368407.9 - 10000);
  UNREFERENCED_PARAMETER(sd44);

  double sd45 = CAADiameters::TopocentricMoonSemidiameter(368407.9, 5, 0, 33.356111, 1706);
  UNREFERENCED_PARAMETER(sd45);
  double sd46 = CAADiameters::TopocentricMoonSemidiameter(368407.9, 5, 6, 33.356111, 1706);
  UNREFERENCED_PARAMETER(sd46);
  double sd47 = CAADiameters::TopocentricMoonSemidiameter(368407.9 - 10000, 5, 0, 33.356111, 1706);
  UNREFERENCED_PARAMETER(sd47);
  double sd48 = CAADiameters::TopocentricMoonSemidiameter(368407.9 - 10000, 5, 6, 33.356111, 1706);
  UNREFERENCED_PARAMETER(sd48);

  double sd49 = CAADiameters::AsteroidDiameter(4, 0.04);
  UNREFERENCED_PARAMETER(sd49);
  double sd50 = CAADiameters::AsteroidDiameter(4, 0.08);
  UNREFERENCED_PARAMETER(sd50);
  double sd51 = CAADiameters::AsteroidDiameter(6, 0.04);
  UNREFERENCED_PARAMETER(sd51);
  double sd53 = CAADiameters::AsteroidDiameter(6, 0.08);
  UNREFERENCED_PARAMETER(sd53);
  double sd54 = CAADiameters::ApparentAsteroidDiameter(1, 250);
  UNREFERENCED_PARAMETER(sd54);
  double sd55 = CAADiameters::ApparentAsteroidDiameter(1, 1000);
  UNREFERENCED_PARAMETER(sd55);

  CAAPhysicalMoonDetails MoonDetails = CAAPhysicalMoon::CalculateGeocentric(2448724.5);
  UNREFERENCED_PARAMETER(MoonDetails);
  CAAPhysicalMoonDetails MoonDetail2 = CAAPhysicalMoon::CalculateTopocentric(2448724.5, 10, 52);
  UNREFERENCED_PARAMETER(MoonDetail2);
  CAASelenographicMoonDetails selenographicMoonDetails = CAAPhysicalMoon::CalculateSelenographicPositionOfSun(2448724.5, false);
  UNREFERENCED_PARAMETER(selenographicMoonDetails);
  CAASelenographicMoonDetails selenographicMoonDetails2 = CAAPhysicalMoon::CalculateSelenographicPositionOfSun(2448724.5, true);
  UNREFERENCED_PARAMETER(selenographicMoonDetails2);

  double AltitudeOfSun = CAAPhysicalMoon::AltitudeOfSun(2448724.5, -20, 9.7, false);
  UNREFERENCED_PARAMETER(AltitudeOfSun);
  double AltitudeOfSun2 = CAAPhysicalMoon::AltitudeOfSun(2448724.5, -20, 9.7, true);
  UNREFERENCED_PARAMETER(AltitudeOfSun2);
  double TimeOfSunrise = CAAPhysicalMoon::TimeOfSunrise(2448724.5, -20, 9.7, false);
  UNREFERENCED_PARAMETER(TimeOfSunrise);
  double TimeOfSunrise2 = CAAPhysicalMoon::TimeOfSunrise(2448724.5, -20, 9.7, true);
  UNREFERENCED_PARAMETER(TimeOfSunrise2);
  double TimeOfSunset = CAAPhysicalMoon::TimeOfSunset(2448724.5, -20, 9.7, false);
  UNREFERENCED_PARAMETER(TimeOfSunset);
  double TimeOfSunset2 = CAAPhysicalMoon::TimeOfSunset(2448724.5, -20, 9.7, true);
  UNREFERENCED_PARAMETER(TimeOfSunset2);

  CAASolarEclipseDetails EclipseDetails = CAAEclipses::CalculateSolar(-82);
  UNREFERENCED_PARAMETER(EclipseDetails);
  CAASolarEclipseDetails EclipseDetails2 = CAAEclipses::CalculateSolar(118);
  UNREFERENCED_PARAMETER(EclipseDetails2);
  CAALunarEclipseDetails EclipseDetails3 = CAAEclipses::CalculateLunar(-328.5);
  UNREFERENCED_PARAMETER(EclipseDetails3);
  CAALunarEclipseDetails EclipseDetails4 = CAAEclipses::CalculateLunar(-30.5); //No lunar eclipse
  EclipseDetails4 = CAAEclipses::CalculateLunar(-29.5); //No lunar eclipse
  EclipseDetails4 = CAAEclipses::CalculateLunar(-28.5); //Aha, found you!

  CAACalendarDate JulianDate = CAAMoslemCalendar::MoslemToJulian(1421, 1, 1);
  CAACalendarDate GregorianDate = CAADate::JulianToGregorian(JulianDate.Year, JulianDate.Month, JulianDate.Day);
  CAACalendarDate JulianDate2 = CAADate::GregorianToJulian(GregorianDate.Year, GregorianDate.Month, GregorianDate.Day);
  CAACalendarDate MoslemDate = CAAMoslemCalendar::JulianToMoslem(JulianDate2.Year, JulianDate2.Month, JulianDate2.Day);
  bLeap = CAAMoslemCalendar::IsLeap(1421);
  UNREFERENCED_PARAMETER(bLeap);

  MoslemDate = CAAMoslemCalendar::JulianToMoslem(2006, 12, 31);
  CAACalendarDate OriginalMoslemDate = CAAMoslemCalendar::MoslemToJulian(MoslemDate.Year, MoslemDate.Month, MoslemDate.Day);
  MoslemDate = CAAMoslemCalendar::JulianToMoslem(2007, 1, 1);
  OriginalMoslemDate = CAAMoslemCalendar::MoslemToJulian(MoslemDate.Year, MoslemDate.Month, MoslemDate.Day);

  CAACalendarDate JulianDate3 = CAADate::GregorianToJulian(1991, 8, 13);
  CAACalendarDate MoslemDate2 = CAAMoslemCalendar::JulianToMoslem(JulianDate3.Year, JulianDate3.Month, JulianDate3.Day);
  CAACalendarDate JulianDate4 = CAAMoslemCalendar::MoslemToJulian(MoslemDate2.Year, MoslemDate2.Month, MoslemDate2.Day);
  CAACalendarDate GregorianDate2 = CAADate::JulianToGregorian(JulianDate4.Year, JulianDate4.Month, JulianDate4.Day);
  UNREFERENCED_PARAMETER(GregorianDate2);

  CAACalendarDate JewishDate = CAAJewishCalendar::DateOfPesach(1990);
  bLeap = CAAJewishCalendar::IsLeap(JewishDate.Year);
  bLeap = CAAJewishCalendar::IsLeap(5751);
  long DaysInJewishYear = CAAJewishCalendar::DaysInYear(JewishDate.Year);
  DaysInJewishYear = CAAJewishCalendar::DaysInYear(5751);
  UNREFERENCED_PARAMETER(DaysInJewishYear);


  CAANearParabolicObjectElements elements6;
  //Try the Near Parabolic classes using the same sample for comet Levy as for CAAParabolic
  elements6.q = 0.93858;
  elements6.i = 131.5856;
  elements6.omega = 139.2313;
  elements6.w = 242.6797;
  elements6.T = CAADate::DateToJD(1990, 10, 24.6954, true);
  elements6.JDEquinox = elements2.T; //Of the day
  JDCalc = CAADynamicalTime::UTC2TT(CAADate::DateToJD(1990, 8, 22.0, true));
  CAANearParabolicObjectDetails details3 = CAANearParabolic::Calculate(JDCalc, elements6, false);
  CAANearParabolicObjectDetails details4 = CAANearParabolic::Calculate(JDCalc, elements6, true);

  elements6.q = 0.921326;
  elements6.e = 1;
  elements6.i = 0; //unknown
  elements6.omega = 0; //unknown
  elements6.w = 0; //unknown
  elements6.T = 0;
  elements6.JDEquinox = 0;
  details3 = CAANearParabolic::Calculate(138.4783, elements6, false);
  details4 = CAANearParabolic::Calculate(138.4783, elements6, true);

  elements6.q = 0.1;
  elements6.e = 0.987;
  details3 = CAANearParabolic::Calculate(254.9, elements6, false);
  details4 = CAANearParabolic::Calculate(254.9, elements6, true);

  elements6.q = 0.123456;
  elements6.e = 0.99997;
  details3 = CAANearParabolic::Calculate(-30.47, elements6, false);
  details4 = CAANearParabolic::Calculate(-30.47, elements6, true);

  elements6.q = 3.363943;
  elements6.e = 1.05731;
  details3 = CAANearParabolic::Calculate(1237.1, elements6, false);
  details4 = CAANearParabolic::Calculate(1237.1, elements6, true);

  elements6.q = 0.5871018;
  elements6.e = 0.9672746;
  details3 = CAANearParabolic::Calculate(20, elements6, false);
  details4 = CAANearParabolic::Calculate(20, elements6, true);

  details3 = CAANearParabolic::Calculate(0, elements6, false);
  details4 = CAANearParabolic::Calculate(0, elements6, false);

  CAAEclipticalElementDetails ed5 = CAAEclipticalElements::Calculate(131.5856, 242.6797, 138.6637, 2433282.4235, 2448188.500000 + 0.6954-63.6954);
  UNREFERENCED_PARAMETER(ed5);
  CAAEclipticalElementDetails ed6 = CAAEclipticalElements::Calculate(131.5856, 242.6797, 138.6637, 2433282.4235, 2433282.4235);
  UNREFERENCED_PARAMETER(ed6);
  CAAEclipticalElementDetails ed7 = CAAEclipticalElements::FK4B1950ToFK5J2000(131.5856, 242.6797, 138.6637);
  UNREFERENCED_PARAMETER(ed7);

  elements6.q = 0.93858;
  elements6.e = 1.000270;
  elements6.i = ed5.i;
  elements6.omega = ed5.omega;
  elements6.w = ed5.w;
  elements6.T = 2448188.500000 + 0.6954;
  elements6.JDEquinox = elements6.T;
  CAANearParabolicObjectDetails details6 = CAANearParabolic::Calculate(elements6.T-63.6954, elements6, false);
  UNREFERENCED_PARAMETER(details6);
  CAANearParabolicObjectDetails details7 = CAANearParabolic::Calculate(elements6.T - 63.6954, elements6, true);
  UNREFERENCED_PARAMETER(details7);

#ifndef AAPLUS_VSOP87_NO_HIGH_PRECISION
  //A sample test for Mercury VSOP87 as taken from vsop87.chk
  double fA = CAAVSOP87_Mercury::A(2451545.0);
  UNREFERENCED_PARAMETER(fA);
  double fL = CAAVSOP87_Mercury::L(2451545.0);
  UNREFERENCED_PARAMETER(fL);
  double fK = CAAVSOP87_Mercury::K(2451545.0);
  UNREFERENCED_PARAMETER(fK);
  double fH = CAAVSOP87_Mercury::H(2451545.0);
  UNREFERENCED_PARAMETER(fH);
  double fQ = CAAVSOP87_Mercury::Q(2451545.0);
  UNREFERENCED_PARAMETER(fQ);
  double fP = CAAVSOP87_Mercury::P(2451545.0);
  UNREFERENCED_PARAMETER(fP);

  //A sample test for Venus VSOP87 as taken from vsop87.chk
  fA = CAAVSOP87_Venus::A(2305445.0);
  UNREFERENCED_PARAMETER(fA);
  fL = CAAVSOP87_Venus::L(2305445.0);
  UNREFERENCED_PARAMETER(fL);
  fK = CAAVSOP87_Venus::K(2305445.0);
  UNREFERENCED_PARAMETER(fK);
  fH = CAAVSOP87_Venus::H(2305445.0);
  UNREFERENCED_PARAMETER(fH);
  fQ = CAAVSOP87_Venus::Q(2305445.0);
  UNREFERENCED_PARAMETER(fQ);
  fP = CAAVSOP87_Venus::P(2305445.0);
  UNREFERENCED_PARAMETER(fP);

  //A sample test for Mars VSOP87 as taken from vsop87.chk
  fA = CAAVSOP87_Mars::A(2305445.0);
  UNREFERENCED_PARAMETER(fA);
  fL = CAAVSOP87_Mars::L(2305445.0);
  UNREFERENCED_PARAMETER(fL);
  fK = CAAVSOP87_Mars::K(2305445.0);
  UNREFERENCED_PARAMETER(fK);
  fH = CAAVSOP87_Mars::H(2305445.0);
  UNREFERENCED_PARAMETER(fH);
  fQ = CAAVSOP87_Mars::Q(2305445.0);
  UNREFERENCED_PARAMETER(fQ);
  fP = CAAVSOP87_Mars::P(2305445.0);
  UNREFERENCED_PARAMETER(fP);

  //A sample test for Jupiter VSOP87 as taken from vsop87.chk
  fA = CAAVSOP87_Jupiter::A(2305445.0);
  UNREFERENCED_PARAMETER(fA);
  fL = CAAVSOP87_Jupiter::L(2305445.0);
  UNREFERENCED_PARAMETER(fL);
  fK = CAAVSOP87_Jupiter::K(2305445.0);
  UNREFERENCED_PARAMETER(fK);
  fH = CAAVSOP87_Jupiter::H(2305445.0);
  UNREFERENCED_PARAMETER(fH);
  fQ = CAAVSOP87_Jupiter::Q(2305445.0);
  UNREFERENCED_PARAMETER(fQ);
  fP = CAAVSOP87_Jupiter::P(2305445.0);
  UNREFERENCED_PARAMETER(fP);

  //A sample test for Saturn VSOP87 as taken from vsop87.chk
  fA = CAAVSOP87_Saturn::A(2305445.0);
  UNREFERENCED_PARAMETER(fA);
  fL = CAAVSOP87_Saturn::L(2305445.0);
  UNREFERENCED_PARAMETER(fL);
  fK = CAAVSOP87_Saturn::K(2305445.0);
  UNREFERENCED_PARAMETER(fK);
  fH = CAAVSOP87_Saturn::H(2305445.0);
  UNREFERENCED_PARAMETER(fH);
  fQ = CAAVSOP87_Saturn::Q(2305445.0);
  UNREFERENCED_PARAMETER(fQ);
  fP = CAAVSOP87_Saturn::P(2305445.0);
  UNREFERENCED_PARAMETER(fP);

  //A sample test for Uranus VSOP87 as taken from vsop87.chk
  fA = CAAVSOP87_Uranus::A(2305445.0);
  UNREFERENCED_PARAMETER(fA);
  fL = CAAVSOP87_Uranus::L(2305445.0);
  UNREFERENCED_PARAMETER(fL);
  fK = CAAVSOP87_Uranus::K(2305445.0);
  UNREFERENCED_PARAMETER(fK);
  fH = CAAVSOP87_Uranus::H(2305445.0);
  UNREFERENCED_PARAMETER(fH);
  fQ = CAAVSOP87_Uranus::Q(2305445.0);
  UNREFERENCED_PARAMETER(fQ);
  fP = CAAVSOP87_Uranus::P(2305445.0);
  UNREFERENCED_PARAMETER(fP);

  //A sample test for Neptune VSOP87 as taken from vsop87.chk
  fA = CAAVSOP87_Neptune::A(2305445.0);
  UNREFERENCED_PARAMETER(fA);
  fL = CAAVSOP87_Neptune::L(2305445.0);
  UNREFERENCED_PARAMETER(fL);
  fK = CAAVSOP87_Neptune::K(2305445.0);
  UNREFERENCED_PARAMETER(fK);
  fH = CAAVSOP87_Neptune::K(2305445.0);
  UNREFERENCED_PARAMETER(fH);
  fQ = CAAVSOP87_Neptune::Q(2305445.0);
  UNREFERENCED_PARAMETER(fQ);
  fP = CAAVSOP87_Neptune::P(2305445.0);
  UNREFERENCED_PARAMETER(fP);

  //A sample test for EMB VSOP87 as taken from vsop87.chk
  fA = CAAVSOP87_EMB::A(2305445.0);
  UNREFERENCED_PARAMETER(fA);
  fL = CAAVSOP87_EMB::L(2305445.0);
  UNREFERENCED_PARAMETER(fL);
  fK = CAAVSOP87_EMB::K(2305445.0);
  UNREFERENCED_PARAMETER(fK);
  fH = CAAVSOP87_EMB::H(2305445.0);
  UNREFERENCED_PARAMETER(fH);
  fQ = CAAVSOP87_EMB::Q(2305445.0);
  UNREFERENCED_PARAMETER(fQ);
  fP = CAAVSOP87_EMB::P(2305445.0);
  UNREFERENCED_PARAMETER(fP);

  //A sample test for Mercury VSOP87A as taken from vsop87.chk
  double fX = CAAVSOP87A_Mercury::X(2341970.0);
  UNREFERENCED_PARAMETER(fX);
  double fY = CAAVSOP87A_Mercury::Y(2341970.0);
  UNREFERENCED_PARAMETER(fY);
  double fZ = CAAVSOP87A_Mercury::Z(2341970.0);
  UNREFERENCED_PARAMETER(fZ);
  double fXDash = CAAVSOP87A_Mercury::X_DASH(2341970.0);
  UNREFERENCED_PARAMETER(fXDash);
  double fYDash = CAAVSOP87A_Mercury::Y_DASH(2341970.0);
  UNREFERENCED_PARAMETER(fYDash);
  double fZDash = CAAVSOP87A_Mercury::Z_DASH(2341970.0);
  UNREFERENCED_PARAMETER(fZDash);

  //A sample test for Venus VSOP87A as taken from vsop87.chk
  fX = CAAVSOP87A_Venus::X(2341970.0);
  UNREFERENCED_PARAMETER(fX);
  fY = CAAVSOP87A_Venus::Y(2341970.0);
  UNREFERENCED_PARAMETER(fY);
  fZ = CAAVSOP87A_Venus::Z(2341970.0);
  UNREFERENCED_PARAMETER(fZ);
  fXDash = CAAVSOP87A_Venus::X_DASH(2341970.0);
  UNREFERENCED_PARAMETER(fXDash);
  fYDash = CAAVSOP87A_Venus::Y_DASH(2341970.0);
  UNREFERENCED_PARAMETER(fYDash);
  fZDash = CAAVSOP87A_Venus::Z_DASH(2341970.0);
  UNREFERENCED_PARAMETER(fZDash);

  //A sample test for Earth VSOP87A as taken from vsop87.chk
  fX = CAAVSOP87A_Earth::X(2341970.0);
  UNREFERENCED_PARAMETER(fX);
  fY = CAAVSOP87A_Earth::Y(2341970.0);
  UNREFERENCED_PARAMETER(fY);
  fZ = CAAVSOP87A_Earth::Z(2341970.0);
  UNREFERENCED_PARAMETER(fZ);
  fXDash = CAAVSOP87A_Earth::X_DASH(2341970.0);
  UNREFERENCED_PARAMETER(fXDash);
  fYDash = CAAVSOP87A_Earth::Y_DASH(2341970.0);
  UNREFERENCED_PARAMETER(fYDash);
  fZDash = CAAVSOP87A_Earth::Z_DASH(2341970.0);
  UNREFERENCED_PARAMETER(fZDash);

  //A sample test for EMB VSOP87A as taken from vsop87.chk
  fX = CAAVSOP87A_EMB::X(2341970.0);
  UNREFERENCED_PARAMETER(fX);
  fY = CAAVSOP87A_EMB::Y(2341970.0);
  UNREFERENCED_PARAMETER(fY);
  fZ = CAAVSOP87A_EMB::Z(2341970.0);
  UNREFERENCED_PARAMETER(fZ);
  fXDash = CAAVSOP87A_EMB::X_DASH(2341970.0);
  UNREFERENCED_PARAMETER(fXDash);
  fYDash = CAAVSOP87A_EMB::Y_DASH(2341970.0);
  UNREFERENCED_PARAMETER(fYDash);
  fZDash = CAAVSOP87A_EMB::Z_DASH(2341970.0);
  UNREFERENCED_PARAMETER(fZDash);

  //A sample test for Mars VSOP87A as taken from vsop87.chk
  fX = CAAVSOP87A_Mars::X(2341970.0);
  UNREFERENCED_PARAMETER(fX);
  fY = CAAVSOP87A_Mars::Y(2341970.0);
  UNREFERENCED_PARAMETER(fY);
  fZ = CAAVSOP87A_Mars::Z(2341970.0);
  UNREFERENCED_PARAMETER(fZ);
  fXDash = CAAVSOP87A_Mars::X_DASH(2341970.0);
  UNREFERENCED_PARAMETER(fXDash);
  fYDash = CAAVSOP87A_Mars::Y_DASH(2341970.0);
  UNREFERENCED_PARAMETER(fYDash);
  fZDash = CAAVSOP87A_Mars::Z_DASH(2341970.0);
  UNREFERENCED_PARAMETER(fZDash);

  //A sample test for Jupiter VSOP87A as taken from vsop87.chk
  fX = CAAVSOP87A_Jupiter::X(2341970.0);
  UNREFERENCED_PARAMETER(fX);
  fY = CAAVSOP87A_Jupiter::Y(2341970.0);
  UNREFERENCED_PARAMETER(fY);
  fZ = CAAVSOP87A_Jupiter::Z(2341970.0);
  UNREFERENCED_PARAMETER(fZ);
  fXDash = CAAVSOP87A_Jupiter::X_DASH(2341970.0);
  UNREFERENCED_PARAMETER(fXDash);
  fYDash = CAAVSOP87A_Jupiter::Y_DASH(2341970.0);
  UNREFERENCED_PARAMETER(fYDash);
  fZDash = CAAVSOP87A_Jupiter::Z_DASH(2341970.0);
  UNREFERENCED_PARAMETER(fZDash);

  //A sample test for Saturn VSOP87A as taken from vsop87.chk
  fX = CAAVSOP87A_Saturn::X(2341970.0);
  UNREFERENCED_PARAMETER(fX);
  fY = CAAVSOP87A_Saturn::Y(2341970.0);
  UNREFERENCED_PARAMETER(fY);
  fZ = CAAVSOP87A_Saturn::Z(2341970.0);
  UNREFERENCED_PARAMETER(fZ);
  fXDash = CAAVSOP87A_Saturn::X_DASH(2341970.0);
  UNREFERENCED_PARAMETER(fXDash);
  fYDash = CAAVSOP87A_Saturn::Y_DASH(2341970.0);
  UNREFERENCED_PARAMETER(fYDash);
  fZDash = CAAVSOP87A_Saturn::Z_DASH(2341970.0);
  UNREFERENCED_PARAMETER(fZDash);

  //A sample test for Uranus VSOP87A as taken from vsop87.chk
  fX = CAAVSOP87A_Uranus::X(2341970.0);
  UNREFERENCED_PARAMETER(fX);
  fY = CAAVSOP87A_Uranus::Y(2341970.0);
  UNREFERENCED_PARAMETER(fY);
  fZ = CAAVSOP87A_Uranus::Z(2341970.0);
  UNREFERENCED_PARAMETER(fZ);
  fXDash = CAAVSOP87A_Uranus::X_DASH(2341970.0);
  UNREFERENCED_PARAMETER(fXDash);
  fYDash = CAAVSOP87A_Uranus::Y_DASH(2341970.0);
  UNREFERENCED_PARAMETER(fYDash);
  fZDash = CAAVSOP87A_Uranus::Z_DASH(2341970.0);
  UNREFERENCED_PARAMETER(fZDash);

  //A sample test for Neptune VSOP87A as taken from vsop87.chk
  fX = CAAVSOP87A_Neptune::X(2341970.0);
  UNREFERENCED_PARAMETER(fX);
  fY = CAAVSOP87A_Neptune::Y(2341970.0);
  UNREFERENCED_PARAMETER(fY);
  fZ = CAAVSOP87A_Neptune::Z(2341970.0);
  UNREFERENCED_PARAMETER(fZ);
  fXDash = CAAVSOP87A_Neptune::X_DASH(2341970.0);
  UNREFERENCED_PARAMETER(fXDash);
  fYDash = CAAVSOP87A_Neptune::Y_DASH(2341970.0);
  UNREFERENCED_PARAMETER(fYDash);
  fZDash = CAAVSOP87A_Neptune::Z_DASH(2341970.0);
  UNREFERENCED_PARAMETER(fZDash);

  //A sample test for Mercury VSOP87B as taken from vsop87.chk
  fL = CAAVSOP87B_Mercury::L(2122820.0);
  UNREFERENCED_PARAMETER(fL);
  double fB = CAAVSOP87B_Mercury::B(2122820.0);
  UNREFERENCED_PARAMETER(fB);
  double fR = CAAVSOP87B_Mercury::R(2122820.0);
  UNREFERENCED_PARAMETER(fR);
  double fLDash = CAAVSOP87B_Mercury::L_DASH(2122820.0);
  UNREFERENCED_PARAMETER(fLDash);
  double fBDash = CAAVSOP87B_Mercury::B_DASH(2122820.0);
  UNREFERENCED_PARAMETER(fBDash);
  double fRDash = CAAVSOP87B_Mercury::R_DASH(2122820.0);
  UNREFERENCED_PARAMETER(fRDash);

  //A sample test for Venus VSOP87B as taken from vsop87.chk
  fL = CAAVSOP87B_Mercury::L(2122820.0);
  UNREFERENCED_PARAMETER(fL);
  fB = CAAVSOP87B_Mercury::B(2122820.0);
  UNREFERENCED_PARAMETER(fB);
  fR = CAAVSOP87B_Mercury::R(2122820.0);
  UNREFERENCED_PARAMETER(fR);
  fLDash = CAAVSOP87B_Mercury::L_DASH(2122820.0);
  UNREFERENCED_PARAMETER(fLDash);
  fBDash = CAAVSOP87B_Mercury::B_DASH(2122820.0);
  UNREFERENCED_PARAMETER(fBDash);
  fRDash = CAAVSOP87B_Mercury::R_DASH(2122820.0);
  UNREFERENCED_PARAMETER(fRDash);

  //A sample test for Earth VSOP87B as taken from vsop87.chk
  fL = CAAVSOP87B_Earth::L(2122820.0);
  UNREFERENCED_PARAMETER(fL);
  fB = CAAVSOP87B_Earth::B(2122820.0);
  UNREFERENCED_PARAMETER(fB);
  fR = CAAVSOP87B_Earth::R(2122820.0);
  UNREFERENCED_PARAMETER(fR);
  fLDash = CAAVSOP87B_Earth::L_DASH(2122820.0);
  UNREFERENCED_PARAMETER(fLDash);
  fBDash = CAAVSOP87B_Earth::B_DASH(2122820.0);
  UNREFERENCED_PARAMETER(fBDash);
  fRDash = CAAVSOP87B_Earth::R_DASH(2122820.0);
  UNREFERENCED_PARAMETER(fRDash);

  //A sample test for Mars VSOP87B as taken from vsop87.chk
  fL = CAAVSOP87B_Mars::L(2122820.0);
  UNREFERENCED_PARAMETER(fL);
  fB = CAAVSOP87B_Mars::B(2122820.0);
  UNREFERENCED_PARAMETER(fB);
  fR = CAAVSOP87B_Mars::R(2122820.0);
  UNREFERENCED_PARAMETER(fR);
  fLDash = CAAVSOP87B_Mars::L_DASH(2122820.0);
  UNREFERENCED_PARAMETER(fLDash);
  fBDash = CAAVSOP87B_Mars::B_DASH(2122820.0);
  UNREFERENCED_PARAMETER(fBDash);
  fRDash = CAAVSOP87B_Mars::R_DASH(2122820.0);
  UNREFERENCED_PARAMETER(fRDash);

  //A sample test for Jupiter VSOP87B as taken from vsop87.chk
  fL = CAAVSOP87B_Jupiter::L(2122820.0);
  UNREFERENCED_PARAMETER(fL);
  fB = CAAVSOP87B_Jupiter::B(2122820.0);
  UNREFERENCED_PARAMETER(fB);
  fR = CAAVSOP87B_Jupiter::R(2122820.0);
  UNREFERENCED_PARAMETER(fR);
  fLDash = CAAVSOP87B_Jupiter::L_DASH(2122820.0);
  UNREFERENCED_PARAMETER(fLDash);
  fBDash = CAAVSOP87B_Jupiter::B_DASH(2122820.0);
  UNREFERENCED_PARAMETER(fBDash);
  fRDash = CAAVSOP87B_Jupiter::R_DASH(2122820.0);
  UNREFERENCED_PARAMETER(fRDash);

  //A sample test for Saturn VSOP87B as taken from vsop87.chk
  fL = CAAVSOP87B_Saturn::L(2122820.0);
  UNREFERENCED_PARAMETER(fL);
  fB = CAAVSOP87B_Saturn::B(2122820.0);
  UNREFERENCED_PARAMETER(fB);
  fR = CAAVSOP87B_Saturn::R(2122820.0);
  UNREFERENCED_PARAMETER(fR);
  fLDash = CAAVSOP87B_Saturn::L_DASH(2122820.0);
  UNREFERENCED_PARAMETER(fLDash);
  fBDash = CAAVSOP87B_Saturn::B_DASH(2122820.0);
  UNREFERENCED_PARAMETER(fBDash);
  fRDash = CAAVSOP87B_Saturn::R_DASH(2122820.0);
  UNREFERENCED_PARAMETER(fRDash);

  //A sample test for Uranus VSOP87B as taken from vsop87.chk
  fL = CAAVSOP87B_Uranus::L(2122820.0);
  UNREFERENCED_PARAMETER(fL);
  fB = CAAVSOP87B_Uranus::B(2122820.0);
  UNREFERENCED_PARAMETER(fB);
  fR = CAAVSOP87B_Uranus::R(2122820.0);
  UNREFERENCED_PARAMETER(fR);
  fLDash = CAAVSOP87B_Uranus::L_DASH(2122820.0);
  UNREFERENCED_PARAMETER(fLDash);
  fBDash = CAAVSOP87B_Uranus::B_DASH(2122820.0);
  UNREFERENCED_PARAMETER(fBDash);
  fRDash = CAAVSOP87B_Uranus::R_DASH(2122820.0);
  UNREFERENCED_PARAMETER(fRDash);

  //A sample test for Neptune VSOP87B as taken from vsop87.chk
  fL = CAAVSOP87B_Neptune::L(2122820.0);
  UNREFERENCED_PARAMETER(fL);
  fB = CAAVSOP87B_Neptune::B(2122820.0);
  UNREFERENCED_PARAMETER(fB);
  fR = CAAVSOP87B_Neptune::R(2122820.0);
  UNREFERENCED_PARAMETER(fR);
  fLDash = CAAVSOP87B_Neptune::L_DASH(2122820.0);
  UNREFERENCED_PARAMETER(fLDash);
  fBDash = CAAVSOP87B_Neptune::B_DASH(2122820.0);
  UNREFERENCED_PARAMETER(fBDash);
  fRDash = CAAVSOP87B_Neptune::R_DASH(2122820.0);
  UNREFERENCED_PARAMETER(fRDash);

  //A sample test for Mercury VSOP87C as taken from vsop87.chk
  fX = CAAVSOP87C_Mercury::X(2195870.0);
  UNREFERENCED_PARAMETER(fX);
  fY = CAAVSOP87C_Mercury::Y(2195870.0);
  UNREFERENCED_PARAMETER(fY);
  fZ = CAAVSOP87C_Mercury::Z(2195870.0);
  UNREFERENCED_PARAMETER(fZ);
  fXDash = CAAVSOP87C_Mercury::X_DASH(2195870.0);
  UNREFERENCED_PARAMETER(fXDash);
  fYDash = CAAVSOP87C_Mercury::Y_DASH(2195870.0);
  UNREFERENCED_PARAMETER(fYDash);
  fZDash = CAAVSOP87C_Mercury::Z_DASH(2195870.0);
  UNREFERENCED_PARAMETER(fZDash);

  //A sample test for Venus VSOP87C as taken from vsop87.chk
  fX = CAAVSOP87C_Venus::X(2195870.0);
  UNREFERENCED_PARAMETER(fX);
  fY = CAAVSOP87C_Venus::Y(2195870.0);
  UNREFERENCED_PARAMETER(fY);
  fZ = CAAVSOP87C_Venus::Z(2195870.0);
  UNREFERENCED_PARAMETER(fZ);
  fXDash = CAAVSOP87C_Venus::X_DASH(2195870.0);
  UNREFERENCED_PARAMETER(fXDash);
  fYDash = CAAVSOP87C_Venus::Y_DASH(2195870.0);
  UNREFERENCED_PARAMETER(fYDash);
  fZDash = CAAVSOP87C_Venus::Z_DASH(2195870.0);
  UNREFERENCED_PARAMETER(fZDash);

  //A sample test for Earth VSOP87C as taken from vsop87.chk
  fX = CAAVSOP87C_Earth::X(2195870.0);
  UNREFERENCED_PARAMETER(fX);
  fY = CAAVSOP87C_Earth::Y(2195870.0);
  UNREFERENCED_PARAMETER(fY);
  fZ = CAAVSOP87C_Earth::Z(2195870.0);
  UNREFERENCED_PARAMETER(fZ);
  fXDash = CAAVSOP87C_Earth::X_DASH(2195870.0);
  UNREFERENCED_PARAMETER(fXDash);
  fYDash = CAAVSOP87C_Earth::Y_DASH(2195870.0);
  UNREFERENCED_PARAMETER(fYDash);
  fZDash = CAAVSOP87C_Earth::Z_DASH(2195870.0);
  UNREFERENCED_PARAMETER(fZDash);

  //A sample test for Mars VSOP87C as taken from vsop87.chk
  fX = CAAVSOP87C_Mars::X(2195870.0);
  UNREFERENCED_PARAMETER(fX);
  fY = CAAVSOP87C_Mars::Y(2195870.0);
  UNREFERENCED_PARAMETER(fY);
  fZ = CAAVSOP87C_Mars::Z(2195870.0);
  UNREFERENCED_PARAMETER(fZ);
  fXDash = CAAVSOP87C_Mars::X_DASH(2195870.0);
  UNREFERENCED_PARAMETER(fXDash);
  fYDash = CAAVSOP87C_Mars::Y_DASH(2195870.0);
  UNREFERENCED_PARAMETER(fYDash);
  fZDash = CAAVSOP87C_Mars::Z_DASH(2195870.0);
  UNREFERENCED_PARAMETER(fZDash);

  //A sample test for Jupiter VSOP87C as taken from vsop87.chk
  fX = CAAVSOP87C_Jupiter::X(2195870.0);
  UNREFERENCED_PARAMETER(fX);
  fY = CAAVSOP87C_Jupiter::Y(2195870.0);
  UNREFERENCED_PARAMETER(fY);
  fZ = CAAVSOP87C_Jupiter::Z(2195870.0);
  UNREFERENCED_PARAMETER(fZ);
  fXDash = CAAVSOP87C_Jupiter::X_DASH(2195870.0);
  UNREFERENCED_PARAMETER(fXDash);
  fYDash = CAAVSOP87C_Jupiter::Y_DASH(2195870.0);
  UNREFERENCED_PARAMETER(fYDash);
  fZDash = CAAVSOP87C_Jupiter::Z_DASH(2195870.0);
  UNREFERENCED_PARAMETER(fZDash);

  //A sample test for Saturn VSOP87C as taken from vsop87.chk
  fX = CAAVSOP87C_Saturn::X(2195870.0);
  UNREFERENCED_PARAMETER(fX);
  fY = CAAVSOP87C_Saturn::Y(2195870.0);
  UNREFERENCED_PARAMETER(fY);
  fZ = CAAVSOP87C_Saturn::Z(2195870.0);
  UNREFERENCED_PARAMETER(fZ);
  fXDash = CAAVSOP87C_Saturn::X_DASH(2195870.0);
  UNREFERENCED_PARAMETER(fXDash);
  fYDash = CAAVSOP87C_Saturn::Y_DASH(2195870.0);
  UNREFERENCED_PARAMETER(fYDash);
  fZDash = CAAVSOP87C_Saturn::Z_DASH(2195870.0);
  UNREFERENCED_PARAMETER(fZDash);

  //A sample test for Uranus VSOP87C as taken from vsop87.chk
  fX = CAAVSOP87C_Uranus::X(2195870.0);
  UNREFERENCED_PARAMETER(fX);
  fY = CAAVSOP87C_Uranus::Y(2195870.0);
  UNREFERENCED_PARAMETER(fY);
  fZ = CAAVSOP87C_Uranus::Z(2195870.0);
  UNREFERENCED_PARAMETER(fZ);
  fXDash = CAAVSOP87C_Uranus::X_DASH(2195870.0);
  UNREFERENCED_PARAMETER(fXDash);
  fYDash = CAAVSOP87C_Uranus::Y_DASH(2195870.0);
  UNREFERENCED_PARAMETER(fYDash);
  fZDash = CAAVSOP87C_Uranus::Z_DASH(2195870.0);
  UNREFERENCED_PARAMETER(fZDash);

  //A sample test for Neptune VSOP87C as taken from vsop87.chk
  fX = CAAVSOP87C_Neptune::X(2195870.0);
  UNREFERENCED_PARAMETER(fX);
  fY = CAAVSOP87C_Neptune::Y(2195870.0);
  UNREFERENCED_PARAMETER(fY);
  fZ = CAAVSOP87C_Neptune::Z(2195870.0);
  UNREFERENCED_PARAMETER(fZ);
  fXDash = CAAVSOP87C_Neptune::X_DASH(2195870.0);
  UNREFERENCED_PARAMETER(fXDash);
  fYDash = CAAVSOP87C_Neptune::Y_DASH(2195870.0);
  UNREFERENCED_PARAMETER(fYDash);
  fZDash = CAAVSOP87C_Neptune::Z_DASH(2195870.0);
  UNREFERENCED_PARAMETER(fZDash);

  //A sample test for Mercury VSOP87D as taken from vsop87.chk
  fL = CAAVSOP87D_Mercury::L(2122820.0);
  UNREFERENCED_PARAMETER(fL);
  fB = CAAVSOP87D_Mercury::B(2122820.0);
  UNREFERENCED_PARAMETER(fB);
  fR = CAAVSOP87D_Mercury::R(2122820.0);
  UNREFERENCED_PARAMETER(fR);
  fLDash = CAAVSOP87D_Mercury::L_DASH(2122820.0);
  UNREFERENCED_PARAMETER(fLDash);
  fBDash = CAAVSOP87D_Mercury::B_DASH(2122820.0);
  UNREFERENCED_PARAMETER(fBDash);
  fRDash = CAAVSOP87D_Mercury::R_DASH(2122820.0);
  UNREFERENCED_PARAMETER(fRDash);

  //A sample test for Venus VSOP87D as taken from vsop87.chk
  fL = CAAVSOP87D_Venus::L(2122820.0);
  UNREFERENCED_PARAMETER(fL);
  fB = CAAVSOP87D_Venus::B(2122820.0);
  UNREFERENCED_PARAMETER(fB);
  fR = CAAVSOP87D_Venus::R(2122820.0);
  UNREFERENCED_PARAMETER(fR);
  fLDash = CAAVSOP87D_Venus::L_DASH(2122820.0);
  UNREFERENCED_PARAMETER(fLDash);
  fBDash = CAAVSOP87D_Venus::B_DASH(2122820.0);
  UNREFERENCED_PARAMETER(fBDash);
  fRDash = CAAVSOP87D_Venus::R_DASH(2122820.0);
  UNREFERENCED_PARAMETER(fRDash);

  //A sample test for Earth VSOP87D as taken from vsop87.chk
  fL = CAAVSOP87D_Earth::L(2122820.0);
  UNREFERENCED_PARAMETER(fL);
  fB = CAAVSOP87D_Earth::B(2122820.0);
  UNREFERENCED_PARAMETER(fB);
  fR = CAAVSOP87D_Earth::R(2122820.0);
  UNREFERENCED_PARAMETER(fR);
  fLDash = CAAVSOP87D_Earth::L_DASH(2122820.0);
  UNREFERENCED_PARAMETER(fLDash);
  fBDash = CAAVSOP87D_Earth::B_DASH(2122820.0);
  UNREFERENCED_PARAMETER(fBDash);
  fRDash = CAAVSOP87D_Earth::R_DASH(2122820.0);
  UNREFERENCED_PARAMETER(fRDash);

  //A sample test for Mars VSOP87D as taken from vsop87.chk
  fL = CAAVSOP87D_Mars::L(2122820.0);
  UNREFERENCED_PARAMETER(fL);
  fB = CAAVSOP87D_Mars::B(2122820.0);
  UNREFERENCED_PARAMETER(fB);
  fR = CAAVSOP87D_Mars::R(2122820.0);
  UNREFERENCED_PARAMETER(fR);
  fLDash = CAAVSOP87D_Mars::L_DASH(2122820.0);
  UNREFERENCED_PARAMETER(fLDash);
  fBDash = CAAVSOP87D_Mars::B_DASH(2122820.0);
  UNREFERENCED_PARAMETER(fBDash);
  fRDash = CAAVSOP87D_Mars::R_DASH(2122820.0);
  UNREFERENCED_PARAMETER(fRDash);

  //A sample test for Jupiter VSOP87D as taken from vsop87.chk
  fL = CAAVSOP87D_Jupiter::L(2122820.0);
  UNREFERENCED_PARAMETER(fL);
  fB = CAAVSOP87D_Jupiter::B(2122820.0);
  UNREFERENCED_PARAMETER(fB);
  fR = CAAVSOP87D_Jupiter::R(2122820.0);
  UNREFERENCED_PARAMETER(fR);
  fLDash = CAAVSOP87D_Jupiter::L_DASH(2122820.0);
  UNREFERENCED_PARAMETER(fLDash);
  fBDash = CAAVSOP87D_Jupiter::B_DASH(2122820.0);
  UNREFERENCED_PARAMETER(fBDash);
  fRDash = CAAVSOP87D_Jupiter::R_DASH(2122820.0);
  UNREFERENCED_PARAMETER(fRDash);

  //A sample test for Saturn VSOP87D as taken from vsop87.chk
  fL = CAAVSOP87D_Saturn::L(2122820.0);
  UNREFERENCED_PARAMETER(fL);
  fB = CAAVSOP87D_Saturn::B(2122820.0);
  UNREFERENCED_PARAMETER(fB);
  fR = CAAVSOP87D_Saturn::R(2122820.0);
  UNREFERENCED_PARAMETER(fR);
  fLDash = CAAVSOP87D_Saturn::L_DASH(2122820.0);
  UNREFERENCED_PARAMETER(fLDash);
  fBDash = CAAVSOP87D_Saturn::B_DASH(2122820.0);
  UNREFERENCED_PARAMETER(fBDash);
  fRDash = CAAVSOP87D_Saturn::R_DASH(2122820.0);
  UNREFERENCED_PARAMETER(fRDash);

  //A sample test for Uranus VSOP87D as taken from vsop87.chk
  fL = CAAVSOP87D_Uranus::L(2122820.0);
  UNREFERENCED_PARAMETER(fL);
  fB = CAAVSOP87D_Uranus::B(2122820.0);
  UNREFERENCED_PARAMETER(fB);
  fR = CAAVSOP87D_Uranus::R(2122820.0);
  UNREFERENCED_PARAMETER(fR);
  fLDash = CAAVSOP87D_Uranus::L_DASH(2122820.0);
  UNREFERENCED_PARAMETER(fLDash);
  fBDash = CAAVSOP87D_Uranus::B_DASH(2122820.0);
  UNREFERENCED_PARAMETER(fBDash);
  fRDash = CAAVSOP87D_Uranus::R_DASH(2122820.0);
  UNREFERENCED_PARAMETER(fRDash);

  //A sample test for Neptune VSOP87D as taken from vsop87.chk
  fL = CAAVSOP87D_Neptune::L(2122820.0);
  UNREFERENCED_PARAMETER(fL);
  fB = CAAVSOP87D_Neptune::B(2122820.0);
  UNREFERENCED_PARAMETER(fB);
  fR = CAAVSOP87D_Neptune::R(2122820.0);
  UNREFERENCED_PARAMETER(fR);
  fLDash = CAAVSOP87D_Neptune::L_DASH(2122820.0);
  UNREFERENCED_PARAMETER(fLDash);
  fBDash = CAAVSOP87D_Neptune::B_DASH(2122820.0);
  UNREFERENCED_PARAMETER(fBDash);
  fRDash = CAAVSOP87D_Neptune::R_DASH(2122820.0);
  UNREFERENCED_PARAMETER(fRDash);

  //A sample test for Sun VSOP87E as taken from vsop87.chk
  fX = CAAVSOP87E_Sun::X(2195870.0);
  UNREFERENCED_PARAMETER(fX);
  fY = CAAVSOP87E_Sun::Y(2195870.0);
  UNREFERENCED_PARAMETER(fY);
  fZ = CAAVSOP87E_Sun::Z(2195870.0);
  UNREFERENCED_PARAMETER(fZ);
  fXDash = CAAVSOP87E_Sun::X_DASH(2195870.0);
  UNREFERENCED_PARAMETER(fXDash);
  fYDash = CAAVSOP87E_Sun::Y_DASH(2195870.0);
  UNREFERENCED_PARAMETER(fYDash);
  fZDash = CAAVSOP87E_Sun::Z_DASH(2195870.0);
  UNREFERENCED_PARAMETER(fZDash);

  //A sample test for Mercury VSOP87E as taken from vsop87.chk
  fX = CAAVSOP87E_Mercury::X(2195870.0);
  UNREFERENCED_PARAMETER(fX);
  fY = CAAVSOP87E_Mercury::Y(2195870.0);
  UNREFERENCED_PARAMETER(fY);
  fZ = CAAVSOP87E_Mercury::Z(2195870.0);
  UNREFERENCED_PARAMETER(fZ);
  fXDash = CAAVSOP87E_Mercury::X_DASH(2195870.0);
  UNREFERENCED_PARAMETER(fXDash);
  fYDash = CAAVSOP87E_Mercury::Y_DASH(2195870.0);
  UNREFERENCED_PARAMETER(fYDash);
  fZDash = CAAVSOP87E_Mercury::Z_DASH(2195870.0);
  UNREFERENCED_PARAMETER(fZDash);

  //A sample test for Venus VSOP87E as taken from vsop87.chk
  fX = CAAVSOP87E_Venus::X(2195870.0);
  UNREFERENCED_PARAMETER(fX);
  fY = CAAVSOP87E_Venus::Y(2195870.0);
  UNREFERENCED_PARAMETER(fY);
  fZ = CAAVSOP87E_Venus::Z(2195870.0);
  UNREFERENCED_PARAMETER(fZ);
  fXDash = CAAVSOP87E_Venus::X_DASH(2195870.0);
  UNREFERENCED_PARAMETER(fXDash);
  fYDash = CAAVSOP87E_Venus::Y_DASH(2195870.0);
  UNREFERENCED_PARAMETER(fYDash);
  fZDash = CAAVSOP87E_Venus::Z_DASH(2195870.0);
  UNREFERENCED_PARAMETER(fZDash);

  //A sample test for Earth VSOP87E as taken from vsop87.chk
  fX = CAAVSOP87E_Earth::X(2195870.0);
  UNREFERENCED_PARAMETER(fX);
  fY = CAAVSOP87E_Earth::Y(2195870.0);
  UNREFERENCED_PARAMETER(fY);
  fZ = CAAVSOP87E_Earth::Z(2195870.0);
  UNREFERENCED_PARAMETER(fZ);
  fXDash = CAAVSOP87E_Earth::X_DASH(2195870.0);
  UNREFERENCED_PARAMETER(fXDash);
  fYDash = CAAVSOP87E_Earth::Y_DASH(2195870.0);
  UNREFERENCED_PARAMETER(fYDash);
  fZDash = CAAVSOP87E_Earth::Z_DASH(2195870.0);
  UNREFERENCED_PARAMETER(fZDash);

  //A sample test for Mars VSOP87E as taken from vsop87.chk
  fX = CAAVSOP87E_Mars::X(2195870.0);
  UNREFERENCED_PARAMETER(fX);
  fY = CAAVSOP87E_Mars::Y(2195870.0);
  UNREFERENCED_PARAMETER(fY);
  fZ = CAAVSOP87E_Mars::Z(2195870.0);
  UNREFERENCED_PARAMETER(fZ);
  fXDash = CAAVSOP87E_Mars::X_DASH(2195870.0);
  UNREFERENCED_PARAMETER(fXDash);
  fYDash = CAAVSOP87E_Mars::Y_DASH(2195870.0);
  UNREFERENCED_PARAMETER(fYDash);
  fZDash = CAAVSOP87E_Mars::Z_DASH(2195870.0);
  UNREFERENCED_PARAMETER(fZDash);

  //A sample test for Jupiter VSOP87E as taken from vsop87.chk
  fX = CAAVSOP87E_Jupiter::X(2195870.0);
  UNREFERENCED_PARAMETER(fX);
  fY = CAAVSOP87E_Jupiter::Y(2195870.0);
  UNREFERENCED_PARAMETER(fY);
  fZ = CAAVSOP87E_Jupiter::Z(2195870.0);
  UNREFERENCED_PARAMETER(fZ);
  fXDash = CAAVSOP87E_Jupiter::X_DASH(2195870.0);
  UNREFERENCED_PARAMETER(fXDash);
  fYDash = CAAVSOP87E_Jupiter::Y_DASH(2195870.0);
  UNREFERENCED_PARAMETER(fYDash);
  fZDash = CAAVSOP87E_Jupiter::Z_DASH(2195870.0);
  UNREFERENCED_PARAMETER(fZDash);

  //A sample test for Saturn VSOP87E as taken from vsop87.chk
  fX = CAAVSOP87E_Saturn::X(2195870.0);
  UNREFERENCED_PARAMETER(fX);
  fY = CAAVSOP87E_Saturn::Y(2195870.0);
  UNREFERENCED_PARAMETER(fY);
  fZ = CAAVSOP87E_Saturn::Z(2195870.0);
  UNREFERENCED_PARAMETER(fZ);
  fXDash = CAAVSOP87E_Saturn::X_DASH(2195870.0);
  UNREFERENCED_PARAMETER(fXDash);
  fYDash = CAAVSOP87E_Saturn::Y_DASH(2195870.0);
  UNREFERENCED_PARAMETER(fYDash);
  fZDash = CAAVSOP87E_Saturn::Z_DASH(2195870.0);
  UNREFERENCED_PARAMETER(fZDash);

  //A sample test for Uranus VSOP87E as taken from vsop87.chk
  fX = CAAVSOP87E_Uranus::X(2195870.0);
  UNREFERENCED_PARAMETER(fX);
  fY = CAAVSOP87E_Uranus::Y(2195870.0);
  UNREFERENCED_PARAMETER(fY);
  fZ = CAAVSOP87E_Uranus::Z(2195870.0);
  UNREFERENCED_PARAMETER(fZ);
  fXDash = CAAVSOP87E_Uranus::X_DASH(2195870.0);
  UNREFERENCED_PARAMETER(fXDash);
  fYDash = CAAVSOP87E_Uranus::Y_DASH(2195870.0);
  UNREFERENCED_PARAMETER(fYDash);
  fZDash = CAAVSOP87E_Uranus::Z_DASH(2195870.0);
  UNREFERENCED_PARAMETER(fZDash);

  //A sample test for Neptune VSOP87E as taken from vsop87.chk
  fX = CAAVSOP87E_Neptune::X(2195870.0);
  UNREFERENCED_PARAMETER(fX);
  fY = CAAVSOP87E_Neptune::Y(2195870.0);
  UNREFERENCED_PARAMETER(fY);
  fZ = CAAVSOP87E_Neptune::Z(2195870.0);
  UNREFERENCED_PARAMETER(fZ);
  fXDash = CAAVSOP87E_Neptune::X_DASH(2195870.0);
  UNREFERENCED_PARAMETER(fXDash);
  fYDash = CAAVSOP87E_Neptune::Y_DASH(2195870.0);
  UNREFERENCED_PARAMETER(fYDash);
  fZDash = CAAVSOP87E_Neptune::Z_DASH(2195870.0);
  UNREFERENCED_PARAMETER(fZDash);
#endif //#ifndef AAPLUS_VSOP87_NO_HIGH_PRECISION

  return 0;
}
