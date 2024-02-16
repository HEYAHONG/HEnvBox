#!/bin/bash

#打印EnvCheck日志,格式同printf命令
function EnvCheckLog
{
	if [ "${CONFIG_DISABLE_ENVCHECK_LOG}" = "y" ]
	then
		return 0
	fi
	if [ -z "$*" ]
	then
		return 1
	fi
	local MSG
	printf -v MSG "$@" 2> /dev/null
	printf -v MSG '[EnvCheck] %s' "${MSG}" 2> /dev/null
	echo  ${MSG}
	return 0
}

export -f EnvCheckLog

#测试程序(通过which测试)，参数1为程序名
function EnvCheckTestProgram
{
        [  -n "$1"  ] ||
        {
                return 255;
        };
        ToolPath=`which $1 2> /dev/null`;
        [ -e "$ToolPath" ] ||
        {
                 return 255;
        };
        return 0;
}

export -f EnvCheckTestProgram



