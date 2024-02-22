include ${MAKEFILE_INCLUDE_DIR}/top.mk

#包含subdir中的subdir.mk(默认文件名)文件
$(eval $(call IncludeSubdirMakefile,include))

#包含subdir中的subdir1.mk文件
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
