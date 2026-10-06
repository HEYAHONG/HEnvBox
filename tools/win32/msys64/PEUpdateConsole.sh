#!/bin/bash

#判断是否处于HEnvBox中
if [ -d "${HENVBOX_ROOT_PATH}" ]; then
	echo HEnvBox:${HENVBOX_ROOT_PATH}
else
	#当非特权程序启动此脚本（要求特权）时，不会传递环境变量，不可继续安装脚本.
	echo HEnvBox未找到，请使用管理员权限运行.
	read -t 5
	exit 0
fi

#加载config.sh
if [ -f "${HENVBOX_TOOLS_PATH}/config.sh" ]; then
	. "${HENVBOX_TOOLS_PATH}/config.sh"
fi

#创建console入口
echo \#!/bin/bash >/console
for i in $(env | grep '^HENVBOX'); do
	#导出环境变量(HEnvBox)
	echo export ${i//\\/\/} >>/console
done
cat >>/console <<-EOF
	#导入config.sh
	if [ -f "\${HENVBOX_TOOLS_PATH}/config.sh" ]
	then
	        .   "\${HENVBOX_TOOLS_PATH}/config.sh"
	fi
	#执行新的bash
	exec /bin/bash \$@
EOF
chmod +x /console


#正常退出
exit 0
