# top.mk
# 必须在具体Makefile顶部使用include ${MAKEFILE_INCLUDE_DIR}/top.mk
# 对于一个软件的编译安装，主要定义以下目标：
# 	1.prepare：准备目录，准备环境变量。
#	2.download:下载源代码（若需要）。
#	3.configure:使用构建系统/构建工具配置源代码（若需要）。
#	4.build:构建。
#	5.install:安装。
# 其它目标：
#	- all:默认目标，默认为build。
#	- clean:清理目标文件（通常是构建过程中的临时文件）。
#	- dist-clean:清理所有非发行所需文件，例如：对于需要下载源代码的软件，需要删除下载的源代码。
# 当需要对某个目标添加指令，只需要创建一个临时目标并将临时目标添加至相应的目标的依赖,并在临时目标的依赖中添加上一个编译安装目标（如有，如目标为build的临时目标应当将configure作为依赖）。

#伪目标
.PHONY:all prepare download configure build install clean

#默认采用build
all:build

prepare:
	@echo prepare done!

download:prepare
	@echo download done!

configure:download
	@echo configure done!

build:configure
	@echo build done!

install:build
	@echo install done!

clean:
	@echo clean done!

dist-clean:
	@echo dist-clean done!

include ${MAKEFILE_INCLUDE_DIR}/prepare-env.mk
include ${MAKEFILE_INCLUDE_DIR}/prepare-dir.mk


