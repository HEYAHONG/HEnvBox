@echo off

@rem tools目录
set HENVBOX_TOOLS_PATH=%~dp0

@rem 调用config.bat
call "%HENVBOX_TOOLS_PATH%\config.bat"

@rem 调用相关install.bat
if exist "%HENVBOX_TOOLS_PATH%\%HENVBOX_TOOLS_TYPE%\install.bat" call "%HENVBOX_TOOLS_PATH%\%HENVBOX_TOOLS_TYPE%\install.bat"