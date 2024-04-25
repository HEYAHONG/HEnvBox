#!/bin/bash
# shellcheck disable=SC2128  # ignore array expansion warning
if [ -n "${BASH_SOURCE-}" ]
then
self_path="${BASH_SOURCE}"
elif [ -n "${ZSH_VERSION-}" ]
then
self_path="${(%):-%x}"
else
      return 1
fi

# shellcheck disable=SC2169,SC2169,SC2039  # unreachable with 'dash'
if [[ "$OSTYPE" == "darwin"* ]]; then
	# convert possibly relative path to absolute
	script_dir="$(realpath_int "${self_path}")"
	# resolve any ../ references to make the path shorter
	script_dir="$(cd "${script_dir}" || exit 1; pwd)"
else
        # convert to full path and get the directory name of that
        script_name="$(readlink -f "${self_path}")"
        script_dir="$(dirname "${script_name}")"
fi

#导出根路径
export SCRIPT_DIR="${script_dir}";

#复制相关文件
cp -rf ${SCRIPT_DIR}/root/*  "${HENVBOX_LOCAL_ROOT_PATH}/"
for i in `find "${HENVBOX_LOCAL_ROOT_PATH}/bin" 2> /dev/null`
do
	if [ -e "${i}" ]
	then
		chown  ${HENVBOX_UID}:${HENVBOX_GID} "$i"
	fi
done
for i in `find "${HENVBOX_LOCAL_ROOT_PATH}/sbin" 2> /dev/null`
do
        if [ -e "${i}" ]
        then
                chown  ${HENVBOX_UID}:${HENVBOX_GID} "$i"
        fi
done
for i in `find "${HENVBOX_LOCAL_ROOT_PATH}/lib" 2> /dev/null`
do
        if [ -e "${i}" ]
        then
                chown  ${HENVBOX_UID}:${HENVBOX_GID} "$i"
        fi
done
for i in `find "${HENVBOX_LOCAL_ROOT_PATH}/etc" 2> /dev/null`
do
        if [ -e "${i}" ]
        then
                chown  ${HENVBOX_UID}:${HENVBOX_GID} "$i"
        fi
done
for i in `find "${HENVBOX_LOCAL_ROOT_PATH}/share" 2> /dev/null`
do
        if [ -e "${i}" ]
        then
                chown  ${HENVBOX_UID}:${HENVBOX_GID} "$i"
        fi
done



#准备工作
if [ -x ${SCRIPT_DIR}/Prepare.sh ]
then
	. ${SCRIPT_DIR}/Prepare.sh
fi

#apt安装过程中不询问
export DEBIAN_FRONTEND=noninteractive

if [ -f /etc/lsb-release ]
then
	. /etc/lsb-release
fi

if [ -f /etc/os-release ]
then
        . /etc/os-release
fi

if [ -z "${DISTRIB_CODENAME}" ]
then
	#使用VERSION_CODENAME作为DISTRIB_CODENAME
	DISTRIB_CODENAME=${VERSION_CODENAME}
fi


#更新软件包
dpkg --configure -a 2> /dev/null > /dev/null
apt update 2> /dev/null > /dev/null
apt install -f
apt upgrade -yyy

#执行子文件夹的PreInstall.sh
for i in  `find ${SCRIPT_DIR} -name PreInstall.sh`
do
	if [ -x $i ]
	then
		echo execute $i
		. $i
	fi
done

if [ -n "${DISTRIB_CODENAME}" ]
then
	#按发行版执行子文件夹的PreInstall.sh
	for i in  `find ${SCRIPT_DIR} -name PreInstall.${DISTRIB_CODENAME}.sh`
	do
        	if [ -x $i ]
        	then
                	echo execute $i
                	. $i
        	fi
	done
fi

#安装相应软件包
for list_file in `find ${SCRIPT_DIR} -name Packages.list`
do
	echo install packages list ${list_file}
	cat ${list_file} | xargs apt install -yyy
done

if [ -n "${DISTRIB_CODENAME}" ]
then
	#安装相应发行版软件包
	for list_file in `find ${SCRIPT_DIR} -name Packages.${DISTRIB_CODENAME}.list`
	do
        	echo install packages list ${list_file}
        	cat ${list_file} | xargs apt install -yyy
	done

	#安装snap软件
	SNAP_BIN=`which snap`
	if [ -x ${SNAP_BIN} ]
	then
		for list_file in `find ${SCRIPT_DIR} -name "Snap.${DISTRIB_CODENAME}.list"`
		do
			echo install snap list ${list_file}
			for SNAP in `cat ${list_file}`
			do
				${SNAP_BIN} list ${SNAP} 2>/dev/null 1>/dev/null
				if [ "$?" -eq "0" ]
				then
					echo ${SNAP} is installed!
				else
					${SNAP_BIN} install ${SNAP}
				fi
			done
		done
	fi
fi

#执行子文件夹的PostInstall.sh
for i in  `find ${SCRIPT_DIR} -name PostInstall.sh`
do
        if [ -x $i ]
        then
                echo execute $i
                . $i
        fi
done

if [ -n "${DISTRIB_CODENAME}" ]
then
	#按发行版执行子文件夹的PostInstall.sh
	for i in  `find ${SCRIPT_DIR} -name PostInstall.${DISTRIB_CODENAME}.sh`
	do
        	if [ -x $i ]
        	then
                	echo execute $i
                	. $i
        	fi
	done
fi
