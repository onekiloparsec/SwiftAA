#if _MSC_VER > 1000
#pragma once
#endif

#ifndef STRICT
#define STRICT
#endif

#ifndef WINVER
#define WINVER 0x0502
#endif

#ifndef _WIN32_WINNT
#define _WIN32_WINNT 0x0502
#endif

#ifndef _WIN32_WINDOWS
#define _WIN32_WINDOWS 0x0502
#endif

#ifndef _WIN32_IE
#define _WIN32_IE 0x0600
#endif

#define VC_EXTRALEAN //Exclude rarely-used stuff from Windows headers
#define _ATL_CSTRING_EXPLICIT_CONSTRUCTORS //some CString constructors will be explicit
#define _AFX_ALL_WARNINGS //turns off MFC's hiding of some common and often safely ignored warning messages

//#define AAPLUS_NO_ELP2000 //Uncomment to test exclusion of ELP2000 from AA+
#define AAPLUS_NO_ELPMPP02 //Uncomment to test exclusion of ELPMPP02 from AA+
//#define AAPLUS_NO_VSOP87 //Uncomment to test exclusion of Full VSOP87 from AA+

#ifndef _SECURE_ATL
#define _SECURE_ATL 1 //Use the Secure C Runtime in ATL
#endif
