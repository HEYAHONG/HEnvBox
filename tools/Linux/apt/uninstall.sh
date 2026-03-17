#!/bin/bash
# shellcheck disable=SC2128  # ignore array expansion warning
if [ -n "${BASH_SOURCE-}" ]; then
	self_path="${BASH_SOURCE}"
elif [ -n "${ZSH_VERSION-}" ]; then
	self_path="${(%):-%x}"
else
	return 1
fi

# shellcheck disable=SC2169,SC2169,SC2039  # unreachable with 'dash'
if [[ "$OSTYPE" == "darwin"* ]]; then
	# convert possibly relative path to absolute
	script_dir="$(realpath_int "${self_path}")"
	# resolve any ../ references to make the path shorter
	script_dir="$(
		cd "${script_dir}" || exit 1
		pwd
	)"
else
	# convert to full path and get the directory name of that
	script_name="$(readlink -f "${self_path}")"
	script_dir="$(dirname "${script_name}")"
fi

#导出根路径
export SCRIPT_DIR="${script_dir}"

#复制相关文件
cp -rf ${SCRIPT_DIR}/root/* "${HENVBOX_LOCAL_ROOT_PATH}/"
for i in $(find "${HENVBOX_LOCAL_ROOT_PATH}/bin" 2>/dev/null); do
	if [ -e "${i}" ]; then
		chown ${HENVBOX_UID}:${HENVBOX_GID} "$i"
	fi
done
for i in $(find "${HENVBOX_LOCAL_ROOT_PATH}/sbin" 2>/dev/null); do
	if [ -e "${i}" ]; then
		chown ${HENVBOX_UID}:${HENVBOX_GID} "$i"
	fi
done
for i in $(find "${HENVBOX_LOCAL_ROOT_PATH}/lib" 2>/dev/null); do
	if [ -e "${i}" ]; then
		chown ${HENVBOX_UID}:${HENVBOX_GID} "$i"
	fi
done
for i in $(find "${HENVBOX_LOCAL_ROOT_PATH}/etc" 2>/dev/null); do
	if [ -e "${i}" ]; then
		chown ${HENVBOX_UID}:${HENVBOX_GID} "$i"
	fi
done
for i in $(find "${HENVBOX_LOCAL_ROOT_PATH}/share" 2>/dev/null); do
	if [ -e "${i}" ]; then
		chown ${HENVBOX_UID}:${HENVBOX_GID} "$i"
	fi
done

#准备工作
if [ -x ${SCRIPT_DIR}/Prepare.sh ]; then
	. ${SCRIPT_DIR}/Prepare.sh
fi


if [ -f /etc/lsb-release ]; then
	. /etc/lsb-release
fi

if [ -f /etc/os-release ]; then
	. /etc/os-release
fi

if [ -z "${DISTRIB_CODENAME}" ]; then
	#使用VERSION_CODENAME作为DISTRIB_CODENAME
	DISTRIB_CODENAME=${VERSION_CODENAME}
fi


#执行子文件夹的PreUnInstall.sh
for i in $(find ${SCRIPT_DIR} -name PreUnInstall.sh); do
	if [ -x $i ]; then
		echo execute $i
		. $i
	fi
done

if [ -n "${DISTRIB_CODENAME}" ]; then
	#按发行版执行子文件夹的PreUnInstall.sh
	for i in $(find ${SCRIPT_DIR} -name PreUnInstall.${DISTRIB_CODENAME}.sh); do
		if [ -x $i ]; then
			echo execute $i
			. $i
		fi
	done
fi

#执行子文件夹的PostUnInstall.sh
for i in $(find ${SCRIPT_DIR} -name PostUnInstall.sh); do
	if [ -x $i ]; then
		echo execute $i
		. $i
	fi
done

if [ -n "${DISTRIB_CODENAME}" ]; then
	#按发行版执行子文件夹的PostUnInstall.sh
	for i in $(find ${SCRIPT_DIR} -name PostUnInstall.${DISTRIB_CODENAME}.sh); do
		if [ -x $i ]; then
			echo execute $i
			. $i
		fi
	done
fi
