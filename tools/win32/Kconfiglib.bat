@echo off

@rem toolsĿ¼
set HENVBOX_TOOLS_PATH=%~dp0

@rem ����config.bat
call "%HENVBOX_TOOLS_PATH%\config.bat"


@rem ִ��menuconfig
PUSHD %HENVBOX_TOOLS_PATH% 2>nul >nul
menuconfig  2>nul >nul
if not ERRORLEVEL 0 goto  :MenuconfigError
POPD 2>nul >nul

goto :eof
:MenuconfigError
echo ����ִ��install.bat��
pause
goto :eof