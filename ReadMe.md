# 说明

本工程主要用于快速配置本人常用的开发环境。

主要支持以下操作系统:

- Windows 10及更新版本,架构为x86_64。

对于Windows而言，本人常用[MSYS2](https://www.msys2.org/)作为开发环境。

# 环境变量

本工程主要使用环境变量进行脚本操作:

| 名称                           | 说明                                     | 备注                                    |
| :----------------------------- | :--------------------------------------- | :-------------------------------------- |
| HENVBOX_ROOT_PATH              | 根路径                                   | 此路径的格式由操作系统决定              |
| HENVBOX_TYPE                   | 类型                                     | 对于windows而言，其值固定为win32        |
| HENVBOX_LOCAL_ROOT_PATH        | 本地程序根路经                           | 此路径的格式由操作系统决定              |
| HENVBOX_LOCAL_BINDIR_PATH      | 本地程序根二进制可执行文件路经           | 此路径的格式由操作系统决定              |
| HENVBOX_LOCAL_ROOT_PATH_UNIX   | 本地程序根路经，Unix格式                 | 此路径专用于MSYS2                       |
| HENVBOX_LOCAL_BINDIR_PATH_UNIX | 本地程序根二进制可执行文件路经，Unix格式 | 此路径专用于MSYS2                       |
| HENVBOX_TOOLS_PATH             | tools路径                                | 此路径的格式由操作系统决定              |
| HENVBOX_TOOLS_TYPE             | tools类型                                | 对于windows而言，其值可选msys32或msys64 |

注:本地程序表示需要从网络上下载到本地安装的程序，tools目录为自带工具或者工具安装资源。

# 脚本说明

## Windows

- config.bat：在cmd窗口中使用`call config.bat路径 `可配置环境。
- install.bat：安装或者更新软件包,可多次调用，为防止异常不要同时执行多个实例。
- uninstall.bat:卸载安装，主要用于删除右键信息

# 安装

## Windows

保证目录可写（可参考MSYS2对目录的要求），确保安装路径中没有空格与中文，执行install.bat,等待安装完成。完成后可在目录的右键菜单中找到HEnvBox选项。在需要使用各种MSYS2中的工具时可使用右键菜单打开HEnvBox。

