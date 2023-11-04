@echo off

@rem HEnvBox目录
set HENVBOX_ROOT_PATH=%~dp0

@rem 调用config.bat
call "%HENVBOX_ROOT_PATH%\config.bat"


@rem 添加右键菜单
reg delete HKCR\Directory\shell\HEnvBox  /f  
reg delete HKCR\Directory\Background\shell\HEnvBox  /f  