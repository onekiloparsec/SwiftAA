/*
Module : AAMars.cpp
Purpose: Implementation for the algorithms which obtain the heliocentric position of Mars
Created: PJN / 29-12-2003
History: PJN / 18-03-2012 1. All global "g_*" tables are now const. Thanks to Roger Dahl for reporting this 
                          issue when compiling AA+ on ARM.
         PJN / 04-08-2013 1. Fixed a transcription error in the second coefficient used to calculate the B2 
                          term for the ecliptic latitude of Mars. Thanks to Isaac Clark for reporting this 
                          issue.
                          2. Fixed a transcription error in the third coefficient used to calculate the B2 
                          term for the ecliptic latitude of Mars. Thanks to Isaac Clark for reporting this 
                          issue. 
                          3. Spot tests indicate that these two changes only affected the the ecliptic 
                          latitude in the eight decimal place.
                          4. Updated copyright details
         PJN / 16-09-2015 1. CAAMars::EclipticLongitude, EclipticLatitude & RadiusVector now include a
                          "bool bHighPrecision" parameter which if set to true means the code uses the full
                          VSOP87 theory rather than the truncated theory as presented in Meeus's book.
         PJN / 01-08-2017 1. Fixed up alignment of lookup tables in AAMars.cpp module
         PJN / 18-08-2019 1. Fixed some further compiler warnings when using VC 2019 Preview v16.3.0 Preview 2.0
         PJN / 13-04-2020 1. Reworked C arrays to use std::array
         PJN / 26-06-2022 1. Updated all the code in AAMars.cpp to use C++ uniform initialization for all
                          variable declarations.

Copyright (c) 2003 - 2023 by PJ Naughter (Web: www.naughter.com, Email: pjna@naughter.com)

All rights reserved.

Copyright / Usage Details:

You are allowed to include the source code in any product (commercial, shareware, freeware or otherwise) 
when your product is released in binary form. You are allowed to modify the source code in any way you want 
except you cannot modify the copyright details at the top of each module. If you want to distribute source 
code with your application, then you are only allowed to distribute versions released by the author. This is 
to maintain a single distribution point for the source code.

*/


//////////////////// Includes /////////////////////////////////////////////////

#include "stdafx.h"
#include "AAMars.h"
#include "AACoordinateTransformation.h"
#include "AADefines.h"
#ifndef AAPLUS_NO_VSOP87
#include "AAVSOP87D_MAR.h"
#endif //#ifndef AAPLUS_NO_VSOP87
#include <cmath>
#include <array>


//////////////////// Macros / Defines /////////////////////////////////////////

#ifdef _MSC_VER
#pragma warning(disable : 26446 26482 26485)
#endif //#ifdef _MSC_VER

struct VSOP87Coefficient
{
  double A;
  double B;
  double C;
};

