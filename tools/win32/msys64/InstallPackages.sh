#!/bin/bash


#复制相关文件
cp -rf root/* /

#更新软件包
pacman -Syu --quiet --noconfirm

#执行子文件夹中的PreInstall.sh
for i in `find . -name PreInstall.sh`
do
	if [ -x  $i ]
	then
		. $i
	fi
done

#安装列表中的软件包
for list_file in `find . -name Packages.list`
do
	for i in `cat ${list_file}`
	do
		pacman -Q $i
		if [ $? -ne 0 ]
		then
			pacman -S --quiet --overwrite='*' --noconfirm $i
		fi
	done
done

#创建列表中的重定向入口
for list_file in `find . -name Win32Redirector.list`
do
	for i in `cat ${list_file}`
	do
        	cp -rf  "Win32Redirector.exe"  "${HENVBOX_LOCAL_BINDIR_PATH_UNIX}/$i"
	done
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

#执行子文件夹中的PostInstall.sh
for i in `find . -name PostInstall.sh`
do
        if [ -x  $i ]
        then
                . $i
        fi
done


#提示安装完成

echo  安装完成!
read -t 5
