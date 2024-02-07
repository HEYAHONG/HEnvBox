@echo off

@rem HEnvBox目录
set HENVBOX_ROOT_PATH=%~dp0

@rem 调用config.bat
call "%HENVBOX_ROOT_PATH%\config.bat"

@rem 导入tools目录中的Kconfig脚本
if exist "%HENVBOX_ROOT_PATH%\tools\%HENVBOX_TYPE%\Kconfiglib.bat" call "%HENVBOX_ROOT_PATH%\tools\%HENVBOX_TYPE%\Kconfiglib.bat"
