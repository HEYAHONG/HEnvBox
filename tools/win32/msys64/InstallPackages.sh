#!/bin/bash

#由安装脚本加载Kconfig配置
if [ -f "${HENVBOX_TOOLS_PATH}/.config" ]
then
        . "${HENVBOX_TOOLS_PATH}/.config"
fi

#加载安装sh脚本
if [ -f "${HENVBOX_TOOLS_PATH}/install.sh" ]
then
        . "${HENVBOX_TOOLS_PATH}/install.sh"
fi


#复制相关文件
cp -rf root/* /

#更新软件包
pacman -Syu --quiet --noconfirm  --overwrite='*'

#执行子文件夹中的PreInstall.sh
for i in `find . -name PreInstall.sh`
do
	if [ -x  $i ]
	then
		echo execute $i
		. $i
	fi
done

#安装列表中的软件包
for list_file in `find . -name Packages.list`
do
	pacman -Q | awk '{print $1}' 2> /dev/null > /tmp/InstalledList.txt
	echo install package list ${list_file}
	for i in `cat ${list_file}`
	do
		echo install package $i
		PackageName=`cat /tmp/InstalledList.txt |grep -w "^$i$"`
		if [ -z "${PackageName}" ]
		then
			pacman -Q $i 2> /dev/null > /dev/null
			if [ $? -ne 0 ]
			then
				pacman -S --quiet --overwrite='*' --noconfirm $i
			fi
		fi
	done
done

#执行子文件夹中的PostInstall.sh
for i in `find . -name PostInstall.sh`
do
        if [ -x  $i ]
        then
                echo execute $i
                . $i
        fi
done


#创建列表中的重定向入口
for list_file in `find . -name Win32Redirector.list`
do
	echo install Win32Redirector list ${list_file}
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
	echo install Win32Redirector for $i
	cp -rf  "Win32Redirector.exe"  "${HENVBOX_LOCAL_BINDIR_PATH_UNIX}/$i"
done

#创建bat到msys2的入口
for list_file in `find . -name BatToMsys2.list`
do
        echo install BatEntry list ${list_file}
        for i in `cat ${list_file}`
        do
		if [ -x /usr/bin/$i ]
		then
			echo install BatToMsys2 for $i
                	echo @"${HENVBOX_LOCAL_ROOT_PATH}\\${HENVBOX_TOOLS_TYPE}\\msys2.exe" $i %* >  "${HENVBOX_LOCAL_BINDIR_PATH_UNIX}/$i.bat"
		fi
        done
done


#创建console入口
echo \#!/bin/bash > /console
for i in `env |grep HENVBOX`
do
	echo export ${i//\\/\/} >> /console
done
echo exec /bin/bash >> /console 
chmod +x /console

#提示安装完成

echo  安装完成!
read -t 5
