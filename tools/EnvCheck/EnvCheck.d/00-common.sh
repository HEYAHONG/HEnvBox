#!/bin/bash

#打印EnvCheck日志,格式同printf命令
function EnvCheckLog {
	if [ "${CONFIG_DISABLE_ENVCHECK_LOG}" = "y" ]; then
		return 0
	fi
	if [ -z "$*" ]; then
		return 1
	fi
	local MSG
	printf -v MSG "$@" 2>/dev/null
	printf -v MSG '[EnvCheck] %s' "${MSG}" 2>/dev/null
	echo ${MSG}
	return 0
}

export -f EnvCheckLog

#测试程序(通过which测试)，参数1为程序名,整个参数应为显示版本的命令（若只有程序名，则默认添加--version获取版本）
#注意:
#	1.本函数不可用于不能通过CLI获取版本的程序（如某些GUI程序）
#	2.本函数仅可用于名称为字母及-的程序
#例如:
#	EnvCheckTestProgram gcc
#	EnvCheckTestProgram arm-none-eabi-gcc
#	EnvCheckTestProgram ct-ng version
#	EnvCheckTestProgram /bin/bash
function EnvCheckTestProgram {
	[ -n "$1" ] ||
		{
			return 255
		}
	ToolPath=$(which "$1" 2>/dev/null)
	[ -e "$ToolPath" ] ||
		{
			return 255
		}
	local PROGRAM_DIR
	local PROGRAM_NAME
	if [ "." = "$(dirname $1 2>/dev/null)" ]; then
		PROGRAM_NAME="$1"
	else
		PROGRAM_DIR="$(dirname "$1" 2>/dev/null)"
		PROGRAM_NAME="$(realpath --relative-base=${PROGRAM_DIR} "$1")"
	fi
	EnvCheckLog "Checking $1 name ${PROGRAM_NAME}!"
	local PROGRAM_VERSION_CMD
	if [ "$#" -gt 1 ]; then
		PROGRAM_VERSION_CMD="$@"
	else
		PROGRAM_VERSION_CMD="$1 --version"
	fi
	local PROGRAM_VERSION
	PROGRAM_VERSION=$(${PROGRAM_VERSION_CMD} | grep -Eo '[0-9]{1,9}(\.[0-9]{1,9}){1,9}' | awk 'NR==1{print}' 2>/dev/null)
	if [ -n "${PROGRAM_VERSION}" ]; then
		#环境变量不支持-+
		PROGRAM_NAME=$(echo ${PROGRAM_NAME} | tr - _)
		PROGRAM_NAME=$(echo ${PROGRAM_NAME} | tr + p)
		EnvCheckLog "\t${PROGRAM_NAME}_version=${PROGRAM_VERSION}"
		export ${PROGRAM_NAME}_version=${PROGRAM_VERSION}
		local PROGRAM_MAJOR_VERSION
		PROGRAM_MAJOR_VERSION=$(echo ${PROGRAM_VERSION} | grep -Eo '[0-9]{1,9}' | awk 'NR==1{print}' 2>/dev/null)
		if [ -n "${PROGRAM_MAJOR_VERSION}" ]; then
			EnvCheckLog "\t${PROGRAM_NAME}_major_version=${PROGRAM_MAJOR_VERSION}"
			export ${PROGRAM_NAME}_major_version=${PROGRAM_MAJOR_VERSION}
		fi
		local PROGRAM_MINOR_VERSION
		PROGRAM_MINOR_VERSION=$(echo ${PROGRAM_VERSION} | grep -Eo '[0-9]{1,9}' | awk 'NR==2{print}' 2>/dev/null)
		if [ -n "${PROGRAM_MINOR_VERSION}" ]; then
			EnvCheckLog "\t${PROGRAM_NAME}_minor_version=${PROGRAM_MINOR_VERSION}"
			export ${PROGRAM_NAME}_minor_version=${PROGRAM_MINOR_VERSION}
		fi
		local PROGRAM_REVISION_VERSION
		PROGRAM_REVISION_VERSION=$(echo ${PROGRAM_VERSION} | grep -Eo '[0-9]{1,9}' | awk 'NR==3{print}' 2>/dev/null)
		if [ -n "${PROGRAM_REVISION_VERSION}" ]; then
			EnvCheckLog "\t${PROGRAM_NAME}_revision_version=${PROGRAM_REVISION_VERSION}"
			export ${PROGRAM_NAME}_revision_version=${PROGRAM_REVISION_VERSION}
		fi
		local PROGRAM_BUILD_VERSION
		PROGRAM_BUILD_VERSION=$(echo ${PROGRAM_VERSION} | grep -Eo '[0-9]{1,9}' | awk 'NR==4{print}' 2>/dev/null)
		if [ -n "${PROGRAM_BUILD_VERSION}" ]; then
			EnvCheckLog "\t${PROGRAM_NAME}_build_version=${PROGRAM_BUILD_VERSION}"
			export ${PROGRAM_NAME}_build_version=${PROGRAM_BUILD_VERSION}
		fi
	fi

	return 0
}

export -f EnvCheckTestProgram
