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
	@touch ${STAMPDIR}

prepare-dir_step += ${STAMPDIR}

endif

ifneq (${TEMPDIR},)

${TEMPDIR}:${LOCALDIR}
	@mkdir -p ${TEMPDIR}
	@touch ${TEMPDIR}

prepare-dir_step += ${TEMPDIR}

endif

ifneq (${SRCDIR},)

${SRCDIR}:${LOCALDIR}
	@mkdir -p ${SRCDIR}
	@touch ${SRCDIR}

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




#定义包含子目录,$(eval $(call IncludeSubdirMakefile,目录,文件名))调用,最大深度为3。
define IncludeSubdirMakefileEx

ifneq (${2},)

$(foreach file,$(shell find ${1} -type f -maxdepth 3 -name ${2} 2> /dev/null),$(eval include ${file}))

endif

endef

#定义包含子目录,$(eval $(call IncludeSubdirMakefile,目录))调用。搜索子目录下的subdir.mk,最大深度为3。
define IncludeSubdirMakefile

ifneq (${1},)

$(foreach file,$(shell find ${1} -type f -maxdepth 3 -name subdir.mk 2> /dev/null),$(eval include ${file}))

endif

endef

