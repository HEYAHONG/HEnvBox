# bottom.mk
# 必须在具体Makefile底部使用include ${MAKEFILE_INCLUDE_DIR}/bottom.mk

#设定目标的单个依赖,参数1为目标，参数2为依赖
define BottomMKSetTargetDepend

$(1):$(2)

endef

#将相应目标的步骤添加至相应目标
ifneq (${prepare_step},)

prepare:${prepare_step}

endif
ifneq (${download_step},)

download:${download_step}

$(foreach step,${download_step},$(BottomMKSetTargetDepend ${step},prepare))

endif
ifneq (${configure_step},)

configure:${configure_step}

$(foreach step,${configure_step},$(BottomMKSetTargetDepend ${step},download))

endif

ifneq (${build_step},)

build:${build_step}

$(foreach step,${build_step},$(BottomMKSetTargetDepend ${step},configure))

endif
ifneq (${install_step},)

install:${install_step}

$(foreach step,${install_step},$(BottomMKSetTargetDepend ${step},build))

endif
ifneq (${clean_step},)

clean:${clean_step}

endif
ifneq (${dist-clean_step},)

dist-clean:${dist-clean_step}

endif

