# 说明

本工程主要用于快速配置本人常用的开发环境。

主要支持以下操作系统:

- Windows 10及更新版本,架构为x86_64。
- Ubuntu 22.04，架构为x86_64。

对于Windows而言，本人常用[MSYS2](https://www.msys2.org/)作为开发环境。

## 存储空间

由于是创建开发环境，则会尽可能多地安装软件，故占用空间较大。

Windows推荐200G以上空间（本工程目录），Linux推荐100G以上空间（本工程目录+系统软件包安装目录）。

一般情况下，本工程将下载的软件放入本地程序根路径所在目录，但在某些系统中（如Linux），将使用系统软件包管理工具安装软件，此时下载的软件将占用系统空间。

## 交叉编译工具链

对于比较流行的编译目标(如arm-none-eabi),各个系统厂商或者MSYS2官方可能会收录相关软件包。

若官方未收录或者期待使用较新的交叉编译工具链，可采用[crosstool-ng](http://crosstool-ng.org)编译。

注意:在Windows(Windows 10及更新版本)中,MSYS2的crosstool-ng需要目录支持大小写，可在创建目录后使用`fsutil file setCaseSensitiveInfo 新创建的目录`创建一个支持大小写的NTFS目录后使用该目录编译。

# 工具

## gitee_com_mirror

备份gitee.com的用户、组织或企业的公开仓库的工具。

可用于在线软件的实现，即在gitee.com上创建一个组织放在线软件包,再使用此工具同步。

### 运行环境

本工具需要在已安装好HEnvBox的环境下运行。具体运行环境要求如下:

- Bash (Linux)
- MSYS2 UCRT64 (64位Windows)
- MSYS2 MINGW32 （32位Windows）

### 配置

本工具通过文件进行配置，工具根目录为 `本地程序根路径/gitee.com`，所有文件均需放置此目录。

具体配置文件如下:

- config.sh:配置文件，一般用于声明变量。
- user.list:用户列表,每行表示一个用户。
- org.list:组织列表,每行表示一个组织
- enterprise.list:企业列表，每行表示一个企业。

##### config.sh

本配置文件为bash脚本文件，可用于配置一些变量:

- REPO_USE_SSH:当此变量非空时表示使用ssh备份,需要先手动配置ssh,即确保可使用`git clone`通过ssh备份。
- GITEE_COM_ACCESS_TOKEN：gitee.com私人令牌，配置好私人令牌可避免一些速率限制(尤其是多人共享一个公网IP上网时)。

### 使用

本工具可手动调用`gitee_com_mirror`启动，如需自动运行,请确保先导入了HEnvBox的配置文件。

除了通过配置用户、组织或企业的列表备份相应文件，也支持用户直接将仓库(非bare仓库,仓库目录不能含有空格)放在工具根目录下,启动工具后会自动更新仓库。

## github_com_mirror

备份github.com的用户或组织的公开仓库的工具。

可用于在线软件的实现，即在github.com上创建一个组织放在线软件包,再使用此工具同步。

### 运行环境

本工具需要在已安装好HEnvBox的环境下运行。具体运行环境要求如下:

- Bash (Linux)
- MSYS2 UCRT64 (64位Windows)
- MSYS2 MINGW32 （32位Windows）

### 配置

本工具通过文件进行配置，工具根目录为 `本地程序根路径/github.com`，所有文件均需放置此目录。

具体配置文件如下:

- config.sh:配置文件，一般用于声明变量。
- user.list:用户列表,每行表示一个用户。
- org.list:组织列表,每行表示一个组织

##### config.sh

本配置文件为bash脚本文件，可用于配置一些变量:

- REPO_USE_SSH:当此变量非空时表示使用ssh备份,需要先手动配置ssh,即确保可使用`git clone`通过ssh备份。

### 使用

本工具可手动调用`github_com_mirror`启动，如需自动运行,请确保先导入了HEnvBox的配置文件。

除了通过配置用户、组织的列表备份相应文件，也支持用户直接将仓库(非bare仓库,仓库目录不能含有空格)放在工具根目录下,启动工具后会自动更新仓库。

注意:由于国内github.com连接不稳定，建议配置好git的代理上网与系统代理上网再使用此工具同步。

## gitea_mirror

备份使用[gitea](https://www.gitea.com)自建站的用户或组织的公开仓库的工具。

可用于在线软件的实现，即在使用[gitea](https://www.gitea.com)自建的站点上创建一个组织放在线软件包,再使用此工具同步。

### 运行环境

本工具需要在已安装好HEnvBox的环境下运行。具体运行环境要求如下:

- Bash (Linux)
- MSYS2 UCRT64 (64位Windows)
- MSYS2 MINGW32 （32位Windows）

### 配置

本工具通过文件进行配置，工具根目录为 `本地程序根路径/gitea`，所有文件均需放置此目录。

具体配置文件如下:

- config.sh:配置文件，一般用于声明变量。
- site.list:站点列表，每行一个站点，每个站点的站点目录为站点URL去掉/并使用_替换:后的字符串，如http://gitea.hyhsystem.cn:3000/的站点目录为http_gitea.hyhsystem.cn_3000。
- [站点目录]/user.list:用户列表,每行表示一个用户。
- [站点目录]/org.list:组织列表,每行表示一个组织

##### config.sh

本配置文件为bash脚本文件，可用于配置一些变量:

- REPO_USE_SSH:当此变量非空时表示使用ssh备份,需要先手动配置ssh,即确保可使用`git clone`通过ssh备份。

### 使用

本工具可手动调用`gitea_mirror`启动，如需自动运行,请确保先导入了HEnvBox的配置文件。

除了通过配置用户、组织或企业的列表备份相应文件，也支持用户直接将仓库(非bare仓库,仓库目录不能含有空格)放在工具根目录下,启动工具后会自动更新仓库。

## ftp_gnu_org_mirror

下载(镜像)ftp.gnu.org的软件。将其下载到本地目录。

### 运行环境

本工具需要在已安装好HEnvBox的环境下运行。具体运行环境要求如下:

- Bash (Linux)
- MSYS2 UCRT64 (64位Windows)
- MSYS2 MINGW32 （32位Windows）

### 配置

本工具通过文件进行配置，工具根目录为 `本地程序根路径/ftp.gnu.org`，所有文件均需放置此目录。

具体配置文件如下:

- config.sh:配置文件，一般用于声明变量。
- dir.list:需要镜像的目录,每行表示一个,如下载nettle目录则为nettle。
- file.list:需要镜像的文件,每行表示一个,如下载gcc-13.2.0.tar.gz则为gcc/gcc-13.2.0/gcc-13.2.0.tar.gz。

##### config.sh

本配置文件为bash脚本文件，可用于配置一些变量:

- RSYNC_URL:rsync网络镜像URL。

RSYNC_URL一般可选择以下选项:

- rsync://ftp.gnu.org/gnu/
- rsync://rsync.mirrors.ustc.edu.cn/gnu/
- rsync://mirrors.tuna.tsinghua.edu.cn/gnu/

### 使用

本工具可手动调用`ftp_gnu_org_mirror`启动，如需自动运行,请确保先导入了HEnvBox的配置文件。

## kernel_org_mirror

下载(镜像)kernel.org的软件。将其下载到本地目录。

### 运行环境

本工具需要在已安装好HEnvBox的环境下运行。具体运行环境要求如下:

- Bash (Linux)
- MSYS2 UCRT64 (64位Windows)
- MSYS2 MINGW32 （32位Windows）

### 配置

本工具通过文件进行配置，工具根目录为 `本地程序根路径/kernel.org`，所有文件均需放置此目录。

具体配置文件如下:

- config.sh:配置文件，一般用于声明变量。
- dir.list:需要镜像的目录,每行表示一个,如下载software目录则为software。
- file.list:需要镜像的文件,每行表示一个,如下载linux-6.5.tar.xz则为linux/kernel/v6.x/linux-6.5.tar.xz。

##### config.sh

本配置文件为bash脚本文件，可用于配置一些变量:

- RSYNC_URL:rsync网络镜像URL。

RSYNC_URL一般可选择以下选项:

- rsync://rsync.kernel.org/pub/
- rsync://rsync.mirrors.ustc.edu.cn/kernel.org/

### 使用

本工具可手动调用`kernel_org_mirror`启动，如需自动运行,请确保先导入了HEnvBox的配置文件。

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

注:本地程序表示需要从网络上下载到本地安装的程序，tools目录为自带工具或者工具安装资源。

# 脚本说明

## Windows

- config.bat：在cmd窗口中使用`call config.bat路径 `可配置环境。
- install.bat：安装或者更新软件包,可多次调用，为防止异常不要同时执行多个实例。
- upgrade.bat：更新软件包,可多次调用。
- uninstall.bat:卸载安装，主要用于删除右键信息

## Ubuntu

- config.sh：在bash中使用`. config.bat路径 `可配置环境。
- install.sh：安装或者更新软件包,可多次调用，为防止异常不要同时执行多个实例。
- upgrade.sh：更新软件包,可多次调用。
- uninstall.sh:卸载安装，主要用于删除.bashrc信息。注意:为保证系统稳定性，不会删除已安装的软件包。

# 安装

## Windows

保证目录可写（可参考MSYS2对目录的要求），确保安装路径中没有空格与中文。

以管理员权限执行install.bat,等待安装完成。

完成后可在目录的右键菜单中找到HEnvBox选项。在需要使用各种MSYS2中的工具时可使用右键菜单打开HEnvBox。

## Ubuntu

使用具有管理员权限的账户(可使用sudo提权)执行install.sh,等待安装完成,期间可能要求输入用户密码。

# 使用

## Windows

- 默认情况下，使用Msys2的UCRT64环境。如需编译32位应用，可使用Msys2的MINGW32环境(由于较多应用停止支持32位，因此此环境可能功能不全)。
- 如需保持工具的更新，请定期执行更新脚本，若太长时间（如几个月）不更新，可能因为GPG签名过期而无法更新。