# prepare-env.mk
# 由top.mk包含

#定义主机工具(默认主机上采用gcc)
HOSTCC          ?= cc
HOSTCXX         ?= c++

HOSTCFLAGS      := $(HOSTCFLAGS)
HOSTCXXFLAGS    := $(HOSTCXXFLAGS)
HOSTAFLAGS      := $(HOSTAFLAGS)
HOSTLDFLAGS     := $(HOSTLDFLAGS)

export HOSTCC HOSTCXX HOSTCFLAGS HOSTCXXFLAGS HOSTAFLAGS HOSTLDFLAGS

#定义工具链
ifeq (${CROSS_COMPILE},)

AS              ?= as
CC              ?= cc
CPP             ?= c++
CXX             ?= $(CPP)
LD              ?= $(CPP)
AR              ?= ar
NM              ?= nm
STRIP           ?= strip
OBJCOPY         ?= objcopy
OBJDUMP         ?= objdump
PKG_CONFIG      ?= pkg-config

CFLAGS          := $(CFLAGS)
CPPFLAGS        := $(CPPFLAGS)
AFLAGS          := $(AFLAGS)
LDFLAGS         := $(LDFLAGS)
LDLIBS          := $(LDLIBS)


else

AS              = $(CROSS_COMPILE)as
CC              = $(CROSS_COMPILE)gcc
CPP             = $(CROSS_COMPILE)g++
CXX             = $(CPP)
LD              = $(CPP)
AR              = $(CROSS_COMPILE)ar
NM              = $(CROSS_COMPILE)nm
STRIP           = $(CROSS_COMPILE)strip
OBJCOPY	        = $(CROSS_COMPILE)objcopy
OBJDUMP         = $(CROSS_COMPILE)objdump
PKG_CONFIG      ?= $(CROSS_COMPILE)pkg-config

CFLAGS          := $(CFLAGS)
CPPFLAGS        := $(CPPFLAGS)
AFLAGS          := $(AFLAGS)
LDFLAGS         := $(LDFLAGS)
LDLIBS          := $(LDLIBS)

endif

export AS CC CPP CXX LD AR NM STRIP OBJCOPY OBJDUMP PKG_CONFIG
export CFLAGS CPPFLAGS AFLAGS LDFLAGS LDLIBS


#定义各个目标的步骤,默认为空，但用户需要将实际步骤通过+=添加至相应步骤
prepare_step    :=
download_step   :=
configure_step  :=
build_step      :=
install_step    :=
clean_step      :=
dist-clean_step :=

#定义相关目录
PWD             := $(shell pwd)
MAKEFILE_DIR    ?= $(PWD)
##本地文件目录
LOCALDIR        ?= $(PWD)/local
##戳保存目录(戳用于保存make的进度，通常使用touch命令创建一个空文件,然后使用文件名获取进度)
STAMPDIR        ?= $(LOCALDIR)/stamp
##临时目录(保存flock命令的锁文件、下载的临时文件)
TEMPDIR         ?= $(LOCALDIR)/tmp
##源代码目录(注意:通常需要在其下创建子目录保存源代码并编译源代码)
SRCDIR          ?= $(LOCALDIR)/src
