# prepare-env.mk
# 由top.mk包含

#定义各个目标的步骤,默认为空，但用户需要将实际步骤通过+=添加至相应步骤
prepare_step:=
download_step:=
configure_step:=
build_step:=
install_step:=
clean_step:=
dist-clean_step:=
