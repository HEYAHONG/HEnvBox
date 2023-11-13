#/bin/bash

export CROSSTOOL_NG_URL=http://crosstool-ng.org/download/crosstool-ng/
export CROSSTOOL_NG_FILENAME=crosstool-ng-1.26.0.tar.xz
export CROSSTOOL_NG_DIRNAME=crosstool-ng-1.26.0
export CROSSTOOL_NG_LOCAL_SRC_PATH=${HENVBOX_LOCAL_SRC_PATH}/crosstool-ng/



function Download()
{
	mkdir -p ${CROSSTOOL_NG_LOCAL_SRC_PATH}
	pushd ${CROSSTOOL_NG_LOCAL_SRC_PATH}
	wget  --no-check-certificate -c -t 5 -O ${CROSSTOOL_NG_LOCAL_SRC_PATH}/${CROSSTOOL_NG_FILENAME} ${CROSSTOOL_NG_URL}/${CROSSTOOL_NG_FILENAME}
	wget  --no-check-certificate -c -t 5 -O ${CROSSTOOL_NG_LOCAL_SRC_PATH}/${CROSSTOOL_NG_FILENAME}.sha512 ${CROSSTOOL_NG_URL}/${CROSSTOOL_NG_FILENAME}.sha512
	[ -f ${CROSSTOOL_NG_LOCAL_SRC_PATH}/${CROSSTOOL_NG_FILENAME} ] && [ -f ${CROSSTOOL_NG_LOCAL_SRC_PATH}/${CROSSTOOL_NG_FILENAME}.sha512 ] && sha512sum -c ${CROSSTOOL_NG_LOCAL_SRC_PATH}/${CROSSTOOL_NG_FILENAME}.sha512 && touch ${HENVBOX_LOCAL_STAMP_PATH}/download.${CROSSTOOL_NG_FILENAME}
	popd 2> /dev/null >dev/null
}

[ -f ${HENVBOX_LOCAL_STAMP_PATH}/download.${CROSSTOOL_NG_FILENAME} ] || Download

function Compile()
{
	pushd ${CROSSTOOL_NG_LOCAL_SRC_PATH}
	[ -f ${HENVBOX_LOCAL_STAMP_PATH}/extract.${CROSSTOOL_NG_FILENAME} ] || tar -xvf ${CROSSTOOL_NG_FILENAME} 
	[ $? -eq 0 ] && touch ${HENVBOX_LOCAL_STAMP_PATH}/extract.${CROSSTOOL_NG_FILENAME}
	if [ -f ${HENVBOX_LOCAL_STAMP_PATH}/extract.${CROSSTOOL_NG_FILENAME} ]
	then
		pushd ${CROSSTOOL_NG_LOCAL_SRC_PATH}/${CROSSTOOL_NG_DIRNAME}
		./bootstrap
		./configure --prefix=${HENVBOX_LOCAL_ROOT_PATH}
		make install
		[ $? -eq 0 ] && touch ${HENVBOX_LOCAL_STAMP_PATH}/compile.${CROSSTOOL_NG_FILENAME}
		popd 2> /dev/null >dev/null
	fi
	popd 2> /dev/null >dev/null
}

[ -f ${HENVBOX_LOCAL_STAMP_PATH}/download.${CROSSTOOL_NG_FILENAME} ] && [ -f ${HENVBOX_LOCAL_STAMP_PATH}/compile.${CROSSTOOL_NG_FILENAME} ] ||  Compile
