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

#apt安装过程中不询问
export DEBIAN_FRONTEND=noninteractive

if [ -f /etc/lsb-release ]
then
	. /etc/lsb-release
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
