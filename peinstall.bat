@echo off

@rem HEnvBox目录
set HENVBOX_ROOT_PATH=%~dp0

@rem 调用config.bat
call "%HENVBOX_ROOT_PATH%\config.bat"

@rem 导入tools目录中的安装脚本
if exist "%HENVBOX_ROOT_PATH%\tools\%HENVBOX_TYPE%\install.bat" call "%HENVBOX_ROOT_PATH%\tools\%HENVBOX_TYPE%\install.bat"

@rem 暂停以查看错误信息
if x%Failure%==x1 pause
