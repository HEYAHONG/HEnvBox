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

${STAMPDIR}:
	@mkdir -p ${STAMPDIR}

prepare-dir_step += ${STAMPDIR}

endif

ifneq (${TEMPDIR},)

${TEMPDIR}:
	@mkdir -p ${TEMPDIR}

prepare-dir_step += ${TEMPDIR}

endif

ifneq (${SRCDIR},)

${SRCDIR}:
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

