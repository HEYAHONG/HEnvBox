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

#加载卸载sh脚本
if [ -f "${HENVBOX_TOOLS_PATH}/uninstall.sh" ]; then
        . "${HENVBOX_TOOLS_PATH}/uninstall.sh"
fi

#执行子文件夹中的PreUnInstall.sh
for i in $(find . -name PreUnInstall.sh); do
        if [ -f $i ]; then
                echo execute $i
                . $i
        fi
done

#执行子文件夹中的PostUnInstall.sh
for i in $(find . -name PostUnInstall.sh); do
        if [ -f $i ]; then
                echo execute $i
                . $i
        fi
done

#提示卸载完成

echo 卸载完成!
read -t 5

#正常退出
exit 0

