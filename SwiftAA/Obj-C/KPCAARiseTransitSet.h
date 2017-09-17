//
//  KPCAARiseTransitSet.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 10/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import <Foundation/Foundation.h>

#ifdef __cplusplus
extern "C" {
#endif

typedef struct KPCAARiseTransitSetDetails {
    BOOL isRiseValid;
    double Rise;
    BOOL isTransitAboveHorizon;
    double Transit;
    BOOL isSetValid;
    double Set;
} KPCAARiseTransitSetDetails;

KPCAARiseTransitSetDetails KPCAARiseTransitSet_Calculate(double JD,
                                                         double Alpha1,
                                                         double Delta1,
                                                         double Alpha2,
                                                         double Delta2,
                                                         double Alpha3,
                                                         double Delta3,
                                                         double Longitude,
                                                         double Latitude,
                                                         double h0);

#if __cplusplus
}
#endif
