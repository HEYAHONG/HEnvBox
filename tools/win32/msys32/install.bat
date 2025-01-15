@echo off

rem set MSYS2_SFX_URL=https://repo.msys2.org/distrib/msys2-i686-latest.sfx.exe
set MSYS2_SFX_URL=http://repo.msys2.org/distrib/msys2-i686-latest.sfx.exe

if exist %HENVBOX_LOCAL_ROOT_PATH%\%HENVBOX_TOOLS_TYPE%\msys2_shell.cmd goto :Install

:Download
del /s /q  %HENVBOX_LOCAL_ROOT_PATH%\%HENVBOX_TOOLS_TYPE%.sfx.exe > nul 2> nul 
@rem 下载msys64自解压文件
wget  --no-check-certificate -c -t 0 -O %HENVBOX_LOCAL_ROOT_PATH%\%HENVBOX_TOOLS_TYPE%.sfx.exe  %MSYS2_SFX_URL%
if not x%ERRORLEVEL%==x0 goto :Failure

@rem 执行自解压文件
pushd %HENVBOX_LOCAL_ROOT_PATH%\
%HENVBOX_LOCAL_ROOT_PATH%\%HENVBOX_TOOLS_TYPE%.sfx.exe
if not x%ERRORLEVEL%==x0 set Failure=1
popd
del /s /q %HENVBOX_LOCAL_ROOT_PATH%\%HENVBOX_TOOLS_TYPE%.sfx.exe > nul 2> nul 
if x%Failure%==x1 goto :Failure

:Install
@rem 执行安装脚本
set InstallScript=%HENVBOX_TOOLS_PATH%\%HENVBOX_TOOLS_TYPE%\Install.sh
set InstallScript=%InstallScript:\=/%
set InstallScript=%InstallScript://=/%
pushd %HENVBOX_TOOLS_PATH%\%HENVBOX_TOOLS_TYPE%\
%HENVBOX_LOCAL_ROOT_PATH%\%HENVBOX_TOOLS_TYPE%\msys2.exe %InstallScript%
if not x%ERRORLEVEL%==x0 set Failure=1
popd 
if x%Failure%==x1 goto :Failure

goto :eof
:Failure
echo Install Failed
del /s /q %HENVBOX_LOCAL_ROOT_PATH%\%HENVBOX_TOOLS_TYPE% > nul 2> nul 
goto :eof
