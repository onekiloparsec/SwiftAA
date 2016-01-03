//
//  KPCAARiseTransitSet.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 10/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef struct KPCAARiseTransitSetDetails {
    BOOL isRiseValid;
    double Rise;
    BOOL isTransitAboveHorizon;
    double Transit;
    BOOL isSetValid;
    double Set;
} KPCAARiseTransitSetDetails;

KPCAARiseTransitSetDetails KPCAARiseTransitSetCalculate(double JD,
                                                        double Alpha1,
                                                        double Delta1,
                                                        double Alpha2,
                                                        double Delta2,
                                                        double Alpha3,
                                                        double Delta3,
                                                        double Longitude,
                                                        double Latitude,
                                                        double h0);

