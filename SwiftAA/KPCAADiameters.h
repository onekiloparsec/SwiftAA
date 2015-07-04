//
//  KPCAADiameters.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 04/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KPCAADiameters : NSObject

+ (double)SunSemidiameterA:(double)Delta;
+ (double)MercurySemidiameterA:(double)Delta;
+ (double)VenusSemidiameterA:(double)Delta;
+ (double)MarsSemidiameterA:(double)Delta;
+ (double)JupiterEquatorialSemidiameterA:(double)Delta;
+ (double)JupiterPolarSemidiameterA:(double)Delta;
+ (double)SaturnEquatorialSemidiameterA:(double)Delta;
+ (double)SaturnPolarSemidiameterA:(double)Delta;
+ (double)ApparentSaturnPolarSemidiameterA:(double)Delta B:(double)B;
+ (double)UranusSemidiameterA:(double)Delta;
+ (double)NeptuneSemidiameterA:(double)Delta;
+ (double)MercurySemidiameterB:(double)Delta;
+ (double)VenusSemidiameterB:(double)Delta;
+ (double)MarsSemidiameterB:(double)Delta;
+ (double)JupiterEquatorialSemidiameterB:(double)Delta;
+ (double)JupiterPolarSemidiameterB:(double)Delta;
+ (double)SaturnEquatorialSemidiameterB:(double)Delta;
+ (double)SaturnPolarSemidiameterB:(double)Delta;
+ (double)ApparentSaturnPolarSemidiameterB:(double)Delta B:(double)B;
+ (double)UranusSemidiameterB:(double)Delta;
+ (double)NeptuneSemidiameterB:(double)Delta;
+ (double)PlutoSemidiameterB:(double)Delta;
+ (double)GeocentricMoonSemidiameter:(double)Delta;
+ (double)TopocentricMoonSemidiameter:(double)DistanceDelta Delta:(double)Delta H:(double)H latitude:(double)Latitude height:(double)Height;
+ (double)AsteroidDiameter:(double)H A:(double)A;
+ (double)ApparentAsteroidDiameter:(double)H A:(double)A;

@end