constexpr std::array<VSOP87Coefficient, 69> g_L0MarsCoefficients
{ {
  { 620347712,  0,          0             },
  { 18656368,   5.05037100, 3340.61242670 },
  { 1108217,    5.4009984,  6681.2248534  },
  { 91798,      5.75479,    10021.83728   },
  { 27745,      5.97050,    3.52312       },
  { 12316,      0.84956,    2810.92146    },
  { 10610,      2.93959,    2281.23050    },
  { 8927,       4.1570,     0.0173        },
  { 8716,       6.1101,     13362.4497    },
  { 7775,       3.3397,     5621.8429     },
  { 6798,       0.3646,     398.1490      },
  { 4161,       0.2281,     2942.4634     },
  { 3575,       1.6619,     2544.3144     },
  { 3075,       0.8570,     191.4483      },
  { 2938,       6.0789,     0.0673        },
  { 2628,       0.6481,     3337.0893     },
  { 2580,       0.0300,     3344.1355     },
  { 2389,       5.0390,     796.2980      },
  { 1799,       0.6563,     529.6910      },
  { 1546,       2.9158,     1751.5395     },
  { 1528,       1.1498,     6151.5339     },
  { 1286,       3.0680,     2146.1654     },
  { 1264,       3.6228,     5092.1520     },
  { 1025,       3.6933,     8962.4553     },
  { 892,        0.183,      16703.062     },
  { 859,        2.401,      2914.014      },
  { 833,        4.495,      3340.630      },
  { 833,        2.464,      3340.595      },
  { 749,        3.822,      155.420       },
  { 724,        0.675,      3738.761      },
  { 713,        3.663,      1059.382      },
  { 655,        0.489,      3127.313      },
  { 636,        2.922,      8432.764      },
  { 553,        4.475,      1748.016      },
  { 550,        3.810,      0.980         },
  { 472,        3.625,      1194.447      },
  { 426,        0.554,      6283.076      },
  { 415,        0.497,      213.299       },
  { 312,        0.999,      6677.702      },
  { 307,        0.381,      6684.748      },
  { 302,        4.486,      3532.061      },
  { 299,        2.783,      6254.627      },
  { 293,        4.221,      20.775        },
  { 284,        5.769,      3149.164      },
  { 281,        5.882,      1349.867      },
  { 274,        0.542,      3340.545      },
  { 274,        0.134,      3340.680      },
  { 239,        5.372,      4136.910      },
  { 236,        5.755,      3333.499      },
  { 231,        1.282,      3870.303      },
  { 221,        3.505,      382.897       },
  { 204,        2.821,      1221.849      },
  { 193,        3.357,      3.590         },
  { 189,        1.491,      9492.146      },
  { 179,        1.006,      951.718       },
  { 174,        2.414,      553.569       },
  { 172,        0.439,      5486.778      },
  { 160,        3.949,      4562.461      },
  { 144,        1.419,      135.065       },
  { 140,        3.326,      2700.715      },
  { 138,        4.301,      7.114         },
  { 131,        4.045,      12303.068     },
  { 128,        2.208,      1592.596      },
  { 128,        1.807,      5088.629      },
  { 117,        3.128,      7903.073      },
  { 113,        3.701,      1589.073      },
  { 110,        1.052,      242.729       },
  { 105,        0.785,      8827.390      },
  { 100,        3.243,      11773.377     }
} };

constexpr std::array<VSOP87Coefficient, 46> g_L1MarsCoefficients
{ {
  { 334085627474.0, 0,          0            },
  { 1458227,        3.6042605,  3340.6124267 },
  { 164901,         3.926313,   6681.224853  },
  { 19963,          4.26594,    10021.83728  },
  { 3452,           4.7321,     3.5231       },
  { 2485,           4.6128,     13362.4497   },
  { 842,            4.459,      2281.230     },
  { 538,            5.016,      398.149      },
  { 521,            4.994,      3344.136     },
  { 433,            2.561,      191.448      },
  { 430,            5.316,      155.420      },
  { 382,            3.539,      796.298      },
  { 314,            4.963,      16703.062    },
  { 283,            3.160,      2544.314     },
  { 206,            4.569,      2146.165     },
  { 169,            1.329,      3337.089     },
  { 158,            4.185,      1751.540     },
  { 134,            2.233,      0.980        },
  { 134,            5.974,      1748.016     },
  { 118,            6.024,      6151.534     },
  { 117,            2.213,      1059.382     },
  { 114,            2.129,      1194.447     },
  { 114,            5.428,      3738.761     },
  { 91,             1.10,       1349.87      },
  { 85,             3.91,       553.57       },
  { 83,             5.30,       6684.75      },
  { 81,             4.43,       529.69       },
  { 80,             2.25,       8962.46      },
  { 73,             2.50,       951.72       },
  { 73,             5.84,       242.73       },
  { 71,             3.86,       2914.01      },
  { 68,             5.02,       382.90       },
  { 65,             1.02,       3340.60      },
  { 65,             3.05,       3340.63      },
  { 62,             4.15,       3149.16      },
  { 57,             3.89,       4136.91      },
  { 48,             4.87,       213.30       },
  { 48,             1.18,       3333.50      },
  { 47,             1.31,       3185.19      },
  { 41,             0.71,       1592.60      },
  { 40,             2.73,       7.11         },
  { 40,             5.32,       20043.67     },
  { 33,             5.41,       6283.08      },
  { 28,             0.05,       9492.15      },
  { 27,             3.89,       1221.85      },
  { 27,             5.11,       2700.72      }
} };

