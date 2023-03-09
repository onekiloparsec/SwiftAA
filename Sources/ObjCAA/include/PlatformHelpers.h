// This header exists to provide a bootstrap for various platforms, either via importing Foundation or providing the
// needed imports and defines for platforms without Foundation readily available.

#ifndef PlatformHelpers_h
#define PlatformHelpers_h

// Set to 1 to never import Foundation, even if on an Apple platform. Useful for testing etc.
#define NEVER_USE_FOUNDATION 1

#include "TargetConditionals.h"

#if (TARGET_OS_OSX || TARGET_OS_MACCATALYST || TARGET_OS_IOS || TARGET_OS_WATCH) && !NEVER_USE_FOUNDATION
#import <Foundation/Foundation.h>
#else

// The following imports and defines are pinched from parts of Foundation. They're needed for the ObjC++ bridge to build.
#include "math.h"
#include "stdbool.h"

/// Type to represent a boolean value.

#if defined(__OBJC_BOOL_IS_BOOL)
    // Honor __OBJC_BOOL_IS_BOOL when available.
#   if __OBJC_BOOL_IS_BOOL
#       define OBJC_BOOL_IS_BOOL 1
#   else
#       define OBJC_BOOL_IS_BOOL 0
#   endif
#else
    // __OBJC_BOOL_IS_BOOL not set.
#   if TARGET_OS_OSX || TARGET_OS_MACCATALYST || ((TARGET_OS_IOS || 0) && !__LP64__ && !__ARM_ARCH_7K)
#      define OBJC_BOOL_IS_BOOL 0
#   else
#      define OBJC_BOOL_IS_BOOL 1
#   endif
#endif

#if OBJC_BOOL_IS_BOOL
    typedef bool BOOL;
#else
#   define OBJC_BOOL_IS_CHAR 1
    typedef signed char BOOL;
    // BOOL is explicitly signed so @encode(BOOL) == "c" rather than "C"
    // even if -funsigned-char is used.
#endif

#define OBJC_BOOL_DEFINED

#if __has_feature(objc_bool)
#define YES __objc_yes
#define NO  __objc_no
#else
#define YES ((BOOL)1)
#define NO  ((BOOL)0)
#endif

#if __LP64__ || NS_BUILD_32_LIKE_64
typedef long NSInteger;
typedef unsigned long NSUInteger;
#else
typedef int NSInteger;
typedef unsigned int NSUInteger;
#endif
#define __CF_ENUM_ATTRIBUTES __attribute__((enum_extensibility(open)))
#define __CF_CLOSED_ENUM_ATTRIBUTES __attribute__((enum_extensibility(closed)))
#define __CF_OPTIONS_ATTRIBUTES __attribute__((flag_enum,enum_extensibility(open)))

#define __CF_NAMED_ENUM(_type, _name)     enum __CF_ENUM_ATTRIBUTES _name : _type _name; enum _name : _type
#define __CF_ANON_ENUM(_type)             enum __CF_ENUM_ATTRIBUTES : _type
#define CF_CLOSED_ENUM(_type, _name)      enum __CF_CLOSED_ENUM_ATTRIBUTES _name : _type _name; enum _name : _type
#if (__cplusplus)
#define CF_OPTIONS(_type, _name) _type _name; enum __CF_OPTIONS_ATTRIBUTES : _type
#else
#define CF_OPTIONS(_type, _name) enum __CF_OPTIONS_ATTRIBUTES _name : _type _name; enum _name : _type
#endif

#define __CF_ENUM_GET_MACRO(_1, _2, NAME, ...) NAME

#define CF_ENUM(...) __CF_ENUM_GET_MACRO(__VA_ARGS__, __CF_NAMED_ENUM, __CF_ANON_ENUM, )(__VA_ARGS__)

#define NS_ENUM(...) CF_ENUM(__VA_ARGS__)

#endif // OS check
#endif /* PlatformHelpers_h */
