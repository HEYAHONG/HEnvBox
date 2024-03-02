#!/bin/bash

#添加其它软件(如ct-ng编译的交叉编译工具链)
if [ -d ${MSYSTEM_PREFIX} ]
then
	for bin in `find ${MSYSTEM_PREFIX}/crosstool-ng -mindepth 2 -maxdepth 2 -type d -name bin 2>/dev/null`
	do
		export PATH=${bin}:${PATH}
	done
fi

#将Kconfig配置转化为环境变量
if [ -f "${HENVBOX_TOOLS_PATH}/.config" ]
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
