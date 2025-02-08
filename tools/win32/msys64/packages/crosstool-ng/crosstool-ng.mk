include ${MAKEFILE_INCLUDE_DIR}/top.mk

HENVBOX_LOCAL_SRC_PATH      ?=  ${HENVBOX_LOCAL_ROOT_PATH}/src/
CROSSTOOL_NG_LOCAL_SRC_PATH ?=  ${HENVBOX_LOCAL_SRC_PATH}/crosstool-ng-git
CROSSTOOL_NG_LOCAL_SRC_URL  ?=  https://github.com/crosstool-ng/crosstool-ng.git

.PHONY: prepare_dir download_git_repository configure_ct_ng build_ct_ng install_ct_ng clean_ct_ng

prepare_dir:
	mkdir -p ${CROSSTOOL_NG_LOCAL_SRC_PATH}

prepare_step	+= prepare_dir


download_git_repository:
	if [ ! -e ${CROSSTOOL_NG_LOCAL_SRC_PATH}/.git/config ]; then cd "${CROSSTOOL_NG_LOCAL_SRC_PATH}" && git init && git remote add origin ${CROSSTOOL_NG_LOCAL_SRC_URL}; fi;
	cd "${CROSSTOOL_NG_LOCAL_SRC_PATH}" && git fetch && git checkout -f master && git pull

download_step 	+= download_git_repository

configure_ct_ng:
	cd "${CROSSTOOL_NG_LOCAL_SRC_PATH}" && ${CROSSTOOL_NG_LOCAL_SRC_PATH}/bootstrap;
	cd "${CROSSTOOL_NG_LOCAL_SRC_PATH}" && ${CROSSTOOL_NG_LOCAL_SRC_PATH}/configure;

configure_step+= configure_ct_ng

build_ct_ng:
	cd "${CROSSTOOL_NG_LOCAL_SRC_PATH}" && ${MAKE}

build_step+= build_ct_ng

install_ct_ng:
	cd "${CROSSTOOL_NG_LOCAL_SRC_PATH}" && ${MAKE} install

install_step+= install_ct_ng

clean_ct_ng:
	cd "${CROSSTOOL_NG_LOCAL_SRC_PATH}" && git clean -x -f -d

clean_step+= clean_ct_ng


include ${MAKEFILE_INCLUDE_DIR}/bottom.mk
