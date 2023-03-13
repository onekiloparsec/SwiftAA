// This header exists to provide a bootstrap for various platforms, either via importing Foundation or providing the
// needed imports and defines for platforms without Foundation readily available.

#ifndef PlatformHelpers_h
#define PlatformHelpers_h

// Set to 1 to never import Foundation, even if on an Apple platform. Useful for testing etc.
#define NEVER_USE_FOUNDATION 1

#ifdef TARGET_OS_OSX
    #if (TARGET_OS_OSX || TARGET_OS_MACCATALYST || TARGET_OS_IOS || TARGET_OS_WATCH) && !NEVER_USE_FOUNDATION
        #define SHOULD_IMPORT_FOUNDATION 1
    #else
        #define SHOULD_IMPORT_FOUNDATION 0
    #endif
#else
    #define SHOULD_IMPORT_FOUNDATION 0
#endif

#if SHOULD_IMPORT_FOUNDATION
#import <Foundation/Foundation.h>
#else

// The following imports and defines are pinched from parts of Foundation. They're needed for the ObjC++ bridge to build.
#include "math.h"
#include "stdbool.h"

#if __LP64__ || NS_BUILD_32_LIKE_64
typedef long NSInteger;
typedef unsigned long NSUInteger;
#else
typedef int NSInteger;
typedef unsigned int NSUInteger;
#endif

#endif // Foundation check
#endif /* PlatformHelpers_h */
