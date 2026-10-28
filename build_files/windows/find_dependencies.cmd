REM find all dependencies and set the corresponding environment variables. 
if "%BLENDER_DIR%"=="" set "BLENDER_DIR=%~dp0..\..\"
if "%BLENDER_DIR:~-1%"=="\" set "BLENDER_DIR=%BLENDER_DIR:~0,-1%"
for %%X in (cmake.exe) do (set CMAKE=%%~$PATH:X)
for %%X in (ctest.exe) do (set CTEST=%%~$PATH:X)
for %%X in (git.exe) do (set GIT=%%~$PATH:X)
for %%X in (ninja.exe) do (set NINJA=%%~$PATH:X)
if "%NINJA%"=="" (
	for %%P in (
		"C:\Program Files\Microsoft Visual Studio\18\Community\Common7\IDE\CommonExtensions\Microsoft\CMake\Ninja\ninja.exe"
		"C:\Program Files\Microsoft Visual Studio\18\Professional\Common7\IDE\CommonExtensions\Microsoft\CMake\Ninja\ninja.exe"
		"C:\Program Files\Microsoft Visual Studio\18\Enterprise\Common7\IDE\CommonExtensions\Microsoft\CMake\Ninja\ninja.exe"
		"C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\IDE\CommonExtensions\Microsoft\CMake\Ninja\ninja.exe"
		"C:\Program Files\Microsoft Visual Studio\2022\Professional\Common7\IDE\CommonExtensions\Microsoft\CMake\Ninja\ninja.exe"
		"C:\Program Files\Microsoft Visual Studio\2022\Enterprise\Common7\IDE\CommonExtensions\Microsoft\CMake\Ninja\ninja.exe"
	) do (
		if EXIST %%P (
			set "NINJA=%%~P"
			set "PATH=%%~dpP;!PATH!"
			goto found_ninja
		)
	)
)
:found_ninja
REM For python, check the bundled libraries first for x64 or arm64.
if "%BUILD_ARCH%" == "arm64" (
	set PYTHON=%BLENDER_DIR%\lib\windows_arm64\python\313\bin\python.exe
	if EXIST !PYTHON! goto detect_python_done
	set PYTHON=%BLENDER_DIR%\lib\windows_arm64\python\311\bin\python.exe
	if EXIST !PYTHON! goto detect_python_done
)

set PYTHON=%BLENDER_DIR%\lib\windows_x64\python\313\bin\python.exe
if EXIST %PYTHON% (
	goto detect_python_done
)
set PYTHON=%BLENDER_DIR%\lib\windows_x64\python\311\bin\python.exe
if EXIST %PYTHON% (
	goto detect_python_done
)
rem Additionally check for the ARM64 version
set PYTHON=%BLENDER_DIR%\lib\windows_arm64\python\313\bin\python.exe
if EXIST %PYTHON% (
	goto detect_python_done
)
set PYTHON=%BLENDER_DIR%\lib\windows_arm64\python\311\bin\python.exe
if EXIST %PYTHON% (
	goto detect_python_done
)

REM Fall back to system python in PATH if bundled python is not yet downloaded
for %%X in (python.exe) do (
	if NOT "%%~$PATH:X"=="" (
		set "PYTHON=%%~$PATH:X"
		goto detect_python_done
	)
)

if NOT EXIST %PYTHON% (
    if EXIST "%BLENDER_DIR%\lib\windows_x64\.git" (
      echo Warning: Python not found, there is likely an issue with the library folder
    )
    set PYTHON=""
)

:detect_python_done
if NOT "%verbose%" == "" (
	echo cmake  : "%CMAKE%"
	echo ctest  : "%CTEST%"
	echo git    : "%GIT%"
	echo python : "%PYTHON%"
)
