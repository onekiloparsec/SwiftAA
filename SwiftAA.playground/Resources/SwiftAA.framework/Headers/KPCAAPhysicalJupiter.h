//
//  KPCAAPhysicalJupiter.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 10/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import <Foundation/Foundation.h>

#ifdef __cplusplus
extern "C" {
#endif

typedef struct KPCAAPhysicalJupiterDetails {
    double DE;
    double DS;
    double Geometricw1;
    double Geometricw2;
    double Apparentw1;
    double Apparentw2;
    double P;
} KPCAAPhysicalJupiterDetails;

KPCAAPhysicalJupiterDetails KPCAAPhysicalJupiter_CalculateDetails(double JD, BOOL highPrecision);

#if __cplusplus
}
#endif
