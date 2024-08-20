# 说明

本程序为采用Qt库编写的托盘程序，方便快速调用环境的某些功能。

# 终端说明

## Windows

在Windows中，默认情况下bat脚本运行在cmd.exe中，sh脚本运行在MSYS2的终端中。

## Linux

HEnvBox主要支持debian系Linux,若无特别说明，本章节中也指debian系Linux。

在Linux桌面环境中，若要使用窗口运行脚本程序，通常需要打开一个终端模拟器。

在托盘程序中，使用`x-terminal-emulator`作为运行脚本程序的终端。

x-terminal-emulator由update-alternatives管理，通常指向真正的终端模拟器程序，有时默认的终端程序可能不能满足托盘程序的需求（不能正常工作），此时需要使用`sudo update-alternatives --config x-terminal-emulator`切换终端程序。

# 源代码

源代码目录:[HEnvBoxTray](HEnvBoxTray)

源代码采用CMake管理，可使用qtcreator直接打开。

# 编译

编译本程序需要安装好Qt库及编译环境(包含CMake)。

通常情况下，若已成功安装HEnvBox，那么环境就已被配置好，但需要注意的是在Windows下不能使用cmd环境与MSYS2 MSYS环境，推荐在Windows下使用MSYS2 UCRT64环境。

可使用以下命令编译：

```bash
#创建目录并进入
mkdir build
cd build
#配置
cmake ../HEnvBoxTray
#编译,编译完成后即可得到托盘程序
cmake --build .
```

# 自动启动

注意：自动启动的步骤是紧接着编译的步骤的，设置自动启动时需要先编译成功。

## Linux桌面环境

注意：

- 桌面环境需要支持自动启动/etc/xdg/autostart目录下的文件,具体见[autostart-spec](https://specifications.freedesktop.org/autostart-spec/0.5/)。

- 自动启动不支持卸载，如需卸载则需要手动清理/etc/xdg/autostart目录。

```bash
#安装
sudo cmake --build . -t install
```

## Windows

注意：

- 自动启动采用开始菜单的启动文件夹,默认文件夹为%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup,可通过注册表修改，修改后无法安装自动启动。
- 自动启动不支持卸载，如需卸载则需要手动清理开始菜单的启动文件夹。
- 若安装有杀毒软件,可能会被拦截，如确实需要自动启动，请允许写入启动文件夹。

```bash
#安装
cmake --build . -t install
```

# 截图

## windows

![HEnvBoxTray_Windows](image/HEnvBoxTray_Windows.png)

## debian

![HEnvBoxTray_Windows](image/HEnvBoxTray_debian.png)

