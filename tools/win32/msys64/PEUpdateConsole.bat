@echo off


@rem 执行安装脚本
set InstallScript=%HENVBOX_TOOLS_PATH%\%HENVBOX_TOOLS_TYPE%\PEUpdateConsole.sh
set InstallScript=%InstallScript:\=/%
set InstallScript=%InstallScript://=/%
pushd %HENVBOX_TOOLS_PATH%\%HENVBOX_TOOLS_TYPE%\
%HENVBOX_LOCAL_ROOT_PATH%\%HENVBOX_TOOLS_TYPE%\msys2.exe %InstallScript%
if not x%ERRORLEVEL%==x0 set Failure=1
popd 
if x%Failure%==x1 goto :Failure

goto :eof
:Failure
echo PEUpdateConsole Failed
goto :eof
