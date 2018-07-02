@echo off
setlocal
set PROJECT_ROOT=%CD%

set VISUAL_STUDIO_VERSION="Visual Studio 15 2017 Win64"
set CONFIGURATION="Release"

REM Update tensorflow submodule
chdir /d %PROJECT_ROOT% 
git submodule update --init

REM Set compiler environment
cd "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Auxiliary\Build"
call vcvarsall.bat amd64

REM Build tensorflow static libraries
echo Building tensorflow static libraries...
cd %PROJECT_ROOT%\tensorflow\tensorflow\contrib\cmake
IF EXIST build rd /S /Q build
mkdir build
cd build
cmake -Dtensorflow_BUILD_PYTHON_BINDINGS=OFF -Dtensorflow_ENABLE_GRPC_SUPPORT==OFF -Dtensorflow_BUILD_CC_EXAMPLE=OFF -Dtensorflow_WIN_CPU_SIMD_OPTIONS=/arch:AVX2 -Dtensorflow_DISABLE_EIGEN_FORCEINLINE=ON -G%VISUAL_STUDIO_VERSION% ..
msbuild.exe tensorflow.sln /t:Build /p:Configuration=%CONFIGURATION%;Platform=x64 /m

REM Build sample application
echo Building sample application...
cd %PROJECT_ROOT%
IF EXIST build rd /S /Q build
mkdir build
cd build
cmake -G%VISUAL_STUDIO_VERSION% ..
msbuild.exe TENSORFLOWTEST.sln /t:Build /p:Configuration=%CONFIGURATION%;Platform=x64 /m

echo All done