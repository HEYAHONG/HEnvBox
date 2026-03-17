#/bin/bash

#检查是否在HEnvBox中
[ -d "${HENVBOX_ROOT_PATH}" ] || exit 1

#shellcheck disable=SC2128  # ignore array expansion warning
if [ -n "${BASH_SOURCE-}" ]; then
	self_path="${BASH_SOURCE}"
elif [ -n "${ZSH_VERSION-}" ]; then
	self_path="${(%):-%x}"
else
	exit 1
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

#进入当前目录
pushd ${script_dir}

#删除桌面自动启动
if [ -f "/etc/xdg/HEnvBoxTray.desktop" ]; then
	echo delete "/etc/xdg/HEnvBoxTray.desktop"
	rm -rf "/etc/xdg/HEnvBoxTray.desktop"
fi
if [ -f "${HOME}/.config/autostart/HEnvBoxTray.desktop" ]; then
	echo delete "${HOME}/.config/autostart/HEnvBoxTray.desktop"
	rm -rf "${HOME}/.config/autostart/HEnvBoxTray.desktop"
fi

#退出目录
popd
