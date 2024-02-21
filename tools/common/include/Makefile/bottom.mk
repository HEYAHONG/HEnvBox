# bottom.mk
# 必须在具体Makefile底部使用include ${MAKEFILE_INCLUDE_DIR}/bottom.mk

#将相应目标的步骤添加至相应目标
ifneq (${prepare_step},)

prepare:${prepare_step}

endif
ifneq (${download_step},)

download:${download_step}

endif
ifneq (${configure_step},)

configure:${configure_step}

endif

ifneq (${build_step},)

build:${build_step}

endif
ifneq (${install_step},)

install:${install_step}

endif
ifneq (${clean_step},)

clean:${clean_step}

endif
ifneq (${dist-clean_step},)

dist-clean:${dist-clean_step}

endif