constexpr std::array<VSOP87Coefficient, 33> g_L2MarsCoefficients
{ {
  { 58016,  2.04979,  3340.61243 },
  { 54188,  0,        0          },
  { 13908,  2.45742,  6681.22485 },
  { 2465,   2.8000,   10021.8373 },
  { 398,    3.141,    13362.450  },
  { 222,    3.194,    3.523      },
  { 121,    0.543,    155.420    },
  { 62,     3.49,     16703.06   },
  { 54,     3.54,     3344.14    },
  { 34,     6.00,     2281.23    },
  { 32,     4.14,     191.45     },
  { 30,     2.00,     796.30     },
  { 23,     4.33,     242.73     },
  { 22,     3.45,     398.15     },
  { 20,     5.42,     553.57     },
  { 16,     0.66,     0.98       },
  { 16,     6.11,     2146.17    },
  { 16,     1.22,     1748.02    },
  { 15,     6.10,     3185.19    },
  { 14,     4.02,     951.72     },
  { 14,     2.62,     1349.87    },
  { 13,     0.60,     1194.45    },
  { 12,     3.86,     6684.75    },
  { 11,     4.72,     2544.31    },
  { 10,     0.25,     382.90     },
  { 9,      0.68,     1059.38    },
  { 9,      3.83,     20043.67   },
  { 9,      3.88,     3738.76    },
  { 8,      5.46,     1751.54    },
  { 7,      2.58,     3149.16    },
  { 7,      2.38,     4136.91    },
  { 6,      5.48,     1592.60    },
  { 6,      2.34,     3097.88    }
} };

constexpr std::array<VSOP87Coefficient, 12> g_L3MarsCoefficients
{ {
  { 1482, 0.4443, 3340.6124 },
  { 662,  0.885,  6681.225  },
  { 188,  1.288,  10021.837 },
  { 41,   1.65,   13362.45  },
  { 26,   0,      0         },
  { 23,   2.05,   155.42    },
  { 10,   1.58,   3.52      },
  { 8,    2.00,   16703.06  },
  { 5,    2.82,   242.73    },
  { 4,    2.02,   3344.14   },
  { 3,    4.59,   3185.19   },
  { 3,    0.65,   553.57    }
} };

constexpr std::array<VSOP87Coefficient, 8> g_L4MarsCoefficients
{ {
  { 114,  3.1416, 0        },
  { 29,   5.64,   6681.22  },
  { 24,   5.14,   3340.61  },
  { 11,   6.03,   10021.84 },
  { 3,    0.13,   13362.45 },
  { 3,    3.56,   155.42   },
  { 1,    0.49,   16703.06 },
  { 1,    1.32,   242.73   }
} };

constexpr std::array<VSOP87Coefficient, 2> g_L5MarsCoefficients
{ {
  { 1,  3.14, 0       },
  { 1,  4.04, 6681.22 }
} };

constexpr std::array<VSOP87Coefficient, 16> g_B0MarsCoefficients
{ {
  { 3197135,  3.7683204,  3340.6124267 },
  { 298033,   4.106170,   6681.224853  },
  { 289105,   0,          0            },
  { 31366,    4.44651,    10021.83728  },
  { 3484,     4.7881,     13362.4497   },
  { 443,      5.026,      3344.136     },
  { 443,      5.652,      3337.089     },
  { 399,      5.131,      16703.062    },
  { 293,      3.793,      2281.230     },
  { 182,      6.136,      6151.534     },
  { 163,      4.264,      529.691      },
  { 160,      2.232,      1059.382     },
  { 149,      2.165,      5621.843     },
  { 143,      1.182,      3340.595     },
  { 143,      3.213,      3340.630     },
  { 139,      2.418,      8962.455     }
} };

constexpr std::array<VSOP87Coefficient, 9> g_B1MarsCoefficients
{ {
  { 350069, 5.368478, 3340.612427 },
  { 14116,  3.14159,  0           },
  { 9671,   5.4788,   6681.2249   },
  { 1472,   3.2021,   10021.8373  },
  { 426,    3.408,    13362.450   },
  { 102,    0.776,    3337.089    },
  { 79,     3.72,     16703.06    },
  { 33,     3.46,     5621.84     },
  { 26,     2.48,     2281.23     }
} };

