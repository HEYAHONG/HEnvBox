@echo off

@rem HEnvBox目录
set HENVBOX_ROOT_PATH=%~dp0

@rem 调用config.bat
call "%HENVBOX_ROOT_PATH%\config.bat"


@rem 删除右键菜单
call :RemoveMenu HEnvBox
call :RemoveMenu HEnvBoxMSYS2
call :RemoveMenu HEnvBoxMINGW32
call :RemoveMenu HEnvBoxMINGW64
call :RemoveMenu HEnvBoxCLANG32
call :RemoveMenu HEnvBoxCLANG64
call :RemoveMenu HEnvBoxCLANGARM64
call :RemoveMenu HEnvBoxUCRT64
call :RemoveMenuGroup

@rem 删除右键菜单
@rem 参数1：在注册表中的名称(不可带引号)，参数2:显示名称，参数3：命令
goto :eof
:RemoveMenu
set REG_NAME=%1
reg delete "HKCR\Directory\shell\HEnvBox\shell\%REG_NAME%"  /f  
reg delete "HKCR\Directory\Background\shell\HEnvBox\shell\%REG_NAME%"  /f  
goto :eof

@rem 添加菜单组
goto :eof
:RemoveMenuGroup
reg delete "HKCR\Directory\shell\HEnvBox"  /f 
reg delete "HKCR\Directory\Background\shell\HEnvBox" /f 
goto :eof 