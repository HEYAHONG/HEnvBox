#/bin/bash

#检查是否在HEnvBox中
[ -d "${HENVBOX_ROOT_PATH}" ] || exit 1

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

#进入当前目录
pushd ${script_dir}

#进行编译
make -f crosstool-ng.mk install
MAKE_ERRNO=$?

#退出目录
popd

#提示是否成功
if [ "${MAKE_ERRNO}" -eq "0" ]
then
	echo 编译成功！
else
	echo 编译失败！请手动重新调用安装脚本！
fi

#正常退出
exit 0
