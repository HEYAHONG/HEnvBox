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
call ::AddMenuGroup
call :AddMenu HEnvBox "HEnvBox Cmd" "cmd.exe /k call %HENVBOX_ROOT_PATH%\config.bat"
if exist %HENVBOX_LOCAL_ROOT_PATH%\%HENVBOX_TOOLS_TYPE%\msys2.exe call :AddMenu HEnvBoxMSYS2 "HEnvBox MSYS2"  "%HENVBOX_LOCAL_ROOT_PATH%\%HENVBOX_TOOLS_TYPE%\msys2.exe bash"
if exist %HENVBOX_LOCAL_ROOT_PATH%\%HENVBOX_TOOLS_TYPE%\mingw32.exe call :AddMenu HEnvBoxMINGW32 "HEnvBox MINGW32"  "%HENVBOX_LOCAL_ROOT_PATH%\%HENVBOX_TOOLS_TYPE%\mingw32.exe bash"
if exist %HENVBOX_LOCAL_ROOT_PATH%\%HENVBOX_TOOLS_TYPE%\mingw64.exe call :AddMenu HEnvBoxMINGW64 "HEnvBox MINGW64"  "%HENVBOX_LOCAL_ROOT_PATH%\%HENVBOX_TOOLS_TYPE%\mingw64.exe bash"
if exist %HENVBOX_LOCAL_ROOT_PATH%\%HENVBOX_TOOLS_TYPE%\clang32.exe call :AddMenu HEnvBoxCLANG32 "HEnvBox CLANG32"  "%HENVBOX_LOCAL_ROOT_PATH%\%HENVBOX_TOOLS_TYPE%\clang32.exe bash"
if exist %HENVBOX_LOCAL_ROOT_PATH%\%HENVBOX_TOOLS_TYPE%\clang64.exe call :AddMenu HEnvBoxCLANG64 "HEnvBox CLANG64"  "%HENVBOX_LOCAL_ROOT_PATH%\%HENVBOX_TOOLS_TYPE%\clang64.exe bash"
if exist %HENVBOX_LOCAL_ROOT_PATH%\%HENVBOX_TOOLS_TYPE%\clangarm64.exe call :AddMenu HEnvBoxCLANGARM64 "HEnvBox CLANGARM64"  "%HENVBOX_LOCAL_ROOT_PATH%\%HENVBOX_TOOLS_TYPE%\clangarm64.exe bash"
if exist %HENVBOX_LOCAL_ROOT_PATH%\%HENVBOX_TOOLS_TYPE%\ucrt64.exe call :AddMenu HEnvBoxUCRT64 "HEnvBox UCRT64"  "%HENVBOX_LOCAL_ROOT_PATH%\%HENVBOX_TOOLS_TYPE%\ucrt64.exe bash"


@rem 添加右键菜单
@rem 参数1：在注册表中的名称(不可带引号)，参数2:显示名称，参数3：命令
goto :eof
:AddMenu
set REG_NAME=%1
set REG_DISPLAY_NAME=%2
set REG_CMD=%3
reg add "HKCR\Directory\shell\HEnvBox\shell\%REG_NAME%" /t REG_SZ /f  /ve /d %REG_DISPLAY_NAME%
reg add "HKCR\Directory\shell\HEnvBox\shell\%REG_NAME%\command" /t REG_SZ /f  /ve /d %REG_CMD%
reg add "HKCR\Directory\Background\shell\HEnvBox\shell\%REG_NAME%"  /t REG_SZ /f  /ve /d %REG_DISPLAY_NAME%
reg add "HKCR\Directory\Background\shell\HEnvBox\shell\%REG_NAME%\command" /t REG_SZ /f  /ve /d %REG_CMD%
goto :eof

@rem 添加菜单组
goto :eof
:AddMenuGroup
reg add "HKCR\Directory\shell\HEnvBox" /t REG_SZ /f  /ve /d ""
reg add "HKCR\Directory\shell\HEnvBox" /t REG_SZ /f  /v MUIVerb /d "&HEnvBox"
reg add "HKCR\Directory\shell\HEnvBox" /t REG_SZ /f  /v position /d Middle
reg add "HKCR\Directory\shell\HEnvBox" /t REG_SZ /f  /v SubCommands /d ""
reg add "HKCR\Directory\shell\HEnvBox\shell" /t REG_SZ /f  /ve /d ""
reg add "HKCR\Directory\Background\shell\HEnvBox" /t REG_SZ /f  /ve /d ""
reg add "HKCR\Directory\Background\shell\HEnvBox" /t REG_SZ /f  /v MUIVerb /d "&HEnvBox"
reg add "HKCR\Directory\Background\shell\HEnvBox" /t REG_SZ /f  /v position /d Middle
reg add "HKCR\Directory\Background\shell\HEnvBox" /t REG_SZ /f  /v SubCommands /d ""
reg add "HKCR\Directory\Background\shell\HEnvBox\shell" /t REG_SZ /f  /ve /d ""
goto :eof 