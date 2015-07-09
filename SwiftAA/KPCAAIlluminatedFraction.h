//
//  KPCAAIlluminatedFraction.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 09/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KPCAAIlluminatedFraction : NSObject

+ (double)PhaseAngle:(double)r R:(double)R Delta:(double)Delta;
+ (double)PhaseAngle:(double)R R0:(double)R0 B:(double)B L:(double)L L:(double)L0 Delta:(double)Delta;
+ (double)PhaseAngleRectangular:(double)x y:(double)y z:(double)z B:(double)B L:(double)L Delta:(double)Delta;
+ (double)IlluminatedFraction:(double)PhaseAngle;
+ (double)IlluminatedFraction:(double)r R:(double)R Delta:(double)Delta;
+ (double)MercuryMagnitudeMuller:(double)r Delta:(double)Delta i:(double)i;
+ (double)VenusMagnitudeMuller:(double)r Delta:(double)Delta i:(double)i;
+ (double)MarsMagnitudeMuller:(double)r Delta:(double)Delta i:(double)i;
+ (double)JupiterMagnitudeMuller:(double)r Delta:(double)Delta;
+ (double)SaturnMagnitudeMuller:(double)r Delta:(double)Delta DeltaU:(double)DeltaU B:(double)B;
+ (double)UranusMagnitudeMuller:(double)r Delta:(double)Delta;
+ (double)NeptuneMagnitudeMuller:(double)r Delta:(double)Delta;
+ (double)MercuryMagnitudeAA:(double)r Delta:(double)Delta i:(double)i;
+ (double)VenusMagnitudeAA:(double)r Delta:(double)Delta i:(double)i;
+ (double)MarsMagnitudeAA:(double)r Delta:(double)Delta i:(double)i;
+ (double)JupiterMagnitudeAA:(double)r Delta:(double)Delta i:(double)i;
+ (double)SaturnMagnitudeAA:(double)r Delta:(double)Delta DeltaU:(double)DeltaU B:(double)B;
+ (double)UranusMagnitudeAA:(double)r Delta:(double)Delta;
+ (double)NeptuneMagnitudeAA:(double)r Delta:(double)Delta;
+ (double)PlutoMagnitudeAA:(double)r Delta:(double)Delta;

@end
