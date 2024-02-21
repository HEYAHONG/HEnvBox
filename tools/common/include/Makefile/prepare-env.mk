# prepare-env.mk
# 由top.mk包含

#定义主机工具(默认主机上采用gcc)
HOSTCC  	?= cc
HOSTCXX  	?= c++

HOSTCFLAGS	:= $(HOSTCFLAGS)
HOSTCXXFLAGS	:= $(HOSTCXXFLAGS)
HOSTAFLAGS	:= $(HOSTAFLAGS)
HOSTLDFLAGS	:= $(HOSTLDFLAGS)

export HOSTCC HOSTCXX HOSTCFLAGS HOSTCXXFLAGS HOSTAFLAGS HOSTLDFLAGS

#定义工具链
ifeq (${CROSS_COMPILE},)

AS              ?= as
CC              ?= cc
CPP             ?= c++
LD              ?= $(CPP)
AR              ?= ar
NM              ?= nm
STRIP           ?= strip
OBJCOPY         ?= objcopy
OBJDUMP         ?= objdump
PKG_CONFIG      ?= pkg-config

CFLAGS		:= $(CFLAGS)
CPPFLAGS	:= $(CPPFLAGS)
AFLAGS		:= $(AFLAGS)
LDFLAGS		:= $(LDFLAGS)
LDLIBS		:= $(LDLIBS)


else

AS		= $(CROSS_COMPILE)as
CC		= $(CROSS_COMPILE)gcc
CPP		= $(CROSS_COMPILE)g++
LD		= $(CPP)
AR		= $(CROSS_COMPILE)ar
NM		= $(CROSS_COMPILE)nm
STRIP		= $(CROSS_COMPILE)strip
OBJCOPY		= $(CROSS_COMPILE)objcopy
OBJDUMP		= $(CROSS_COMPILE)objdump
PKG_CONFIG	?= $(CROSS_COMPILE)pkg-config

CFLAGS          := $(CFLAGS)
CPPFLAGS        := $(CPPFLAGS)
AFLAGS          := $(AFLAGS)
LDFLAGS         := $(LDFLAGS)
LDLIBS          := $(LDLIBS)

endif

export AS CC CPP LD AR NM STRIP OBJCOPY OBJDUMP PKG_CONFIG
export CFLAGS CPPFLAGS AFLAGS LDFLAGS LDLIBS


#定义各个目标的步骤,默认为空，但用户需要将实际步骤通过+=添加至相应步骤
prepare_step:=
download_step:=
configure_step:=
build_step:=
install_step:=
clean_step:=
dist-clean_step:=
