# gitee_com_mirror

备份gitee.com的用户、组织或企业的公开仓库的工具。

可用于在线软件的实现，即在gitee.com上创建一个组织放在线软件包,再使用此工具同步。

## 运行环境

本工具需要在已安装好HEnvBox的环境下运行。具体运行环境要求如下:

- Bash (Linux)
- MSYS2 UCRT64 (64位Windows)
- MSYS2 MINGW32 （32位Windows）

## 配置

本工具通过文件进行配置，工具根目录为 `本地程序根路径/gitee.com`，所有文件均需放置此目录。

具体配置文件如下:

- config.sh:配置文件，一般用于声明变量。
- user.list:用户列表,每行表示一个用户。
- org.list:组织列表,每行表示一个组织
- enterprise.list:企业列表，每行表示一个企业。

#### config.sh

本配置文件为bash脚本文件，可用于配置一些变量:

- REPO_USE_SSH:当此变量非空时表示使用ssh备份,需要先手动配置ssh,即确保可使用`git clone`通过ssh备份。
- GITEE_COM_ACCESS_TOKEN：gitee.com私人令牌，配置好私人令牌可避免一些速率限制(尤其是多人共享一个公网IP上网时)。

## 使用

本工具可手动调用`gitee_com_mirror`启动，如需自动运行,请确保先导入了HEnvBox的配置文件。

除了通过配置用户、组织或企业的列表备份相应文件，也支持用户直接将仓库(非bare仓库,仓库目录不能含有空格)放在工具根目录下,启动工具后会自动更新仓库。

# github_com_mirror

备份github.com的用户或组织的公开仓库的工具。

可用于在线软件的实现，即在github.com上创建一个组织放在线软件包,再使用此工具同步。

## 运行环境

本工具需要在已安装好HEnvBox的环境下运行。具体运行环境要求如下:

- Bash (Linux)
- MSYS2 UCRT64 (64位Windows)
- MSYS2 MINGW32 （32位Windows）

## 配置

本工具通过文件进行配置，工具根目录为 `本地程序根路径/github.com`，所有文件均需放置此目录。

具体配置文件如下:

- config.sh:配置文件，一般用于声明变量。
- user.list:用户列表,每行表示一个用户。
- org.list:组织列表,每行表示一个组织

#### config.sh

本配置文件为bash脚本文件，可用于配置一些变量:

- REPO_USE_SSH:当此变量非空时表示使用ssh备份,需要先手动配置ssh,即确保可使用`git clone`通过ssh备份。

## 使用

本工具可手动调用`github_com_mirror`启动，如需自动运行,请确保先导入了HEnvBox的配置文件。

除了通过配置用户、组织的列表备份相应文件，也支持用户直接将仓库(非bare仓库,仓库目录不能含有空格)放在工具根目录下,启动工具后会自动更新仓库。

注意:由于国内github.com连接不稳定，建议配置好git的代理上网与系统代理上网再使用此工具同步。

# gitea_mirror

备份使用[gitea](https://www.gitea.com)自建站的用户或组织的公开仓库的工具。

可用于在线软件的实现，即在使用[gitea](https://www.gitea.com)自建的站点上创建一个组织放在线软件包,再使用此工具同步。

## 运行环境

本工具需要在已安装好HEnvBox的环境下运行。具体运行环境要求如下:

- Bash (Linux)
- MSYS2 UCRT64 (64位Windows)
- MSYS2 MINGW32 （32位Windows）

## 配置

本工具通过文件进行配置，工具根目录为 `本地程序根路径/gitea`，所有文件均需放置此目录。

具体配置文件如下:

- config.sh:配置文件，一般用于声明变量。
- site.list:站点列表，每行一个站点，每个站点的站点目录为站点URL去掉/并使用_替换:后的字符串，如[http://gitea.hyhsystem.cn:3000/](http://gitea.hyhsystem.cn:3000/)的站点目录为http_gitea.hyhsystem.cn_3000。
- [站点目录]/user.list:用户列表,每行表示一个用户。
- [站点目录]/org.list:组织列表,每行表示一个组织

#### config.sh

本配置文件为bash脚本文件，可用于配置一些变量:

- REPO_USE_SSH:当此变量非空时表示使用ssh备份,需要先手动配置ssh,即确保可使用`git clone`通过ssh备份。

## 使用

本工具可手动调用`gitea_mirror`启动，如需自动运行,请确保先导入了HEnvBox的配置文件。

除了通过配置用户、组织或企业的列表备份相应文件，也支持用户直接将仓库(非bare仓库,仓库目录不能含有空格)放在工具根目录下,启动工具后会自动更新仓库。

# ftp_gnu_org_mirror

下载(镜像)ftp.gnu.org的软件。将其下载到本地目录。

## 运行环境

本工具需要在已安装好HEnvBox的环境下运行。具体运行环境要求如下:

- Bash (Linux)
- MSYS2 UCRT64 (64位Windows)
- MSYS2 MINGW32 （32位Windows）

## 配置

本工具通过文件进行配置，工具根目录为 `本地程序根路径/ftp.gnu.org`，所有文件均需放置此目录。

具体配置文件如下:

- config.sh:配置文件，一般用于声明变量。
- dir.list:需要镜像的目录,每行表示一个,如下载nettle目录则为nettle。
- file.list:需要镜像的文件,每行表示一个,如下载gcc-13.2.0.tar.gz则为gcc/gcc-13.2.0/gcc-13.2.0.tar.gz。

#### config.sh

本配置文件为bash脚本文件，可用于配置一些变量:

- RSYNC_URL:rsync网络镜像URL。

RSYNC_URL一般可选择以下选项:

- rsync://ftp.gnu.org/gnu/
- rsync://rsync.mirrors.ustc.edu.cn/gnu/
- rsync://mirrors.tuna.tsinghua.edu.cn/gnu/

## 使用

本工具可手动调用`ftp_gnu_org_mirror`启动，如需自动运行,请确保先导入了HEnvBox的配置文件。

# kernel_org_mirror

下载(镜像)kernel.org的软件。将其下载到本地目录。

## 运行环境

本工具需要在已安装好HEnvBox的环境下运行。具体运行环境要求如下:

- Bash (Linux)
- MSYS2 UCRT64 (64位Windows)
- MSYS2 MINGW32 （32位Windows）

## 配置

本工具通过文件进行配置，工具根目录为 `本地程序根路径/kernel.org`，所有文件均需放置此目录。

具体配置文件如下:

- config.sh:配置文件，一般用于声明变量。
- dir.list:需要镜像的目录,每行表示一个,如下载software目录则为software。
- file.list:需要镜像的文件,每行表示一个,如下载linux-6.5.tar.xz则为linux/kernel/v6.x/linux-6.5.tar.xz。

#### config.sh

本配置文件为bash脚本文件，可用于配置一些变量:

- RSYNC_URL:rsync网络镜像URL。

RSYNC_URL一般可选择以下选项:

- rsync://rsync.kernel.org/pub/
- rsync://rsync.mirrors.ustc.edu.cn/kernel.org/

## 使用

本工具可手动调用`kernel_org_mirror`启动，如需自动运行,请确保先导入了HEnvBox的配置文件。
