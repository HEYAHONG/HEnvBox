@echo off

@rem HEnvBox目录
set HENVBOX_ROOT_PATH=%~dp0

@rem 调用config.bat
call "%HENVBOX_ROOT_PATH%\config.bat"

@rem 导入tools目录中的安装脚本
if exist "%HENVBOX_ROOT_PATH%\tools\%HENVBOX_TYPE%\install.bat" call "%HENVBOX_ROOT_PATH%\tools\%HENVBOX_TYPE%\install.bat"

@rem 暂停以查看错误信息
if x%Failure%==x1 pause

@rem 添加右键菜单
call :AddMenu HEnvBox "HEnvBox Cmd" "cmd.exe /k call %HENVBOX_ROOT_PATH%\config.bat"

@rem 添加右键菜单
@rem 参数1：在注册表中的名称(不可带引号)，参数2:显示名称，参数3：命令
goto :eof
:AddMenu
set REG_NAME=%1
set REG_DISPLAY_NAME=%2
set REG_CMD=%3
reg add "HKCR\Directory\shell\%REG_NAME%" /t REG_SZ /f  /ve /d %REG_DISPLAY_NAME%
reg add "HKCR\Directory\shell\%REG_NAME%\command" /t REG_SZ /f  /ve /d %REG_CMD%
reg add "HKCR\Directory\Background\shell\%REG_NAME%"  /t REG_SZ /f  /ve /d %REG_DISPLAY_NAME%
reg add "HKCR\Directory\Background\shell\%REG_NAME%\command" /t REG_SZ /f  /ve /d %REG_CMD%
goto :eof