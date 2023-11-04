#!/bin/bash


#复制相关文件
cp -rf root/* /

#更新软件包
pacman -Syu --quiet --noconfirm

#安装列表中的软件包
for i in `cat Packages.list`
do
	pacman -Q $i
	if [ $? -ne 0 ]
	then
		pacman -S --quiet --overwrite='*' --noconfirm $i
	fi
done

#创建列表中的重定向入口
for i in `cat Win32Redirector.list`
do
        cp -rf  "Win32Redirector.exe"  "${HENVBOX_LOCAL_BINDIR_PATH_UNIX}/$i"
done

#创建重定向入口
export ScriptDir=`pwd`
chmod -R 755 ${HENVBOX_LOCAL_BINDIR_PATH_UNIX}/
mkdir -p     ${HENVBOX_LOCAL_BINDIR_PATH_UNIX}/
cd /bin
for i in `ls *.exe`
do
	cd ${ScriptDir}
	cp -rf  "Win32Redirector.exe"  "${HENVBOX_LOCAL_BINDIR_PATH_UNIX}/$i"
done
