# 说明

本工程主要用于快速配置本人常用的开发环境。

主要支持以下操作系统:

- [Windows](https://www.microsoft.com) 10及更新版本,架构为x86_64。
- [Ubuntu](https://ubuntu.com/) 22.04，架构为x86_64。
- [Debian](https://www.debian.org/) 12,架构为x86_64。
- [Deepin](https://www.deepin.org) V23,架构为x86_64。

对于Windows而言，本人常用[MSYS2](https://www.msys2.org/)作为开发环境。

对于Linux而言,本人常使用ubuntu,其余基于Linux内核的操作系统可能只有编译环境，而不包含其它工具(如[KiCad](https://www.kicad.org)、[GIMP](https://www.gimp.org)、[Dia](http://dia-installer.de/)等)。

## 目标环境功能

注意:下述功能仅为目标，并非在所有支持的操作系统有效。

- 支持基于[wxWidgets](https://www.wxwidgets.org/)的GUI程序编译。
- 支持基于[Qt](https://www.qt.io/)的GUI程序编译。
- 支持基于[opencv](https://opencv.org/)的程序编译。
- 支持基于[boost](https://www.boost.org/)的程序编译。
- 支持常用的构建系统/构建工具，如[make](https://www.gnu.org/software/make/)、autotools([automake](https://www.gnu.org/software/automake/)、[autoconf](https://www.gnu.org/software/autoconf/))、[ninja](https://ninja-build.org/)、[cmake](https://cmake.org/)、[scons](https://scons.org/)、[xmake](https://xmake.io/#/)、[meson](http://mesonbuild.com/)等
- 支持常用的Kconfig配置工具,如kconfig-frontends、python-kconfiglib。
- 支持[Qemu](https://www.qemu.org/)测试。
- 支持arm裸机程序开发(采用arm-none-eabi-gcc工具链)。
- 支持riscv裸机程序开发(采用riscv64-unknown-elf-gcc工具链)。
- 支持使用[crosstool-ng](http://crosstool-ng.org)创建自定义工具链。
- 支持基于[openwrt](https://openwrt.org/)/[buildroot](https://buildroot.org/)的固件程序编译。
- 无论是Windows还是Linux,均采用[bash](https://www.gnu.org/software/bash/)作为默认脚本解释器,并且支持一些小工具，如neofetch。
- 支持使用常用的编程语言编译程序,如C、C++、Go、Lua、Rust等。

## 下载说明

本工程可通过git工具下载,但需要注意的是，下载前请确认未启用git的autocrlf选项，否则可能导致安装异常。

## 存储空间

由于是创建开发环境，则会尽可能多地安装软件，故占用空间较大。

Windows推荐200G以上空间（本工程目录），Linux推荐100G以上空间（本工程目录+系统软件包安装目录）。

一般情况下，本工程将下载的软件放入本地程序根路径所在目录，但在某些系统中（如Linux），将使用系统软件包管理工具安装软件，此时下载的软件将占用系统空间。

# 工具

## 镜像工具

镜像工具一般用于备份各种源代码（包括但不限于github.com、gitee.com）以供不时之需，如备份源代码仓库。

具体说明见[ReadMe.Tools.Mirror.md](ReadMe.Tools.Mirror.md ) 

## 路径工具

路径工具一般用于创建某些目录/软连接，现主要用于将openwrt/buildroot的下载目录指向同一个目录。

具体说明见[ReadMe.Tools.Path_Patch.md](ReadMe.Tools.Path_Patch.md)

## crosstool-ng

crosstool-ng是一款交叉编译工具链创建工具.

具体说明见[ReadMe.Tools.crosstool-ng.md](ReadMe.Tools.crosstool-ng.md)

## cutecom-ng

cutecom-ng是一个基于Qt的串口工具,可用于串口调试。

具体说明见[ReadMe.Tools.cutecom-ng.md](ReadMe.Tools.cutecom-ng.md)

## EnvCheck

环境检查相关脚本，具体见[tools/EnvCheck](tools/EnvCheck).

# 开发环境

对于一般开发而言，安装好HEnvBox即可正常使用开发环境。

但对某些软件而言，可能需要特殊的设置。

## openwrt

辅助开发openwrt的工具。

具体说明见[ReadMe.DevEnv.openwrt.md](ReadMe.DevEnv.openwrt.md) 

# 环境变量

本工程主要使用环境变量进行脚本操作:

| 名称                           | 说明                                     | 备注                                                         |
| :----------------------------- | :--------------------------------------- | :----------------------------------------------------------- |
| HENVBOX_ROOT_PATH              | 根路径                                   | 此路径的格式由操作系统决定                                   |
| HENVBOX_TYPE                   | 类型                                     | 对于windows而言，其值固定为win32，对于其它系统而言，其值为uname -s返回的值。 |
| HENVBOX_LOCAL_ROOT_PATH        | 本地程序根路经                           | 此路径的格式由操作系统决定                                   |
| HENVBOX_LOCAL_BINDIR_PATH      | 本地程序根二进制可执行文件路经           | 此路径的格式由操作系统决定                                   |
| HENVBOX_LOCAL_ROOT_PATH_UNIX   | 本地程序根路经，Unix格式                 | 此路径专用于MSYS2                                            |
| HENVBOX_LOCAL_BINDIR_PATH_UNIX | 本地程序根二进制可执行文件路经，Unix格式 | 此路径专用于MSYS2                                            |
| HENVBOX_TOOLS_PATH             | tools路径                                | 此路径的格式由操作系统决定                                   |
| HENVBOX_TOOLS_TYPE             | tools类型                                | 对于windows而言，其值可选msys32或msys64。对于其它系统而言，其值为软件包管理工具名称或者默认值common。 |

注1:本地程序表示需要从网络上下载到本地安装的程序，tools目录为自带工具或者工具安装资源。

注2:所有环境变量在cmd中可使用`set`查看，在Linux或者MSYS2中可使用`env`查看。

# 脚本说明

## Windows

- config.bat：在cmd窗口中使用`call config.bat路径 `可配置环境。
- install.bat：安装或者更新软件包,可多次调用，为防止异常不要同时执行多个实例。
- upgrade.bat：更新软件包,可多次调用。
- uninstall.bat:卸载安装，主要用于删除右键信息
- Kconfiglib.bat:配置Kconfig，在首次正确安装后可使用,用于配置可选项,采用python-kconfiglib配置。

## Linux

- config.sh：在bash中使用`. config.bat路径 `可配置环境。
- install.sh：安装或者更新软件包,可多次调用，为防止异常不要同时执行多个实例。
- upgrade.sh：更新软件包,可多次调用。
- uninstall.sh:卸载安装，主要用于删除.bashrc信息。注意:为保证系统稳定性，不会删除已安装的软件包。
- menuconfig.sh:配置Kconfig，在首次正确安装后可使用,用于配置可选项,采用kconfig-frontends配置。

# 安装

## Windows

保证目录可写（可参考MSYS2对目录的要求），确保安装路径中没有空格与中文。

以管理员权限执行install.bat,等待安装完成(注意:由于第一次更新pacman可能主动关闭窗口,若第一次安装时间小于10分钟且右键菜单打不开,需要重新运行安装脚本)。

完成后可在目录的右键菜单中找到HEnvBox选项。在需要使用各种MSYS2中的工具时可使用右键菜单打开HEnvBox。

## Linux

使用具有管理员权限的账户(可使用sudo提权)执行install.sh,等待安装完成,期间可能要求输入用户密码。

# 使用

## Windows

- 默认情况下，使用Msys2的UCRT64环境。如需编译32位应用，可使用Msys2的MINGW32环境(由于较多应用停止支持32位，因此此环境可能功能不全)。
- 如需保持工具的更新，请定期执行更新脚本，若太长时间（如几个月）不更新，可能因为GPG签名过期而无法更新。
- 若出现Msys2相关子菜单无法打开，有可能是未安装完成，再次执行安装脚本即可。
- 对于Windows11而言，右键菜单与之前版本不一致，需要按住Shift键再使用右键打开菜单。

## Linux

对于Linux而言，当安装完成后,本工程会通过用户`.bashrc`文件自动加载，因此用户直接打开终端即可使用相关工具。

# 托盘程序

见[tools/Tray](tools/Tray)。

托盘程序可作为一个运行脚本的快捷入口。

# 推荐资源

## 软件

- [Msys2](https://www.msys2.org/)
- [Cygwin](https://cygwin.com/)
- [0install](https://0install.net/):去中心化的软件安装系统
- [sysinternals](https://learn.microsoft.com/zh-cn/sysinternals/downloads/sysinternals-suite):Windows下实用工具。
- [ConEmu](https://conemu.github.io/)
