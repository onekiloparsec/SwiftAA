//
//  KPCAAAngularSeparation.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 04/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import <Foundation/Foundation.h>


double KPCSeparation(double Alpha1, double Delta1, double Alpha2, double Delta2);

double KPCPositionAngle(double Alpha1, double Delta1, double Alpha2, double Delta2);

double KPCDistanceFromGreatArc(double Alpha1, double Delta1, double Alpha2, double Delta2, double Alpha3, double Delta3);

double KPCSmallestCircle(double Alpha1, double Delta1, double Alpha2, double Delta2, double Alpha3, double Delta3, bool *bType1);
