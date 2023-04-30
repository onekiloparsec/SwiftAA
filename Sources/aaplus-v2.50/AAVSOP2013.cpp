/*
Module : AAVSOP2013.cpp
Purpose: Implementation for the algorithms for VSOP2013
Created: PJN / 01-08-2021
History: PJN / 12-06-2022 1. Updated all the code in AAVSOP2013.cpp to use C++ uniform initialization for all
                          variable declarations.

Copyright (c) 2021 - 2023 by PJ Naughter (Web: www.naughter.com, Email: pjna@naughter.com)

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
#include "AAVSOP2013.h"
#include "AACoordinateTransformation.h"
#ifdef _WIN32
#include <winsock.h>
#else
#include <arpa/inet.h>
#endif //#ifdef _WIN32
#include <cmath>
#include <string>
#include <fstream>
#include <memory>
#include <cinttypes>
#include <algorithm>
#include <cassert>


//////////////////// Implementation ///////////////////////////////////////////

bool CAAVSOP2013EphemeridesFile::ReadTextFile(const std::filesystem::path::value_type* pszFilename)
{
  std::ifstream file(pszFilename);
  if (!file)
    return false;

  //Read in the header
  std::string sLine;
  if (!std::getline(file, sLine))
    return false;
  const int nIdentificationIndex{std::atoi(sLine.c_str())};
  if (nIdentificationIndex != IDENTIFICATION_INDEX)
    return false;
  if (!std::getline(file, sLine))
    return false;
  m_fStartJD = std::stod(sLine);
  if (!std::getline(file, sLine))
    return false;
  m_fEndJD = std::stod(sLine);
  if (!std::getline(file, sLine))
    return false;
  const double fSizeBasicInterval{std::stod(sLine)};
  if (fSizeBasicInterval != SIZE_BASIC_INTERVAL)
    return false;
  if (!std::getline(file, sLine))
    return false;
  const int nChebyshevTables{std::atoi(sLine.c_str())};
  if (nChebyshevTables != CHEBYSHEV_TABLES)
    return false;
  if (!std::getline(file, sLine))
    return false;
  const int nCoefficientsPerTable{std::atoi(sLine.c_str())};
  if (nCoefficientsPerTable != COEFFICIENTS_PER_TABLE)
    return false;
  if (!std::getline(file, sLine))
    return false;
#ifdef _MSC_VER
#pragma warning(disable : 26446)
  if (sscanf_s(sLine.c_str(), "%" SCNd32 " %" SCNd32 " %" SCNd32 " %" SCNd32 " %" SCNd32 " %" SCNd32 " %" SCNd32 " %" SCNd32 " %" SCNd32,
#else
  if (sscanf(sLine.c_str(), "%" SCNd32 " %" SCNd32 " %" SCNd32 " %" SCNd32 " %" SCNd32 " %" SCNd32 " %" SCNd32 " %" SCNd32 " %" SCNd32,
#endif //#ifdef _MSC_VER
               &m_FirstCoefficientRank[0], & m_FirstCoefficientRank[1], & m_FirstCoefficientRank[2],
               &m_FirstCoefficientRank[3], &m_FirstCoefficientRank[4], &m_FirstCoefficientRank[5], &m_FirstCoefficientRank[6], &m_FirstCoefficientRank[7], &m_FirstCoefficientRank[8]) != 9)
    return false;
  if (!std::getline(file, sLine))
    return false;
#ifdef _MSC_VER
  if (sscanf_s(sLine.c_str(), "%" SCNd32 " %" SCNd32 " %" SCNd32 " %" SCNd32 " %" SCNd32 " %" SCNd32 " %" SCNd32 " %" SCNd32 " %" SCNd32,
#else
  if (sscanf(sLine.c_str(), "%" SCNd32 " %" SCNd32 " %" SCNd32 " %" SCNd32 " %" SCNd32 " %" SCNd32 " %" SCNd32 " %" SCNd32 " %" SCNd32,
#endif //#ifdef _MSC_VER
               &m_CoefficientsPerCoordinate[0], &m_CoefficientsPerCoordinate[1], &m_CoefficientsPerCoordinate[2],
               &m_CoefficientsPerCoordinate[3], &m_CoefficientsPerCoordinate[4], &m_CoefficientsPerCoordinate[5], &m_CoefficientsPerCoordinate[6], &m_CoefficientsPerCoordinate[7], &m_CoefficientsPerCoordinate[8]) != 9)
    return false;
  if (!std::getline(file, sLine))
    return false;
#ifdef _MSC_VER
  if (sscanf_s(sLine.c_str(), "%" SCNd32 " %" SCNd32 " %" SCNd32 " %" SCNd32 " %" SCNd32 " %" SCNd32 " %" SCNd32 " %" SCNd32 " %" SCNd32,
#else
  if (sscanf(sLine.c_str(), "%" SCNd32 " %" SCNd32 " %" SCNd32 " %" SCNd32 " %" SCNd32 " %" SCNd32 " %" SCNd32 " %" SCNd32 " %" SCNd32,
#endif //#ifdef _MSC_VER
               &m_SubIntervals[0], &m_SubIntervals[1], &m_SubIntervals[2],
               &m_SubIntervals[3], &m_SubIntervals[4], &m_SubIntervals[5], &m_SubIntervals[6], &m_SubIntervals[7], &m_SubIntervals[8]) != 9)
    return false;

  //Now read in all the tables
  m_ChebyshevTables.clear();
  m_ChebyshevTables.reserve(CHEBYSHEV_TABLES);
  for (int i{0}; i<nChebyshevTables; i++)
  {
    if (!std::getline(file, sLine))
      return false;
    std::array<double, COEFFICIENTS_PER_TABLE + 2> table;
#ifdef _MSC_VER
    if (sscanf_s(sLine.c_str(), "%lf %lf",
#else
    if (sscanf(sLine.c_str(), "%lf %lf",
#endif //#ifdef _MSC_VER
        &table[0], &table[1]) != 2)
      return false;
#ifdef _MSC_VER
#pragma warning(default : 26446)
#endif //#ifdef _MSC_VER

    //Read in all 978 coefficients in the table as 6 coefficients per line for a total of 163 lines
    int nArrayIndex{2};
    for (int j{0}; j<163; j++)
    {
      if (!std::getline(file, sLine))
        return false;
      if (sLine.length() <= 143)
        return false;
#ifdef _MSC_VER
#pragma warning(disable : 26446)
#endif //#ifdef _MSC_VER
      if (sLine[142] != ' ')
        return false;
      sLine[142] = 'E';
      if (sLine[118] != ' ')
        return false;
      sLine[118] = 'E';
      if (sLine[94] != ' ')
        return false;
      sLine[94] = 'E';
      if (sLine[70] != ' ')
        return false;
      sLine[70] = 'E';
      if (sLine[46] != ' ')
        return false;
      sLine[46] = 'E';
      if (sLine[22] != ' ')
        return false;
      sLine[22] = 'E';
      std::array<double, 6> fCoefficients{};
#ifdef _MSC_VER
      if (sscanf_s(sLine.c_str(), "%lf %lf %lf %lf %lf %lf",
#else
      if (sscanf(sLine.c_str(), "%lf %lf %lf %lf %lf %lf",
#endif //#ifdef _MSC_VER
          &fCoefficients[0], &fCoefficients[1], &fCoefficients[2], &fCoefficients[3], &fCoefficients[4], &fCoefficients[5]) != 6)
        return false;
#ifdef _MSC_VER
#pragma warning(disable : 26482)
#endif //#ifdef _MSC_VER
      for (const auto& fCoefficient : fCoefficients)
        table[nArrayIndex++] = fCoefficient;
#ifdef _MSC_VER
#pragma warning(default : 26446 26482)
#endif //#ifdef _MSC_VER
    }
    m_ChebyshevTables.push_back(table);
  }

#ifdef _DEBUG
  //We should be at the end of the file by the time we reach this point
  assert(!std::getline(file, sLine));
#endif //#ifdef _DEBUG

  return true;
}


//Functor used to encapsulate a FILE* in a unique_ptr
struct AAPLUS_EXT_CLASS CVSOP2013FILEDeleter
{
  void operator()(FILE* pFile) noexcept
  {
    if (pFile)
      fclose(pFile);
  }
};


//A function which writes out an int32_t to a FILE* in big endian format
size_t fwrite_int32_t(int32_t nValue, FILE* f) noexcept
{
  const uint32_t nTemp{htonl(nValue)};
  return fwrite(&nTemp, sizeof(nTemp), 1, f);
}


//A function to convert a big endian uint32_t to a host endian int32_t
inline int32_t convert_read_int32_t(const uint32_t& nValue) noexcept
{
  const uint32_t nTemp{ntohl(nValue)};
  if (nTemp > INT32_MAX)
#ifdef _MSC_VER
#pragma warning(suppress : 26472)
#endif //#ifdef _MSC_VER
    return -static_cast<int32_t>(~nTemp) - 1;
  else
    return nTemp;
}


//A function which reads in an int32_t from a FILE* in big endian format
size_t fread_int32_t(int32_t& nValue, FILE* f) noexcept
{
  uint32_t nTemp{0};
  const auto nRead{fread(&nTemp, sizeof(nTemp), 1, f)};
  if (nRead != 1)
    return nRead;
  nValue = convert_read_int32_t(nTemp);
  return nRead;
}


//The binary files written out by this method are not the same as the binary files
//referenced in the original VSOP2013 documentation. Use only binary files generated
//by this method in calls to ReadBinaryFile.
bool CAAVSOP2013EphemeridesFile::WriteBinaryFile(const std::filesystem::path::value_type* pszFilename) noexcept
{
  FILE* f{nullptr};
#ifdef _MSC_VER
  if (_wfopen_s(&f, pszFilename, L"wb") != 0)
#else
  f = fopen(pszFilename, "wb");
  if (f == nullptr)
#endif //#ifdef _MSC_VER
    return false;
  std::unique_ptr<FILE, CVSOP2013FILEDeleter> file{f};
  constexpr uint8_t nVersionInfo{1};
#ifdef _MSC_VER
#pragma warning(suppress : 6387)
#endif //#ifdef _MSC_VER
  if (fwrite(&nVersionInfo, sizeof(nVersionInfo), 1, f) != 1)
    return false;
  if (fwrite(&m_fStartJD, sizeof(m_fStartJD), 1, f) != 1)
    return false;
  if (fwrite(&m_fEndJD, sizeof(m_fEndJD), 1, f) != 1)
    return false;
  for (const auto& coefficient : m_FirstCoefficientRank)
  {
    if (fwrite_int32_t(coefficient, f) != 1)
      return false;
  }
  for (const auto& coeff : m_CoefficientsPerCoordinate)
  {
    if (fwrite_int32_t(coeff, f) != 1)
      return false;
  }
  for (const auto& subInterval : m_SubIntervals)
  {
    if (fwrite_int32_t(subInterval, f) != 1)
      return false;
  }
  return (fwrite(m_ChebyshevTables.data(), sizeof(std::array<double, COEFFICIENTS_PER_TABLE + 2>), m_ChebyshevTables.size(), f) == m_ChebyshevTables.size());
}

//The binary files read in by this method are not the same as the binary files
//referenced in the original VSOP2013 documentation. Use only binary files generated
//by the WriteBinaryFile method.
bool CAAVSOP2013EphemeridesFile::ReadBinaryFile(const std::filesystem::path::value_type* pszFilename)
{
  FILE* f{nullptr};
#ifdef _MSC_VER
  if (_wfopen_s(&f, pszFilename, L"rb") != 0)
#else
  f = fopen(pszFilename, "rb");
  if (f == nullptr)
#endif //#ifdef _MSC_VER
    return false;
  std::unique_ptr<FILE, CVSOP2013FILEDeleter> file{f};
  uint8_t nVersionInfo{0};
#ifdef _MSC_VER
#pragma warning(suppress : 6387)
#endif //#ifdef _MSC_VER
  if (fread(&nVersionInfo, sizeof(nVersionInfo), 1, f) != 1)
    return false;
  if (nVersionInfo != 1)
    return false;
  std::array<double, 2> fDoubles{};
  if (fread(fDoubles.data(), sizeof(double), 2, f) != 2)
    return false;
#ifdef _MSC_VER
#pragma warning(suppress : 26446)
#endif //#ifdef _MSC_VER
  m_fStartJD = fDoubles[0];
#ifdef _MSC_VER
#pragma warning(suppress : 26446)
#endif //#ifdef _MSC_VER
  m_fEndJD = fDoubles[1];
  std::array<uint32_t, 9> coeffs{};
  if (fread(coeffs.data(), sizeof(int32_t), 9, f) != 9)
    return false;
  for (int i{0}; i<9; i++)
#ifdef _MSC_VER
#pragma warning(suppress : 26446 26482)
#endif //#ifdef _MSC_VER
    m_FirstCoefficientRank[i] = convert_read_int32_t(coeffs[i]);
  if (fread(coeffs.data(), sizeof(int32_t), 9, f) != 9)
    return false;
  for (int i{0}; i<9; i++)
#ifdef _MSC_VER
#pragma warning(suppress : 26446 26482)
#endif //#ifdef _MSC_VER
    m_CoefficientsPerCoordinate[i] = convert_read_int32_t(coeffs[i]);
  if (fread(coeffs.data(), sizeof(int32_t), 9, f) != 9)
    return false;
  for (int i{0}; i<9; i++)
#ifdef _MSC_VER
#pragma warning(suppress : 26446 26482)
#endif //#ifdef _MSC_VER
    m_SubIntervals[i] = convert_read_int32_t(coeffs[i]);
  m_ChebyshevTables.resize(CHEBYSHEV_TABLES);
  return (fread(m_ChebyshevTables.data(), sizeof(std::array<double, COEFFICIENTS_PER_TABLE + 2>), m_ChebyshevTables.size(), f) == m_ChebyshevTables.size());
}


bool CAAVSOP2013ElementsFile::ReadTextFile(const std::filesystem::path::value_type* pszFilename)
{
  std::ifstream file{pszFilename};
  if (!file)
    return false;

  //Read in all the series (a, lambda, k, h, q & p)
  std::string sLine;
  if (!std::getline(file, sLine))
    return false;
  m_AllSeries.clear();
  m_AllSeries.reserve(80); //80 is the maximum size for the series array for the VSOP2013 elements files (for Jupiter and Saturn)
  bool bMoreSeries{true};
  while (bMoreSeries)
  {
    //Read in the header
    if (sLine.find(" VSOP2013") != 0)
      return false;
    sLine = sLine.substr(9);
    CAAVSOP2013ElementsSeries series;
#ifdef _MSC_VER
#pragma warning(disable : 26446)
#endif //#ifdef _MSC_VER
    int nt{0};
#ifdef _MSC_VER
    if (sscanf_s(sLine.c_str(), "%" SCNu8 "%" SCNu8 "%" SCNu8 "%d",
#else
    if (sscanf(sLine.c_str(), "%" SCNu8 "%" SCNu8 "%" SCNu8 "%d",
#endif //#ifdef _MSC_VER
                 &series.m_ip, &series.m_iv, &series.m_it, &nt) != 4)
      return false;
    if ((series.m_ip < 1) || (series.m_ip > 9))
      return false;
    if ((series.m_iv < 1) || (series.m_iv > 6))
      return false;

    //Read in all the terms
    series.m_Terms.reserve(nt);
    for (int i{0}; i<nt; i++)
    {
      if (!std::getline(file, sLine))
        return false;
      if (sLine[88] != ' ')
        return false;
      sLine[88] = 'E';
      if (sLine[112] != ' ')
        return false;
      sLine[112] = 'E';
      int nRank{0};
      CAAVSOP2013ElementsTerm term;
#ifdef _MSC_VER
      if (sscanf_s(sLine.c_str(), "%" SCNd32 " %" SCNd32 " %" SCNd32 " %" SCNd32 " %" SCNd32 " %" SCNd32 " %" SCNd32 " %" SCNd32 " %" SCNd32 " %" SCNd32 " %" SCNd32 " %" SCNd32 " %" SCNd32 " %" SCNd32 " %" SCNd32 " %" SCNd32 " %" SCNd32 " %" SCNd32 " %lf %lf",
#else
      if (sscanf(sLine.c_str(), "%" SCNd32 " %" SCNd32 " %" SCNd32 " %" SCNd32 " %" SCNd32 " %" SCNd32 " %" SCNd32 " %" SCNd32 " %" SCNd32 " %" SCNd32 " %" SCNd32 " %" SCNd32 " %" SCNd32 " %" SCNd32 " %" SCNd32 " %" SCNd32 " %" SCNd32 " %" SCNd32 " %lf %lf",
#endif //#ifdef _MSC_VER
                   &nRank, &term.m_iphi[0], &term.m_iphi[1], &term.m_iphi[2], &term.m_iphi[3], &term.m_iphi[4], &term.m_iphi[5], &term.m_iphi[6], &term.m_iphi[7], &term.m_iphi[8], &term.m_iphi[9], &term.m_iphi[10], &term.m_iphi[11],
                   &term.m_iphi[12], &term.m_iphi[13], &term.m_iphi[14], &term.m_iphi[15], &term.m_iphi[16], &term.m_fS, &term.m_fC) != 20)
        return false;
      if (nRank != (i + 1))
        return false;
      series.m_Terms.push_back(term);
    }

    m_AllSeries.push_back(series);

    //Prepare for the next time around
    if (!std::getline(file, sLine))
      bMoreSeries = false;
  }

  return true;
}

//Use only binary files generated by this method in calls to ReadBinaryFile.
bool CAAVSOP2013ElementsFile::WriteBinaryFile(const std::filesystem::path::value_type* pszFilename) noexcept
{
  FILE* f{nullptr};
#ifdef _MSC_VER
  if (_wfopen_s(&f, pszFilename, L"wb") != 0)
#else
  f = fopen(pszFilename, "wb");
  if (f == nullptr)
#endif //#ifdef _MSC_VER
    return false;
  std::unique_ptr<FILE, CVSOP2013FILEDeleter> file{f};
  constexpr uint8_t nVersionInfo{1};
#ifdef _MSC_VER
#pragma warning(suppress : 6387)
#endif //#ifdef _MSC_VER
  if (fwrite(&nVersionInfo, sizeof(nVersionInfo), 1, f) != 1)
    return false;
#ifdef _MSC_VER
#pragma warning(suppress : 26472)
#endif //#ifdef _MSC_VER
  const auto nSeries{static_cast<int32_t>(m_AllSeries.size())};
  if (fwrite_int32_t(nSeries, f) != 1)
    return false;
  for (const auto& series : m_AllSeries)
  {
    if (fwrite(&series.m_ip, sizeof(series.m_ip), 1, f) != 1)
      return false;
    if (fwrite(&series.m_iv, sizeof(series.m_iv), 1, f) != 1)
      return false;
    if (fwrite(&series.m_it, sizeof(series.m_it), 1, f) != 1)
      return false;
#ifdef _MSC_VER
#pragma warning(suppress : 26472)
#endif //#ifdef _MSC_VER
    const auto nTerms{static_cast<int32_t>(series.m_Terms.size())};
    if (fwrite_int32_t(nTerms, f) != 1)
      return false;
    for (const auto& term : series.m_Terms)
    {
      for (const auto phi : term.m_iphi)
      {
        if (fwrite_int32_t(phi, f) != 1)
          return false;
      }
      if (fwrite(&term.m_fS, sizeof(term.m_fS), 1, f) != 1)
        return false;
      if (fwrite(&term.m_fC, sizeof(term.m_fC), 1, f) != 1)
        return false;
    }
  }
  return true;
}

//Use only binary files generated by the WriteBinaryFile method.
bool CAAVSOP2013ElementsFile::ReadBinaryFile(const std::filesystem::path::value_type* pszFilename)
{
  FILE* f{nullptr};
#ifdef _MSC_VER
  if (_wfopen_s(&f, pszFilename, L"rb") != 0)
#else
  f = fopen(pszFilename, "rb");
  if (f == nullptr)
#endif //#ifdef _MSC_VER
    return false;
  std::unique_ptr<FILE, CVSOP2013FILEDeleter> file{f};
  uint8_t nVersionInfo{0};
#ifdef _MSC_VER
#pragma warning(suppress : 6387)
#endif //#ifdef _MSC_VER
  if (fread(&nVersionInfo, sizeof(nVersionInfo), 1, f) != 1)
    return false;
  if (nVersionInfo != 1)
    return false;
  int32_t nSeries{0};
  if (fread_int32_t(nSeries, f) != 1)
    return false;
  m_AllSeries.clear();
  m_AllSeries.resize(nSeries);
  for (int32_t i{0}; i<nSeries; i++)
  {
    CAAVSOP2013ElementsSeries& series{m_AllSeries[i]};
    std::array<uint8_t, 3> tVals{};
    if (fread(&tVals, sizeof(uint8_t), 3, f) != 3)
      return false;
    series.m_ip = tVals[0];
    series.m_iv = tVals[1];
    series.m_it = tVals[2];
    int32_t nTerms{0};
    if (fread_int32_t(nTerms, f) != 1)
      return false;
    series.m_Terms.resize(nTerms);
    for (int32_t j{0}; j<nTerms; j++)
    {
      CAAVSOP2013ElementsTerm& term{series.m_Terms[j]};
      std::array<uint32_t, 17> tiphis{};
      if (fread(&tiphis, sizeof(uint32_t), 17, f) != 17)
        return false;
      for (int k{0}; k<17; k++)
#ifdef _MSC_VER
#pragma warning(suppress : 26482)
#endif //#ifdef _MSC_VER
        term.m_iphi[k] = convert_read_int32_t(tiphis[k]);
      std::array<double, 2> tSC{};
      if (fread(tSC.data(), sizeof(double), 2, f) != 2)
        return false;
      term.m_fS = tSC[0];
      term.m_fC = tSC[1];
    }
  }
  return true;
}


void CAAVSOP2013::SetBinaryFilesDirectory(const std::filesystem::path::value_type* pszBinaryFilesDirectory) noexcept
{
  m_pszBinaryFilesDirectory = pszBinaryFilesDirectory;
}

const std::filesystem::path::value_type* CAAVSOP2013::GetBinaryFilesDirectory() const noexcept
{
  return m_pszBinaryFilesDirectory;
}

CAAVSOP2013Position CAAVSOP2013::Calculate(Planet planet, double JD)
{
  //Validate the planet parameter
  if ((planet < Planet::MERCURY) || (planet > Planet::PLUTO))
    throw CAAVSOP2013Exception{CAAVSOP2013Exception::REASON::PLANET_IS_INVALID};

  //Check the extreme date range
  if ((JD < 77294.5) || (JD > 3364718.5))
    throw CAAVSOP2013Exception{CAAVSOP2013Exception::REASON::DATE_IS_INVALID};

  //Handle the special case for Pluto outside of the time interval for the VSOP2013.p2000 file
  if ((planet == Planet::PLUTO) && ((JD < 2268910.5) || (JD > 2816814.5)))
    throw CAAVSOP2013Exception{CAAVSOP2013Exception::REASON::DATE_IS_INVALID};

  //Find the index in the m_Files table from the JD parameter
  const auto iter{std::upper_bound(m_DateRange.cbegin(), m_DateRange.cend(), JD)};
  assert(iter != m_DateRange.cend());
  const size_t nIndex{iter - m_DateRange.cbegin() - size_t{1}};

  //Load up the data into the appropriate file class instance from the appropriate binary file if necessary
#ifdef _MSC_VER
#pragma warning(suppress : 26446 26482)
#endif //#ifdef _MSC_VER
  auto& file{m_EphemerideFiles[nIndex]};
  if (file.m_ChebyshevTables.size() == 0)
  {
    std::filesystem::path p{m_pszBinaryFilesDirectory};
#ifdef _MSC_VER
#pragma warning(suppress : 26446 26482)
#endif //#ifdef _MSC_VER
    p.append(m_EphemeridesFilenames[nIndex]);
    if (!file.ReadBinaryFile(p.c_str()))
      throw CAAVSOP2013Exception{CAAVSOP2013Exception::REASON::COULD_NOT_LOAD_BINARY_FILE};
  }

  const int iper{static_cast<int>((JD - file.m_fStartJD)/CAAVSOP2013EphemeridesFile::SIZE_BASIC_INTERVAL)}; //Calculate 32 day index
  assert((iper >= 0) && (iper < static_cast<int>(file.m_ChebyshevTables.size())));
#ifdef _MSC_VER
#pragma warning(disable : 26446 26482)
#endif //#ifdef _MSC_VER
  const auto& aperiod{file.m_ChebyshevTables[iper]}; //Get table containing JD
  const auto iad{file.m_FirstCoefficientRank[static_cast<int>(planet)] - 1}; //Initial term of the planet (index into m_Coefficients)
  const auto ncf{file.m_CoefficientsPerCoordinate[static_cast<int>(planet)]}; //Number of Chebyshev coefficients
  const auto nsi{file.m_SubIntervals[static_cast<int>(planet)]}; //Some delta divider
  const auto delta2{static_cast<double>(CAAVSOP2013EphemeridesFile::SIZE_BASIC_INTERVAL/nsi)};
  auto ik{static_cast<int32_t>((JD - aperiod[0])/delta2)};
  if (ik == nsi)
    --ik;
#ifdef _MSC_VER
#pragma warning(suppress : 26472)
#endif //#ifdef _MSC_VER
  const size_t iloc{iad + (6*static_cast<size_t>(ncf)*ik)};
  const double dj0{aperiod[0] + (ik*delta2)};
  const double x{(2.0*(JD - dj0)/delta2) - 1.0};

  //Build Chebyshev terms
  std::array<double, 20> tn{};
  tn[0] = 1.0;
  tn[1] = x;
#ifdef _MSC_VER
#pragma warning(suppress : 26472)
#endif //#ifdef _MSC_VER
  for (size_t i{2}; i<static_cast<size_t>(ncf); i++)
    tn[i] = (2.0*x*tn[i - 1]) - tn[i - 2];

  //Calculate planet position and speed
  std::array<double, 6> r{};
  for (int i{0}; i<6; i++)
  {
#ifdef _MSC_VER
#pragma warning(suppress : 26472)
#endif //#ifdef _MSC_VER
    for (size_t j{0}; j<static_cast<size_t>(ncf); j++)
    {
      const size_t jp{ncf - j - 1}; //index into tn, working backwards
      assert((jp >= 0) && (jp < tn.size()));
#ifdef _MSC_VER
#pragma warning(suppress : 26472)
#endif //#ifdef _MSC_VER
      const size_t jt{iloc + (static_cast<size_t>(ncf)*i) + jp + 2}; //Index into coefficients
      assert((jt >= 2) && (jt < aperiod.size()));
      r[i] += (tn[jp]*aperiod[jt]);
    }
  }
  CAAVSOP2013Position position;
  position.X = r[0];
  position.Y = r[1];
  position.Z = r[2];
  position.X_DASH = r[3];
  position.Y_DASH = r[4];
  position.Z_DASH = r[5];
#ifdef _MSC_VER
#pragma warning(default : 26446 26482)
#endif //#ifdef _MSC_VER
  return position;
}

CAAVSOP2013Orbit CAAVSOP2013::CalculateOrbit(Planet planet, double JD)
{
  //Validate the planet parameter
  if ((planet < Planet::MERCURY) || (planet > Planet::PLUTO))
    throw CAAVSOP2013Exception{CAAVSOP2013Exception::REASON::PLANET_IS_INVALID};

  //Calculate the T values
  std::array<double, 21> T{};
#ifdef _MSC_VER
#pragma warning(disable : 26446 26482)
#endif //#ifdef _MSC_VER
  T[0] = 1;
  T[1] = (JD - 2451545)/365250;
  for (size_t i{2}; i<21; i++)
    T[i] = T[1]*T[i - 1];

  //Calculate the lambda values
  std::array<double, 17> lambdas{};
  CalculateLambdas(T[1], lambdas);

  //Load up the data into the appropriate file class instance from the appropriate binary file if necessary
  auto& file{m_ElementsFiles[static_cast<int>(planet)]};
  if (file.m_AllSeries.size() == 0)
  {
    std::filesystem::path p{m_pszBinaryFilesDirectory};
    p.append(m_ElementsFilenames[static_cast<int>(planet)]);
    if (!file.ReadBinaryFile(p.c_str()))
      throw CAAVSOP2013Exception{CAAVSOP2013Exception::REASON::COULD_NOT_LOAD_BINARY_FILE};
  }

  //Calculate the element values
  std::array<double, 6> r{};
  for (const auto& serie : file.m_AllSeries)
  {
    double fSum{0};
    for (const auto& term : serie.m_Terms)
    {
      double fPhi{0};
      for (int i{0}; i<17; i++)
      {
        if (term.m_iphi[i])
          fPhi += (term.m_iphi[i]*lambdas[i]);
      }
      fSum += ((term.m_fS*sin(fPhi)) + (term.m_fC*cos(fPhi)));
    }
    assert(serie.m_it < 21);
    fSum *= T[serie.m_it];
    r[serie.m_iv - 1] += fSum;
  }

  CAAVSOP2013Orbit orbit;
  orbit.a = r[0];
  orbit.lambda = CAACoordinateTransformation::MapTo0To2PIRange(r[1]); //Normalize the lambda value to 0 to 2 radians
  orbit.k = r[2];
  orbit.h = r[3];
  orbit.q = r[4];
  orbit.p = r[5];
#ifdef _MSC_VER
#pragma warning(default: 26446 26482)
#endif //#ifdef _MSC_VER
  return orbit;
}

void CAAVSOP2013::CalculateLambdas(double T, std::array<double, 17>& lambdas) noexcept
{
#ifdef _MSC_VER
#pragma warning(disable : 26446)
#endif //#ifdef _MSC_VER
  lambdas[0] = 4.402608631669 + (26087.90314068555*T); //Mercury
  lambdas[1] = 3.176134461576 + (10213.28554743445*T); //Venus
  lambdas[2] = 1.753470369433 + (6283.075850353215*T); //Earth - Moon
  lambdas[3] = 6.203500014141 + (3340.612434145457*T); //Mars
  lambdas[4] = 4.091360003050 + (1731.170452721855*T); //Vesta
  lambdas[5] = 1.713740719173 + (1704.450855027201*T); //Iris
  lambdas[6] = 5.598641292287 + (1428.948917844273*T); //Bamberga
  lambdas[7] = 2.805136360408 + (1364.756513629990*T); //Ceres
  lambdas[8] = 2.326989734620 + (1361.923207632842*T); //Pallas
  lambdas[9] = 0.599546107035 + (529.6909615623250*T); //Jupiter
  lambdas[10] = 0.874018510107 + (213.2990861084880*T); //Saturn
  lambdas[11] = 5.481225395663 + (74.78165903077800*T); //Uranus
  lambdas[12] = 5.311897933164 + (38.13297222612500*T); //Neptune
  lambdas[13] = 0.3595362285049309*T; //µ Pluto
  lambdas[14] = 5.198466400630 + (77713.7714481804*T); //D Moon
  lambdas[15] = 1.627905136020 + (84334.6615717837*T); //F Moon
  lambdas[16] = 2.355555638750 + (83286.9142477147*T); //l Moon
#ifdef _MSC_VER
#pragma warning(default : 26446)
#endif //#ifdef _MSC_VER
}

double CAAVSOP2013::CalculateMeanMotion(Planet planet, double a)
{
  //Validate the planet parameter
  if ((planet < Planet::MERCURY) || (planet > Planet::PLUTO))
    throw CAAVSOP2013Exception{CAAVSOP2013Exception::REASON::PLANET_IS_INVALID};

  constexpr double gmsol{2.9591220836841438269E-04};
  static constexpr std::array<double, 9> gmp
  { {
     4.9125474514508118699E-11,
     7.2434524861627027000E-10,
     8.9970116036316091182E-10,
     9.5495351057792580598E-11,
     2.8253458420837780000E-07,
     8.4597151856806587398E-08,
     1.2920249167819693900E-08,
     1.5243589007842762800E-08,
     2.1886997654259696800E-12
  } };
#ifdef _MSC_VER
#pragma warning(suppress : 26446 26482)
#endif //#ifdef _MSC_VER
  return CAACoordinateTransformation::RadiansToDegrees(sqrt(gmp[static_cast<int>(planet)] + gmsol)/pow(a, 1.5));
}

CAAEllipticalObjectElements CAAVSOP2013::OrbitToElements(double JD, CAAVSOP2013::Planet planet, const CAAVSOP2013Orbit& orbit)
{
  CAAEllipticalObjectElements elements;
  elements.a = orbit.a;
  elements.e = sqrt((orbit.k*orbit.k) + (orbit.h*orbit.h));
  elements.i = CAACoordinateTransformation::RadiansToDegrees(2.0*asin(sqrt((orbit.q*orbit.q) + (orbit.p*orbit.p))));
  const double w{atan2(orbit.h, orbit.k)}; //here w is longitude of perihelion
  elements.omega = atan2(orbit.p, orbit.q);
  elements.w = CAACoordinateTransformation::RadiansToDegrees(CAACoordinateTransformation::MapTo0To2PIRange(w - elements.omega)); //argument of perihelion = longitude of perihelion - longitude of ascending node
  elements.omega = CAACoordinateTransformation::RadiansToDegrees(elements.omega);
  elements.JDEquinox = JD;
  const double MeanMotion{CalculateMeanMotion(planet, orbit.a)};
  elements.T = JD - CAACoordinateTransformation::RadiansToDegrees(orbit.lambda/MeanMotion) + CAACoordinateTransformation::RadiansToDegrees(w/MeanMotion);
  return elements;
}

CAAVSOP2013Position CAAVSOP2013::Ecliptic2Equatorial(const CAAVSOP2013Position& value) noexcept
{
  constexpr double coeff11{0.99999999999996836};
  constexpr double coeff12{2.3076633339445195e-07};
  constexpr double coeff13{-1.0004940139786859e-07};
  constexpr double coeff21{-2.5152133775962465e-07};
  constexpr double coeff22{0.91748213272857493};
  constexpr double coeff23{-0.39777699295429642};
  constexpr double coeff32{0.39777699295430902};
  constexpr double coeff33{0.91748213272860391};

  CAAVSOP2013Position Equatorial;
  Equatorial.X = (coeff11*value.X) + (coeff12*value.Y) + (coeff13*value.Z);
  Equatorial.Y = (coeff21*value.X) + (coeff22*value.Y) + (coeff23*value.Z);
  Equatorial.Z = (coeff32*value.Y) + (coeff33*value.Z);
  Equatorial.X_DASH = (coeff11*value.X_DASH) + (coeff12*value.Y_DASH) + (coeff13*value.Z_DASH);
  Equatorial.Y_DASH = (coeff21*value.X_DASH) + (coeff22*value.Y_DASH) + (coeff23*value.Z_DASH);
  Equatorial.Z_DASH = (coeff32*value.Y_DASH) + (coeff33*value.Z_DASH);
  return Equatorial;
}
