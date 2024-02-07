@echo off

@rem tools目录
set HENVBOX_TOOLS_PATH=%~dp0

@rem 调用config.bat
call "%HENVBOX_TOOLS_PATH%\config.bat"


@rem 执行menuconfig
PUSHD %HENVBOX_TOOLS_PATH% 2>nul >nul
menuconfig  2>nul >nul
if not ERRORLEVEL 0 goto  :MenuconfigError
POPD 2>nul >nul

goto :eof
:MenuconfigError
echo 请先执行install.bat。
pause
goto :eof