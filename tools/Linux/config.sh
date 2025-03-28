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
        export HENVBOX_TOOLS_PATH="${script_dir}";

        #导出类型
        export HENVBOX_TOOLS_TYPE="common"

	CheckTool apt
	if [ $? -eq 0 ]
	then
		export HENVBOX_TOOLS_TYPE="apt"
	fi

	#加载.config
	if [ -f  "${HENVBOX_TOOLS_PATH}/.config" ]
	then
		for i in `cat "${HENVBOX_TOOLS_PATH}/.config" | grep -v '^#'`
		do
			#导出环境变量
			export ${i}
		done
	fi

	#导入common脚本
	if [ -f "${HENVBOX_TOOLS_PATH}/../common/export.sh" ]
	then
		. "${HENVBOX_TOOLS_PATH}/../common/export.sh"
	fi

        #导入其它配置脚本
        if [ -x "${HENVBOX_TOOLS_PATH}/${HENVBOX_TOOLS_TYPE}/config.sh" ]
        then
                . "${HENVBOX_TOOLS_PATH}/${HENVBOX_TOOLS_TYPE}/config.sh"
        fi

	#RT-Thread 相关环境变量
	which arm-none-eabi-gcc 2> /dev/null >/dev/null
	[ $? -ne 0 ] || export RTT_CC=gcc
	if [ -n "${RTT_CC}" ]
	then
		export RTT_EXEC_PATH=`which arm-none-eabi-gcc | xargs dirname`
	fi

else
        echo 无法完成HEnvBox配置!
fi
