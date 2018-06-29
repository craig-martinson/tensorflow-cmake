@echo off
setlocal
set PROJECT_ROOT=%CD%

set VISUAL_STUDIO_VERSION="Visual Studio 15 2017 Win64"

REM Get cmake
WHERE cmake >nul 2>nul
IF %ERRORLEVEL% NEQ 0 (
	call :installcmake
)

 REM Clone tensorflow repository
echo Cloning tensorflow project...
git clone https://github.com/tensorflow/tensorflow.git
cd %PROJECT_ROOT%\tensorflow
git checkout r1.9 

REM Set compiler environment
cd "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Auxiliary\Build"
call vcvarsall.bat amd64

REM Build tensorflow static libraries
echo Generating tensorflow project files...
cd %PROJECT_ROOT%\tensorflow\tensorflow\contrib\cmake
IF EXIST build rd /S /Q build
mkdir build
cd build
cmake -Dtensorflow_BUILD_ALL_KERNELS=OFF -Dtensorflow_BUILD_PYTHON_BINDINGS=OFF -Dtensorflow_ENABLE_GRPC_SUPPORT==OFF -Dtensorflow_BUILD_CC_EXAMPLE=OFF -Dtensorflow_WIN_CPU_SIMD_OPTIONS=ON -G%VISUAL_STUDIO_VERSION% ..
msbuild.exe tensorflow.sln /t:Build /p:Configuration=Release;Platform=x64

REM Build solution
echo Building solution...
cd %PROJECT_ROOT%
IF EXIST build rd /S /Q build
mkdir build
cd build
cmake -G%VISUAL_STUDIO_VERSION% ..
msbuild TENSORFLOWTEST.sln /p:Configuration=Release

REM All done
echo All done - SUCCESS
goto :eof

REM Helper functions

REM Install CMake helper
:installcmake
if NOT EXIST cmake-3.10.0-win64-x64 call :downloadcmake
set PATH=%PATH%;%PROJECT_ROOT%\cmake-3.10.0-win64-x64\bin;
goto :eof

:downloadcmake
echo CMake was not found, so we are installing it for you... 
REM %PROJECT_ROOT%\tools\httpget "https://cmake.org/files/v3.10/cmake-3.10.0-win64-x64.zip"
powershell -command "& { [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; iwr https://cmake.org/files/v3.10/cmake-3.10.0-win64-x64.zip -OutFile cmake-3.10.0-win64-x64.zip }"
if ERRORLEVEL 1 goto :cmakefailed
echo Decompressing cmake-3.10.0-win64-x64.zip...
%PROJECT_ROOT%\tools\unzip "cmake-3.10.0-win64-x64.zip"
if ERRORLEVEL 1 goto :cmakefailed
del cmake-3.10.0-win64-x64.zip
goto :eof

:cmakefailed
echo CMake install failed, please install cmake manually from https://cmake.org/
goto :buildfailed

:buildfailed
chdir /d %PROJECT_ROOT% 
echo #### Build failed
goto :eof