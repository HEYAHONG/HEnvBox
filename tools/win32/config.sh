#!/bin/bash

#将Kconfig配置转化为环境变量
if [ -f "${HENVBOX_TOOLS_PATH}/.config" ]
then
        for i in `cat "${HENVBOX_TOOLS_PATH}/.config" | grep -v \#`
	do
		#导出环境变量
		export ${i}
	done
fi

