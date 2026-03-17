#/bin/bash

#检查是否在HEnvBox中
[ -d "${HENVBOX_ROOT_PATH}" ] || exit 1

# 检查msys64
[ -d "${HENVBOX_LOCAL_ROOT_PATH_UNIX}/msys64/${MSYSTEM_PREFIX}/" ] || exit 1

if [ -n "${MINGW_PREFIX}" ] ; then
	export HTOOLS_INSTALL_ROOT="${HENVBOX_LOCAL_ROOT_PATH_UNIX}/msys64/${MSYSTEM_PREFIX}/"
else
	export HTOOLS_INSTALL_ROOT="${MSYSTEM_PREFIX}/"
fi
echo HTOOLS_INSTALL_ROOT:${HTOOLS_INSTALL_ROOT}

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

if [ -d "${HENVBOX_COMMON_ROOT_PATH}/../htools/" ] ; then
	mkdir -p ${script_dir}/local/build/
	cmake -DHTOOLS_INSTALL_DIR="${HTOOLS_INSTALL_ROOT}/"  -B "${script_dir}/local/build/${MSYSTEM_PREFIX}/" -S "${HENVBOX_COMMON_ROOT_PATH}/../htools/" && cmake --build "${script_dir}/local/build/${MSYSTEM_PREFIX}/" -t htools
	rm -rf ${script_dir}/local/build/
fi

#退出目录
popd


