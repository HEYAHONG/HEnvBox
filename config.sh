#!/bin/bash

function CheckTool
{
	[  -n "$1"  ] ||
	{
		echo -e  "CheckTool 参数错误!!";
		return 255;
	};
	ToolPath=`which $1`;
	[ -e "$ToolPath" ] ||
	{
		 echo -e "$1 不存在，请先安装此工具!!!";
		 return 255;
	};
	return 0;
}

export HENVBOX_UNSUPPORTED=0
CheckTool uname
[ $? -eq 0 ] || export HENVBOX_UNSUPPORTED=1
CheckTool find
[ $? -eq 0 ] || export HENVBOX_UNSUPPORTED=1
CheckTool dirname
[ $? -eq 0 ] || export HENVBOX_UNSUPPORTED=1
CheckTool readlink
[ $? -eq 0 ] || export HENVBOX_UNSUPPORTED=1
CheckTool ln
[ $? -eq 0 ] || export HENVBOX_UNSUPPORTED=1
CheckTool sed
[ $? -eq 0 ] || export HENVBOX_UNSUPPORTED=1
CheckTool grep
[ $? -eq 0 ] || export HENVBOX_UNSUPPORTED=1
CheckTool id
[ $? -eq 0 ] || export HENVBOX_UNSUPPORTED=1
CheckTool mkdir
[ $? -eq 0 ] || export HENVBOX_UNSUPPORTED=1
CheckTool xargs
[ $? -eq 0 ] || export HENVBOX_UNSUPPORTED=1
CheckTool sudo
[ $? -eq 0 ] || [ `id -u` -eq 0 ] ||  export HENVBOX_UNSUPPORTED=1

if [ ${HENVBOX_UNSUPPORTED} -ne 1 ]
then
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
	export HENVBOX_ROOT_PATH="${script_dir}";
	
	#导出类型
	export HENVBOX_TYPE=`uname -s`
	
	#导出uid与gid
	export HENVBOX_UID=`id -u`
	export HENVBOX_GID=`id -g`
	
	mkdir -p ${HENVBOX_ROOT_PATH}/local/bin
	export HENVBOX_LOCAL_ROOT_PATH=${HENVBOX_ROOT_PATH}/local/
	export HENVBOX_LOCAL_ROOT_PATH_UNIX=${HENVBOX_LOCAL_ROOT_PATH}
	export HENVBOX_LOCAL_BINDIR_PATH=${HENVBOX_ROOT_PATH}/local/bin
	export HENVBOX_LOCAL_BINDIR_PATH_UNIX=${HENVBOX_LOCAL_BINDIR_PATH}

	#设置PATH变量
	export PATH=${HENVBOX_LOCAL_BINDIR_PATH_UNIX}:$PATH

	#导入local目录下的其它软件(如ct-ng编译的交叉编译工具链)
	for bin in `find ${HENVBOX_LOCAL_ROOT_PATH_UNIX} -mindepth 2 -maxdepth 2 -type d -name bin 2> /dev/null`
	do
		export PATH=${bin}:$PATH
	done

	#导入tools中的配置脚本
	if [ -x "${HENVBOX_ROOT_PATH}/tools/${HENVBOX_TYPE}/config.sh" ]
	then
		. "${HENVBOX_ROOT_PATH}/tools/${HENVBOX_TYPE}/config.sh"
	fi
else
	echo 无法完成HEnvBox配置!
fi
