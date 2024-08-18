# crosstool-ng

crosstool-ng是一款交叉编译工具链创建工具

对于比较流行的编译目标(如arm-none-eabi)的交叉编译工具链,各个系统厂商或者MSYS2官方可能会收录相关软件包。

若官方未收录或者期待使用较新的交叉编译工具链，可采用[crosstool-ng](http://crosstool-ng.org)编译。

## 运行环境

本工具需要在已安装好HEnvBox的环境下运行。具体运行环境要求如下:

- Bash (Linux)
- MSYS2 MSYS2 (Windows)

## 准备工作

- 必须有较为良好的网络链接，如有条件可配置代理上网。
- 对于Windows(Windows 10及更新版本)用户而言,MSYS2的crosstool-ng需要目录支持大小写，可在创建目录后使用`fsutil file setCaseSensitiveInfo 新创建的目录`创建一个支持大小写的NTFS目录后使用该目录编译。

## 交叉编译工具链(受crosstool-ng支持的)编译流程

- 准备一个文件夹，文件夹要支持大小写。文件夹所在磁盘剩余空间根据需要编译的目标而确定，推荐Windows上200G,Linux上100G。
- 使用`ct-ng list-samples`列出支持的范例，选择合适的范例，如过没有完全匹配的就选择相近的范例。
- 使用`ct-ng menuconfig`进行Kconfig配置，此配置可修改生成的编译工具链的元组，如果上一步未选择到合适的范例可在此步选择。此步配置一些路径信息。
- 使用`ct_ng_path_patch`修改相关路径,这步的主要目的为将相关目录修改至HEnvBox目录，并非必须。
- 使用`ct-ng build`编译，期间可能遇到很多问题，如果是下载问题可尝试多次编译或者配置代理上网。
