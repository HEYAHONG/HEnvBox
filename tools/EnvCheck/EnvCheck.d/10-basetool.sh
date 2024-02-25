#!/bin/bash

#检查基本工具
function EnvCheckCheckBasetool
{
	#cc c++
	EnvCheckTestProgram cc
	EnvCheckTestProgram c++

	#gcc
	EnvCheckTestProgram gcc
	EnvCheckTestProgram g++

	#Linux三剑客
	EnvCheckTestProgram grep
	EnvCheckTestProgram awk
	EnvCheckTestProgram gawk
	EnvCheckTestProgram sed

	#findutils
	EnvCheckTestProgram find

	#下载工具
	EnvCheckTestProgram wget
	EnvCheckTestProgram curl

	#压缩/解压工具
	EnvCheckTestProgram gzip
	EnvCheckTestProgram xz
	EnvCheckTestProgram lzma
	EnvCheckTestProgram zip
	EnvCheckTestProgram unzip -v

	#coreutils(部分常用工具)
	EnvCheckTestProgram dirname
	EnvCheckTestProgram realpath
	EnvCheckTestProgram sort
	EnvCheckTestProgram chown
	EnvCheckTestProgram chmod
	EnvCheckTestProgram ls


	#构建系统/构建工具
	EnvCheckTestProgram make

	#其它工具
	EnvCheckTestProgram uniq
}

export -f EnvCheckCheckBasetool
