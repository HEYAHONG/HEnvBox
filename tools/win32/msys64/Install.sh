#!/bin/bash

#执行安装软件包脚本
./InstallPackages.sh

#错误后重试
if [ "$?" -ne "0" ]
then
	exec "$0" "$@"
fi
