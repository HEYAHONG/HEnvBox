#!/bin/bash

#shellcheck disable=SC2128  # ignore array expansion warning
if [ -n "${BASH_SOURCE-}" ]
then
	self_path="${BASH_SOURCE}"
elif [ -n "${ZSH_VERSION-}" ]
then
	self_path="${(%):-%x}"
else
	exit 1
fi

# shellcheck disable=SC2169,SC2169,SC2039  # unreachable with 'dash'
if [[ "$OSTYPE" == "darwin"* ]]; then
	# convert possibly relative path to absolute
	script_dir="$(realpath_int "${self_path}")"
	# resolve any ../ references to make the path shorter
	script_dir="$(cd "${script_dir}" || exit 1; pwd)"
else
	# convert to full path and get the directory name of that
	script_name="$(readlink -f "${self_path}")"
	script_dir="$(dirname "${script_name}")"
fi

#导出HENVBOX_COMMON根路径
export HENVBOX_COMMON_ROOT_PATH="${script_dir}";

#若含有:号，去除:号
if [ -n `echo ${HENVBOX_COMMON_ROOT_PATH} | grep ':'` ]
then
	export HENVBOX_COMMON_ROOT_PATH=/${HENVBOX_COMMON_ROOT_PATH//\:/\/}
	export HENVBOX_COMMON_ROOT_PATH=`realpath ${HENVBOX_COMMON_ROOT_PATH} 2>/dev/null`
fi

#设置PATH
if [ -d "${HENVBOX_COMMON_ROOT_PATH}/bin" ]
then
	export PATH="${HENVBOX_COMMON_ROOT_PATH}/bin":${PATH}
fi

#设置Makefile的包含目录
export MAKEFILE_INCLUDE_DIR="`realpath "${HENVBOX_COMMON_ROOT_PATH}/include/Makefile/"`"

#设置中国境内的repo url
export REPO_URL='https://gerrit-googlesource.proxy.ustclug.org/git-repo'
