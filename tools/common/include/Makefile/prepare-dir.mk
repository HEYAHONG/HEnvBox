# prepare-dir.mk
# 由top.mk包含

prepare-dir_step :=

ifneq (${HENVBOX_LOCAL_ROOT_PATH_UNIX},)
#处于HEnvBox中

ifneq (${LOCALDIR},)

${LOCALDIR}:
	@ln -sf  "`realpath ${HENVBOX_LOCAL_ROOT_PATH_UNIX}/ 2>/dev/null`" ${LOCALDIR}

prepare-dir_step += ${LOCALDIR}


endif

else

ifneq (${LOCALDIR},)

${LOCALDIR}:
	@mkdir -p ${LOCALDIR}/

prepare-dir_step += ${LOCALDIR}

endif

endif


ifneq (${STAMPDIR},)

${STAMPDIR}:${LOCALDIR}
	@mkdir -p ${STAMPDIR}

prepare-dir_step += ${STAMPDIR}

endif

ifneq (${TEMPDIR},)

${TEMPDIR}:${LOCALDIR}
	@mkdir -p ${TEMPDIR}

prepare-dir_step += ${TEMPDIR}

endif

ifneq (${SRCDIR},)

${SRCDIR}:${LOCALDIR}
	@mkdir -p ${SRCDIR}

prepare-dir_step += ${SRCDIR}

endif

.PHONY:prepare-dir
prepare-dir:${prepare-dir_step}
	@echo prepare-dir done!

#添加至准备目标
prepare:prepare-dir

.PHONY:clean-dir
clean-dir:
	-@[ -d ${LOCALDIR} ] && rm -rf ${LOCALDIR}
	@echo clean-dir done!

#添加至发行清理目标
dist-clean:clean-dir


#定义Include，使用$(eval $(call Include,需要包含的文件路径))调用
#通过__Inclide_Included_Files__确保不重复包含
__Inclide_Included_Files__ :=
define Include

ifneq (${1},)

Include_File := $(shell realpath ${1})

ifneq ($(findstring ${Include_File},${__Inclide_Included_Files__}),${Include_File})

include ${Include_File}

__Inclide_Included_Files__ += ${Include_File}

endif

endif

endef

#定义包含子目录,$(eval $(call IncludeSubdirMakefile,目录,可选文件名))调用，当文件名不指定时，默认为subdir.mk
define IncludeSubdirMakefile

ifneq (${2},)

$(foreach file,$(shell find ${1} -type f -name ${2} 2> /dev/null),$(eval $(call Include,$(file))))

else

ifneq (${1},)

$(foreach file,$(shell find ${1} -type f -name subdir.mk 2> /dev/null),$(eval $(call Include,$(file))))

endif

endif

endef