constexpr std::array<VSOP87Coefficient, 7> g_B2MarsCoefficients
{ {
  { 16727,  0.60221,  3340.61243 },
  { 4987,   3.1416,   0          },
  { 302,    5.559,    6681.225   },
  { 26,     1.90,     13362.45   },
  { 21,     0.92,     10021.84   },
  { 12,     2.24,     3337.09    },
  { 8,      2.25,     16703.06   }
} };

constexpr std::array<VSOP87Coefficient, 4> g_B3MarsCoefficients
{ {
  { 607,  1.981,  3340.612 },
  { 43,   0,      0        },
  { 14,   1.80,   6681.22  },
  { 3,    3.45,   10021.84 }
} };

constexpr std::array<VSOP87Coefficient, 3> g_B4MarsCoefficients
{ {
  { 13, 0,    0       },
  { 11, 3.46, 3340.61 },
  { 1,  0.50, 6681.22 }
} };

constexpr std::array<VSOP87Coefficient, 45> g_R0MarsCoefficients
{ {
  { 153033488,  0,          0             },
  { 14184953,   3.47971284, 3340.61242670 },
  { 660776,     3.817834,   6681.224853   },
  { 46179,      4.15595,    10021.83728   },
  { 8110,       5.5596,     2810.9215     },
  { 7485,       1.7724,     5621.8429     },
  { 5523,       1.3644,     2281.2305     },
  { 3825,       4.4941,     13362.4497    },
  { 2484,       4.9255,     2942.4634     },
  { 2307,       0.0908,     2544.3144     },
  { 1999,       5.3606,     3337.0893     },
  { 1960,       4.7425,     3344.1355     },
  { 1167,       2.1126,     5092.1520     },
  { 1103,       5.0091,     398.1490      },
  { 992,        5.839,      6151.534      },
  { 899,        4.408,      529.691       },
  { 807,        2.102,      1059.382      },
  { 798,        3.448,      796.298       },
  { 741,        1.499,      2146.165      },
  { 726,        1.245,      8432.764      },
  { 692,        2.134,      8962.455      },
  { 633,        0.894,      3340.595      },
  { 633,        2.924,      3340.630      },
  { 630,        1.287,      1751.540      },
  { 574,        0.829,      2914.014      },
  { 526,        5.383,      3738.761      },
  { 473,        5.199,      3127.313      },
  { 348,        4.832,      16703.062     },
  { 284,        2.907,      3532.061      },
  { 280,        5.257,      6283.076      },
  { 276,        1.218,      6254.627      },
  { 275,        2.908,      1748.016      },
  { 270,        3.764,      5884.927      },
  { 239,        2.037,      1194.447      },
  { 234,        5.105,      5486.778      },
  { 228,        3.255,      6872.673      },
  { 223,        4.199,      3149.164      },
  { 219,        5.583,      191.448       },
  { 208,        5.255,      3340.545      },
  { 208,        4.846,      3340.680      },
  { 186,        5.699,      6677.702      },
  { 183,        5.081,      6684.748      },
  { 179,        4.184,      3333.499      },
  { 176,        5.953,      3870.303      },
  { 164,        3.799,      4136.910      }
} };

constexpr std::array<VSOP87Coefficient, 27> g_R1MarsCoefficients
{ {
  { 1107433,  2.0325052,  3340.6124267 },
  { 103176,   2.370718,   6681.224853  },
  { 12877,    0,          0            },
  { 10816,    2.70888,    10021.83728  },
  { 1195,     3.0470,     13362.4497   },
  { 439,      2.888,      2281.230     },
  { 396,      3.423,      3344.136     },
  { 183,      1.584,      2544.314     },
  { 136,      3.385,      16703.062    },
  { 128,      6.043,      3337.089     },
  { 128,      0.630,      1059.382     },
  { 127,      1.954,      796.298      },
  { 118,      2.998,      2146.165     },
  { 88,       3.42,       398.15       },
  { 83,       3.86,       3738.76      },
  { 76,       4.45,       6151.53      },
  { 72,       2.76,       529.69       },
  { 67,       2.55,       1751.54      },
  { 66,       4.41,       1748.02      },
  { 58,       0.54,       1194.45      },
  { 54,       0.68,       8962.46      },
  { 51,       3.73,       6684.75      },
  { 49,       5.73,       3340.60      },
  { 49,       1.48,       3340.63      },
  { 48,       2.58,       3149.16      },
  { 48,       2.29,       2914.01      },
  { 39,       2.32,       4136.91      }
} };

