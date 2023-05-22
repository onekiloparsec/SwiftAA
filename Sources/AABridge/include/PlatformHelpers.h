// This header exists to provide a bootstrap for various platforms, either via importing Foundation or providing the
// needed imports and defines for platforms without Foundation readily available.

#ifndef PlatformHelpers_h
#define PlatformHelpers_h

#ifdef TARGET_OS_OSX
    #if TARGET_OS_OSX || TARGET_OS_MACCATALYST || TARGET_OS_IOS || TARGET_OS_WATCH
        #define IS_ON_APPLE_PLATFORM 1
    #else
        #define IS_ON_APPLE_PLATFORM 0
    #endif
#else
    #define IS_ON_APPLE_PLATFORM 0
#endif

// The following imports and defines are pinched from parts of Foundation. They're needed for the bridge to build.
#include "math.h"
#include "stdbool.h"

#if __LP64__ || NS_BUILD_32_LIKE_64
typedef long NSInteger;
typedef unsigned long NSUInteger;
#else
typedef int NSInteger;
typedef unsigned int NSUInteger;
#endif

#endif /* PlatformHelpers_h */
