@echo off

@rem HEnvBox目录
set HENVBOX_ROOT_PATH=%~dp0

@rem HEnvBox类型
set HENVBOX_TYPE=win32

@rem 导入tools目录中的配置
if exist "%HENVBOX_ROOT_PATH%\tools\%HENVBOX_TYPE%\config.bat" call "%HENVBOX_ROOT_PATH%\tools\%HENVBOX_TYPE%\config.bat"

@rem 创建相关文件夹并添加到PATH
mkdir "%HENVBOX_ROOT_PATH%\local" > nul 2> nul
mkdir "%HENVBOX_ROOT_PATH%\local\bin" > nul 2>nul
set HENVBOX_LOCAL_ROOT_PATH="%HENVBOX_ROOT_PATH%\local"
set HENVBOX_LOCAL_ROOT_PATH=%HENVBOX_LOCAL_ROOT_PATH:\\=\%
set HENVBOX_LOCAL_ROOT_PATH=%HENVBOX_LOCAL_ROOT_PATH:"=%
set HENVBOX_LOCAL_BINDIR_PATH="%HENVBOX_ROOT_PATH%\local\bin"
set HENVBOX_LOCAL_BINDIR_PATH=%HENVBOX_LOCAL_BINDIR_PATH:\\=\%
set HENVBOX_LOCAL_BINDIR_PATH=%HENVBOX_LOCAL_BINDIR_PATH:"=%
set HENVBOX_LOCAL_ROOT_PATH_UNIX=%HENVBOX_LOCAL_ROOT_PATH:\=/%
set HENVBOX_LOCAL_BINDIR_PATH_UNIX=%HENVBOX_LOCAL_BINDIR_PATH:\=/%
call :AddToPATH %HENVBOX_LOCAL_BINDIR_PATH%
call :setCaseSensitiveInfo "%HENVBOX_LOCAL_ROOT_PATH%" enable
call :setCaseSensitiveInfo "%HENVBOX_LOCAL_BINDIR_PATH%" disable

@rem 添加到PATH环境变量
goto :eof
:AddToPATH
set NEW_PATH_ITEM=%1
set NEW_PATH_ITEM=%NEW_PATH_ITEM:/=\%
set NEW_PATH_ITEM_STRIP=%NEW_PATH_ITEM:\\=\%
set PATH=%NEW_PATH_ITEM_STRIP%;%PATH%
goto :eof


@rem 启用目录大小写(参数1为目录路径)
goto :eof
:setCaseSensitiveInfo
set DIR_DEPTH=0
set DIR_MAX_DEPTH=4
call :setCaseSensitiveInfoImp "%1" %2
goto :eof
:setCaseSensitiveInfoImp
if not exist "%1" goto :eof
pushd  "%1" 2> /nul > nul

set /a DIR_DEPTH=%DIR_DEPTH%+1
if "X%DIR_DEPTH%"=="X%DIR_MAX_DEPTH%" goto :setCaseSensitiveInfoImpExit

fsutil file setCaseSensitiveInfo . %2  2> nul  > nul

for /f %%I in ('dir /a:d /b') do (
call :setCaseSensitiveInfoImp %%I %2
)
:setCaseSensitiveInfoImpExit
set /a DIR_DEPTH=%DIR_DEPTH%-1
popd 2> nul  > nul 
goto :eof