constexpr std::array<VSOP87Coefficient, 11> g_R2MarsCoefficients
{ {
  { 44242,  0.47931,  3340.61243 },
  { 8138,   0.8700,   6681.2249  },
  { 1275,   1.2259,   10021.8373 },
  { 187,    1.573,    13362.450  },
  { 52,     3.14,     0          },
  { 41,     1.97,     3344.14    },
  { 27,     1.92,     16703.06   },
  { 18,     4.43,     2281.23    },
  { 12,     4.53,     3185.19    },
  { 10,     5.39,     1059.38    },
  { 10,     0.42,     796.30     }
} };

constexpr std::array<VSOP87Coefficient, 6> g_R3MarsCoefficients
{ {
  { 1113, 5.1499, 3340.6124 },
  { 424,  5.613,  6681.225  },
  { 100,  5.997,  10021.837 },
  { 20,   0.08,   13362.45  },
  { 5,    3.14,   0         },
  { 3,    0.43,   16703.06  }
} };

constexpr std::array<VSOP87Coefficient, 4> g_R4MarsCoefficients
{ {
  { 20, 3.58, 3340.61  },
  { 16, 4.05, 6681.22  },
  { 6,  4.46, 10021.84 },
  { 2,  4.84, 13362.45 }
} };


///////////////////////////// Implementation //////////////////////////////////

double CAAMars::EclipticLongitude(double JD, bool bHighPrecision) noexcept
{
#ifndef AAPLUS_NO_VSOP87
  if (bHighPrecision)
    return CAACoordinateTransformation::MapTo0To360Range(CAACoordinateTransformation::RadiansToDegrees(CAAVSOP87D_Mars::L(JD)));
#else
  UNREFERENCED_PARAMETER(bHighPrecision);
#endif //#ifndef AAPLUS_NO_VSOP87

  const double rho{(JD - 2451545)/365250};
  const double rhosquared{rho*rho};
  const double rhocubed{rhosquared*rho};
  const double rho4{rhocubed*rho};
  const double rho5{rho4*rho};

  //Calculate L0
  double L0{0};
  for (const auto& L0Coefficient : g_L0MarsCoefficients)
    L0 += (L0Coefficient.A*cos(L0Coefficient.B + (L0Coefficient.C*rho)));

  //Calculate L1
  double L1 = 0;
  for (const auto& L1Coefficient : g_L1MarsCoefficients)
    L1 += (L1Coefficient.A*cos(L1Coefficient.B + (L1Coefficient.C*rho)));

  //Calculate L2
  double L2 = 0;
  for (const auto& L2Coefficient : g_L2MarsCoefficients)
    L2 += (L2Coefficient.A*cos(L2Coefficient.B + (L2Coefficient.C*rho)));

  //Calculate L3
  double L3 = 0;
  for (const auto& L3Coefficient : g_L3MarsCoefficients)
    L3 += (L3Coefficient.A*cos(L3Coefficient.B + (L3Coefficient.C*rho)));

  //Calculate L4
  double L4 = 0;
  for (const auto& L4Coefficient : g_L4MarsCoefficients)
    L4 += (L4Coefficient.A*cos(L4Coefficient.B + (L4Coefficient.C*rho)));

  //Calculate L5
  double L5 = 0;
  for (const auto& L5Coefficient : g_L5MarsCoefficients)
    L5 += (L5Coefficient.A*cos(L5Coefficient.B + (L5Coefficient.C*rho)));

  double value{(L0 + (L1*rho) + (L2*rhosquared) + (L3*rhocubed) + (L4*rho4) + (L5*rho5))/100000000};

  //convert results back to degrees
  value = CAACoordinateTransformation::MapTo0To360Range(CAACoordinateTransformation::RadiansToDegrees(value));
  return value;
}

