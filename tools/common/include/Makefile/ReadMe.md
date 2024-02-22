# Makefile模板

## 使用

使用`include`包含相关mk文件(所在目录由MAKEFILE_INCLUDE_DIR环境变量)，具体要求：

- 文件顶部必须包含[top.mk](top.mk)。
- 文件底部必须包含[bottom.mk](bottom.mk)。
- 其它的mk由实际需求决定是否包含。

## 软件编译过程

本模板定义如下过程：

1. 准备
2. 下载
3. 配置
4. 构建
5. 安装

## 目标

- prepare:准备,具体可由prepare_step变量控制
- download :下载,具体可由download_step变量控制
- configure ：配置,具体可由configure_step变量控制

- build :构建,具体可由build_step变量控制

- install:安装,具体可由install_step变量控制

- clean:清理,具体可由clean_step变量控制

- dist-clean:发行版清理,具体可由dist-clean_step变量控制

## 示例Makefile

### 测试基本结构

```Makefile
include ${MAKEFILE_INCLUDE_DIR}/top.mk


prepare_step_1:
	@echo prepare_step_1

prepare_step_2:
	@echo prepare_step_2

prepare_step+=prepare_step_1 prepare_step_2

download_step_1:
	@echo download_step_1

download_step_2:
	@echo download_step_2

download_step+=download_step_1 download_step_2

configure_step_1:
	@echo configure_step_1

configure_step+=configure_step_1

build_step_1:
	@echo build_step_1

build_step+=build_step_1

install_step_1:
	@echo install_step_1

install_step+=install_step_1

clean_step_1:
	@echo clean_step_1
        
clean_step+=clean_step_1

dist-clean_step_1:
	@echo dist-clean_step_1

dist-clean_step+=dist-clean_step_1

include ${MAKEFILE_INCLUDE_DIR}/bottom.mk
```

### 测试子文件包含

**Makefile**:

```makefile
include ${MAKEFILE_INCLUDE_DIR}/top.mk

#包含include中的subdir.mk(默认文件名)文件
$(eval $(call IncludeSubdirMakefile,include))

#包含include中的subdir1.mk文件
$(eval $(call IncludeSubdirMakefile,include,subdir1.mk))

prepare_step_1:
	@echo prepare_step_1

prepare_step_2:
	@echo prepare_step_2

prepare_step+=prepare_step_1 prepare_step_2

download_step_1:
	@echo download_step_1

download_step_2:
	@echo download_step_2

download_step+=download_step_1 download_step_2

configure_step_1:
	@echo configure_step_1

configure_step+=configure_step_1

build_step_1:
	@echo build_step_1

build_step+=build_step_1

install_step_1:
	@echo install_step_1

install_step+=install_step_1

clean_step_1:
	@echo clean_step_1

clean_step+=clean_step_1

dist-clean_step_1:
	@echo dist-clean_step_1

dist-clean_step+=dist-clean_step_1

include ${MAKEFILE_INCLUDE_DIR}/bottom.mk

```

**include/subdir.mk**:

```makefile


prepare_subdir_mk_step_1:
	@echo prepare_subdir_mk_step_1

prepare_subdir_mk_step_2:
	@echo prepare_subdir_mk_step_2

prepare_step+=prepare_subdir_mk_step_1 prepare_subdir_mk_step_2

download_subdir_mk_step_1:
	@echo download_subdir_mk_step_1

download_subdir_mk_step_2:
	@echo download_subdir_mk_step_2

download_step+=download_subdir_mk_step_1 download_subdir_mk_step_2

configure_subdir_mk_step_1:
	@echo configure_subdir_mk_step_1

configure_step+=configure_subdir_mk_step_1

build_subdir_mk_step_1:
	@echo build_subdir_mk_step_1

build_step+=build_subdir_mk_step_1

install_subdir_mk_step_1:
	@echo install_subdir_mk_step_1

install_step+=install_subdir_mk_step_1

clean_subdir_mk_step_1:
	@echo clean_subdir_mk_step_1

clean_step+=clean_subdir_mk_step_1

dist-clean_subdir_mk_step_1:
	@echo dist-clean_subdir_mk_step_1

dist-clean_step+=dist-clean_subdir_mk_step_1
```

**include/subdir1.mk**:

```makefile


prepare_subdir1_mk_step_1:
	@echo prepare_subdir1_mk_step_1

prepare_subdir1_mk_step_2:
	@echo prepare_subdir1_mk_step_2

prepare_step+=prepare_subdir1_mk_step_1 prepare_subdir1_mk_step_2

download_subdir1_mk_step_1:
	@echo download_subdir1_mk_step_1

download_subdir1_mk_step_2:
	@echo download_subdir1_mk_step_2

download_step+=download_subdir1_mk_step_1 download_subdir1_mk_step_2

configure_subdir1_mk_step_1:
	@echo configure_subdir1_mk_step_1

configure_step+=configure_subdir1_mk_step_1

build_subdir1_mk_step_1:
	@echo build_subdir1_mk_step_1

build_step+=build_subdir1_mk_step_1

install_subdir1_mk_step_1:
	@echo install_subdir1_mk_step_1

install_step+=install_subdir1_mk_step_1

clean_subdir1_mk_step_1:
	@echo clean_subdir1_mk_step_1

clean_step+=clean_subdir1_mk_step_1

dist-clean_subdir1_mk_step_1:
	@echo dist-clean_subdir1_mk_step_1

dist-clean_step+=dist-clean_subdir1_mk_step_1

```

