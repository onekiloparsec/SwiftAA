//
//  KPCAAMoonMaxDeclinations.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 09/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import <Foundation/Foundation.h>

#ifdef __cplusplus
extern "C" {
#endif

double KPCAAMoonMaxDeclinations_K(double Year);
double KPCAAMoonMaxDeclinations_MeanGreatestDeclination(double k, BOOL northerly);
double KPCAAMoonMaxDeclinations_MeanGreatestDeclinationValue(double k);
double KPCAAMoonMaxDeclinations_TrueGreatestDeclination(double k, BOOL northerly);
double KPCAAMoonMaxDeclinations_TrueGreatestDeclinationValue(double k, BOOL northerly);

#if __cplusplus
}
#endif
