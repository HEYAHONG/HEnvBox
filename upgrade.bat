@echo off

@rem HEnvBox目录
set HENVBOX_ROOT_PATH=%~dp0

@rem 更新代码（若采用git管理源代码）
set  HENVBOX_UPGRADE=1
pushd "%HENVBOX_ROOT_PATH%"
if not exist "%HENVBOX_ROOT_PATH%\.git" goto :UPGRADE_EXIT
if not exist "%HENVBOX_ROOT_PATH%\config.bat" goto :UPGRADE_EXIT
call "%HENVBOX_ROOT_PATH%\config.bat"
git pull
:UPGRADE_EXIT
popd


@rem 调用install.bat
call "%HENVBOX_ROOT_PATH%\install.bat"