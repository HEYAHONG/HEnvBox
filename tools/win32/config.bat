@echo off

@rem tools目录
set HENVBOX_TOOLS_PATH=%~dp0

@rem 设置工具类型
if exist  "%PROGRAMFILES(X86)%"  (set HENVBOX_TOOLS_TYPE=msys64) else (set HENVBOX_TOOLS_TYPE=msys32) 

@rem 调用相关config.bat
if exist "%HENVBOX_TOOLS_PATH%\%HENVBOX_TOOLS_TYPE%\config.bat" call "%HENVBOX_TOOLS_PATH%\%HENVBOX_TOOLS_TYPE%\config.bat"

@rem 调整PATH变量
call :AddToPATH "%HENVBOX_TOOLS_PATH%\bin"


@rem 添加到PATH环境变量
goto :eof
:AddToPATH
set NEW_PATH_ITEM=%1
set NEW_PATH_ITEM=%NEW_PATH_ITEM:/=\%
set NEW_PATH_ITEM_STRIP=%NEW_PATH_ITEM:\\=\%
set PATH=%NEW_PATH_ITEM_STRIP%;%PATH%
goto :eof