#!/bin/bash
# shellcheck disable=SC2128  # ignore array expansion warning
if [ -n "${BASH_SOURCE-}" ]
then
self_path="${BASH_SOURCE}"
elif [ -n "${ZSH_VERSION-}" ]
then
self_path="${(%):-%x}"
else
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

#导出根路径
export SCRIPT_DIR="${script_dir}";

#更新软件包
apt upgrade -yyy

#安装相应软件包
for list_file in `find ${SCRIPT_DIR} -name Packages.list`
do
	for i in `cat ${list_file}`
	do
		apt install -yyy $i
	done
done

