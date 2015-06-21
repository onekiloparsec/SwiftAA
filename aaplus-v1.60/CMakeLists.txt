PROJECT (AstronomicalAlgorithms)

cmake_minimum_required(VERSION 2.6)

#-----------------------------------------------------------------------------
# Output directories.
SET(EXECUTABLE_OUTPUT_PATH ${PROJECT_BINARY_DIR}/bin CACHE PATH
  "Single output directory for building all executables.")
SET(LIBRARY_OUTPUT_PATH ${PROJECT_BINARY_DIR}/lib CACHE PATH
  "Single output directory for building all libraries.")


#-----------------------------------------------------------------------------
SET ( SRCS_LIB
  AAAberration.cpp
  AAAngularSeparation.cpp
  AABinaryStar.cpp
  AACoordinateTransformation.cpp
  AADate.cpp
  AADiameters.cpp
  AADynamicalTime.cpp
  AAEarth.cpp
  AAEaster.cpp
  AAEclipses.cpp
  AAEclipticalElements.cpp
  AAElementsPlanetaryOrbit.cpp
  AAElliptical.cpp
  AAEquationOfTime.cpp
  AAEquinoxesAndSolstices.cpp
  AAFK5.cpp
  AAGalileanMoons.cpp
  AAGlobe.cpp
  AAIlluminatedFraction.cpp
  AAInterpolate.cpp
  AAJewishCalendar.cpp
  AAJupiter.cpp
  AAKepler.cpp
  AAMars.cpp
  AAMercury.cpp
  AAMoon.cpp
  AAMoonIlluminatedFraction.cpp
  AAMoonMaxDeclinations.cpp
  AAMoonNodes.cpp
  AAMoonPerigeeApogee.cpp
  AAMoonPhases.cpp
  AAMoslemCalendar.cpp
  AANearParabolic.cpp
  AANeptune.cpp
  AANodes.cpp
  AANutation.cpp
  AAParabolic.cpp
  AAParallactic.cpp
  AAParallax.cpp
  AAPhysicalJupiter.cpp
  AAPhysicalMars.cpp
  AAPhysicalMoon.cpp
  AAPhysicalSun.cpp
  AAPlanetPerihelionAphelion.cpp
  AAPlanetaryPhenomena.cpp
  AAPluto.cpp
  AAPrecession.cpp
  AARefraction.cpp
  AARiseTransitSet.cpp
  AASaturn.cpp
  AASaturnMoons.cpp
  AASaturnRings.cpp
  AASidereal.cpp
  AAStellarMagnitudes.cpp
  AASun.cpp
  AAUranus.cpp
  AAVenus.cpp
  stdafx.cpp
)

#-----------------------------------------------------------------------------
SET ( INCS
#  AA+.h
  AA2DCoordinate.h
  AA3DCoordinate.h
  AAAberration.h
  AAAngularSeparation.h
  AABinaryStar.h
  AACoordinateTransformation.h
  AADate.h
  AADiameters.h
  AADynamicalTime.h
  AAEarth.h
  AAEaster.h
  AAEclipses.h
  AAEclipticalElements.h
  AAElementsPlanetaryOrbit.h
  AAElliptical.h
  AAEquationOfTime.h
  AAEquinoxesAndSolstices.h
  AAFK5.h
  AAGalileanMoons.h
  AAGlobe.h
  AAIlluminatedFraction.h
  AAInterpolate.h
  AAJewishCalendar.h
  AAJupiter.h
  AAKepler.h
  AAMars.h
  AAMercury.h
  AAMoon.h
  AAMoonIlluminatedFraction.h
  AAMoonMaxDeclinations.h
  AAMoonNodes.h
  AAMoonPerigeeApogee.h
  AAMoonPhases.h
  AAMoslemCalendar.h
  AANeptune.h
  AANodes.h
  AANutation.h
  AAParabolic.h
  AAParallactic.h
  AAParallax.h
  AAPhysicalJupiter.h
  AAPhysicalMars.h
  AAPhysicalMoon.h
  AAPhysicalSun.h
  AAPlanetPerihelionAphelion.h
  AAPlanetaryPhenomena.h
  AAPluto.h
  AAPrecession.h
  AARefraction.h
  AARiseTransitSet.h
  AASaturn.h
  AASaturnMoons.h
  AASaturnRings.h
  AASidereal.h
  AAStellarMagnitudes.h
  AASun.h
  AAUranus.h
  AAVenus.h
  stdafx.h
)

SET ( SRCS
  AATest.cpp
)

#-----------------------------------------------------------------------------
# Executables.
#-----------------------------------------------------------------------------
ADD_EXECUTABLE(AATest ${SRCS} )

#-----------------------------------------------------------------------------
# Libraries.
ADD_LIBRARY(aaplus-static STATIC ${SRCS_LIB} ${INCS})
SET_TARGET_PROPERTIES(aaplus-static PROPERTIES OUTPUT_NAME "aaplus")

ADD_LIBRARY(aaplus-shared SHARED ${SRCS_LIB} ${INCS})
SET_TARGET_PROPERTIES(aaplus-shared PROPERTIES OUTPUT_NAME "aaplus")

install(TARGETS aaplus-shared aaplus-static 
		DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" )

TARGET_LINK_LIBRARIES(AATest aaplus-static)

