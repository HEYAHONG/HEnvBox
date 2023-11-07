#!/bin/bash

self_path=""
# shellcheck disable=SC2128  # ignore array expansion warning
if [ -n "${BASH_SOURCE-}" ]
then
	self_path="${BASH_SOURCE}"
elif [ -n "${ZSH_VERSION-}" ]
then
	self_path="${(%):-%x}"
else
	echo -e "\033[41;37m不能获取工作目录\033[40;37m";
	return 1
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

export SCRIPT_DIR="${script_dir}";


export PIP_PATH=`which pip 2> /dev/null`
if [ -n "${PIP_PATH}" ]
then
	${PIP_PATH} install -U pip
	${PIP_PATH} install -r ${SCRIPT_DIR}/requirement.txt
fi
