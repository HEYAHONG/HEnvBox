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

#导出是否重复加载
if [ -d "${ENVCHECK_ROOT_PATH}" ]
then
	#指示是否重复加载
	export  ENVCHECK_REPEAT_LOAD=1
fi

#导出EnvCheck根路径
export ENVCHECK_ROOT_PATH="${script_dir}";

#导入EnvCheck.d中的脚本
for script_path in `ls ${ENVCHECK_ROOT_PATH}/EnvCheck.d/*.sh`
do
	if [ -f ${script_path} ]
	then
		. ${script_path}
	fi
done



