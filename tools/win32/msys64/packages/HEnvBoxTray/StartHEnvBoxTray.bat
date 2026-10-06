
@echo off

@rem 设置变量

set CURRENT_PATH=%~dp0
call "%CURRENT_PATH%\..\..\..\..\..\config.bat"

@rem 启动HEnvBoxTray

if exist "%HENVBOX_LOCAL_ROOT_PATH%\%HENVBOX_TOOLS_TYPE%\ucrt64\bin\HEnvBoxTray.exe"  start "HEnvBoxTray" "%HENVBOX_LOCAL_ROOT_PATH%\%HENVBOX_TOOLS_TYPE%\ucrt64\bin\HEnvBoxTray.exe"

exit 0

