//
//  KPCAADiameters.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 04/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import <Foundation/Foundation.h>

double KPCAASunSemidiameterA(double Delta);
double KPCAAMercurySemidiameterA(double Delta);
double KPCAAVenusSemidiameterA(double Delta);
double KPCAAMarsSemidiameterA(double Delta);
double KPCAAJupiterEquatorialSemidiameterA(double Delta);
double KPCAAJupiterPolarSemidiameterA(double Delta);
double KPCAASaturnEquatorialSemidiameterA(double Delta);
double KPCAASaturnPolarSemidiameterA(double Delta);
double KPCAAApparentSaturnPolarSemidiameterA(double Delta, double B);
double KPCAAUranusSemidiameterA(double Delta);
double KPCAANeptuneSemidiameterA(double Delta);

double KPCAAMercurySemidiameterB(double Delta);
double KPCAAVenusSemidiameterB(double Delta);
double KPCAAMarsSemidiameterB(double Delta);
double KPCAAJupiterEquatorialSemidiameterB(double Delta);
double KPCAAJupiterPolarSemidiameterB(double Delta);
double KPCAASaturnEquatorialSemidiameterB(double Delta);
double KPCAASaturnPolarSemidiameterB(double Delta);
double KPCAAApparentSaturnPolarSemidiameterB(double Delta, double B);
double KPCAAUranusSemidiameterB(double Delta);
double KPCAANeptuneSemidiameterB(double Delta);
double KPCAAPlutoSemidiameterB(double Delta);

double KPCAAGeocentricMoonSemidiameter(double Delta);
double KPCAATopocentricMoonSemidiameter(double DistanceDelta, double Delta, double H, double Latitude, double Height);
double KPCAAAsteroidDiameter(double H, double A);
double KPCAAApparentAsteroidDiameter(double H, double A);

