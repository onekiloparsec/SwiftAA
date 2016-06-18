//
//  KPCAAAngularSeparation.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 04/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import <Foundation/Foundation.h>

#ifdef __cplusplus
extern "C" {
#endif

double KPCAngularSeparation(double Alpha1, double Delta1, double Alpha2, double Delta2);

double KPCPositionAngle(double Alpha1, double Delta1, double Alpha2, double Delta2);

double KPCDistanceFromGreatArc(double Alpha1, double Delta1, double Alpha2, double Delta2, double Alpha3, double Delta3);

double KPCSmallestCircle(double Alpha1, double Delta1, double Alpha2, double Delta2, double Alpha3, double Delta3, bool *bType1);

#if __cplusplus
}
#endif