double CAAMars::EclipticLatitude(double JD, bool bHighPrecision) noexcept
{
#ifndef AAPLUS_NO_VSOP87
  if (bHighPrecision)
    return CAACoordinateTransformation::MapToMinus90To90Range(CAACoordinateTransformation::RadiansToDegrees(CAAVSOP87D_Mars::B(JD)));
#else
  UNREFERENCED_PARAMETER(bHighPrecision);
#endif //#ifndef AAPLUS_NO_VSOP87

  const double rho{(JD - 2451545)/365250};
  const double rhosquared{rho*rho};
  const double rhocubed{rhosquared*rho};
  const double rho4{rhocubed*rho};

  //Calculate B0
  double B0{0};
  for (const auto& B0Coefficient : g_B0MarsCoefficients)
    B0 += (B0Coefficient.A*cos(B0Coefficient.B + (B0Coefficient.C*rho)));

  //Calculate B1
  double B1{0};
  for (const auto& B1Coefficient : g_B1MarsCoefficients)
    B1 += (B1Coefficient.A*cos(B1Coefficient.B + (B1Coefficient.C*rho)));

  //Calculate B2
  double B2{0};
  for (const auto& B2Coefficient : g_B2MarsCoefficients)
    B2 += (B2Coefficient.A*cos(B2Coefficient.B + (B2Coefficient.C*rho)));

  //Calculate B3
  double B3{0};
  for (const auto& B3Coefficient : g_B3MarsCoefficients)
    B3 += (B3Coefficient.A*cos(B3Coefficient.B + (B3Coefficient.C*rho)));

  //Calculate B4
  double B4{0};
  for (const auto& B4Coefficient : g_B4MarsCoefficients)
    B4 += (B4Coefficient.A*cos(B4Coefficient.B + (B4Coefficient.C*rho)));

  double value{(B0 + (B1*rho) + (B2*rhosquared) + (B3*rhocubed) + (B4*rho4)) / 100000000};

  //convert results back to degrees
  value = CAACoordinateTransformation::MapToMinus90To90Range(CAACoordinateTransformation::RadiansToDegrees(value));
  return value;
}

double CAAMars::RadiusVector(double JD, bool bHighPrecision) noexcept
{
#ifndef AAPLUS_NO_VSOP87
  if (bHighPrecision)
    return CAAVSOP87D_Mars::R(JD);
#else
  UNREFERENCED_PARAMETER(bHighPrecision);
#endif //#ifndef AAPLUS_NO_VSOP87

  const double rho{(JD - 2451545)/365250};
  const double rhosquared{rho*rho};
  const double rhocubed{rhosquared*rho};
  const double rho4{rhocubed*rho};

  //Calculate R0
  double R0{0};
  for (const auto& R0Coefficients : g_R0MarsCoefficients)
    R0 += (R0Coefficients.A*std::cos(R0Coefficients.B + (R0Coefficients.C*rho)));

  //Calculate R1
  double R1{0};
  for (const auto& R1Coefficient : g_R1MarsCoefficients)
    R1 += (R1Coefficient.A*std::cos(R1Coefficient.B + (R1Coefficient.C*rho)));

  //Calculate R2
  double R2{0};
  for (const auto& R2Coefficient : g_R2MarsCoefficients)
    R2 += (R2Coefficient.A*std::cos(R2Coefficient.B + (R2Coefficient.C*rho)));

  //Calculate R3
  double R3{0};
  for (const auto& R3Coefficient : g_R3MarsCoefficients)
    R3 += (R3Coefficient.A*std::cos(R3Coefficient.B + (R3Coefficient.C*rho)));

  //Calculate R4
  double R4{0};
  for (const auto& R4Coefficient : g_R4MarsCoefficients)
    R4 += (R4Coefficient.A*std::cos(R4Coefficient.B + (R4Coefficient.C*rho)));

  return (R0 + (R1*rho) + (R2*rhosquared) + (R3*rhocubed) + (R4*rho4))/100000000;
}
