@echo off
SETLOCAL EnableExtensions EnableDelayedExpansion

set BUILD_TYPE=release
if /i "%1" == "debug" (
    SET BUILD_TYPE=debug
)

echo:
echo Build type: %BUILD_TYPE%

:: setup INCLUDE and LIB environment variables
:: OpenSSL
set OPENSSL_DIR=d:\dev\openssl_static
set OPENSSL_LIB=%OPENSSL_DIR%\lib
set OPENSSL_INCLUDE=%OPENSSL_DIR%\include

:: ICU
set ICU_DIR=d:\Source\libicu
set ICU_LIB=%OPENSSL_DIR%\lib
set ICU_INCLUDE=%OPENSSL_DIR%\include

:: libxml
set LIBXML_DIR=d:\dev\libxml_build
set LIBXML_LIB=%LIBXML_DIR%\lib\
set LIBXML_INCLUDE=%LIBXML_DIR%\include\libxml2\

set LIB=%OPENSSL_LIB%;%ICU_LIB%;%LIBXML_LIB%;%LIB%
set INCLUDE=%OPENSSL_INCLUDE%;%ICU_INCLUDE%;%LIBXML_DIR%;%INCLUDE%

:: Build Qt5
cd qtbase

set QT_CONFIG=

set QT_CONFIG=%QT_CONFIG% -%BUILD_TYPE%
set QT_CONFIG=%QT_CONFIG% -static
set QT_CONFIG=%QT_CONFIG% -opensource
set QT_CONFIG=%QT_CONFIG% -nomake tests
set QT_CONFIG=%QT_CONFIG% -nomake examples
set QT_CONFIG=%QT_CONFIG% -mp
set QT_CONFIG=%QT_CONFIG% -no-cetest
set QT_CONFIG=%QT_CONFIG% -no-iwmmxt
set QT_CONFIG=%QT_CONFIG% -no-vcproj
set QT_CONFIG=%QT_CONFIG% -no-angle
set QT_CONFIG=%QT_CONFIG% -no-opengl
set QT_CONFIG=%QT_CONFIG% -icu
set QT_CONFIG=%QT_CONFIG% -qt-zlib
set QT_CONFIG=%QT_CONFIG% -qt-libpng
set QT_CONFIG=%QT_CONFIG% -qt-libjpeg
set QT_CONFIG=%QT_CONFIG% -openssl-linked
set QT_CONFIG=%QT_CONFIG% -platform win32-msvc2010

:: Build information
echo:
echo LIB: %LIB%
echo INCLUDE: %INCLUDE%
echo QT_CONFIG: %QT_CONFIG%

:: set MAKE_TOOL=jom
set MAKE_TOOL=nmake

configure %QT_CONFIG%

call %MAKE_TOOL%

cd ..