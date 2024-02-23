
#显示当前文件
$(info current file is $(realpath ${file}))
#显示当前目录
$(info current dir is $(realpath $(dir ${file})))

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

