@echo off

@rem 执行卸载脚本
set UnInstallScript=%HENVBOX_TOOLS_PATH%\%HENVBOX_TOOLS_TYPE%\UnInstall.sh
set UnInstallScript=%UnInstallScript:\=/%
set UnInstallScript=%UnInstallScript://=/%
pushd %HENVBOX_TOOLS_PATH%\%HENVBOX_TOOLS_TYPE%\
%HENVBOX_LOCAL_ROOT_PATH%\%HENVBOX_TOOLS_TYPE%\msys2.exe %UnInstallScript%
if not x%ERRORLEVEL%==x0 set Failure=1
popd 
if x%Failure%==x1 goto :Failure

goto :eof
:Failure
echo UnInstall Failed
goto :eof
