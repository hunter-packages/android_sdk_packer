# Copyright (c) 2018, Ruslan Baratov
# All rights reserved.

cmake_minimum_required(VERSION 3.3)
project(android_sdk_packer)

include(GNUInstallDirs)

set(
    project_config
    "${CMAKE_CURRENT_BINARY_DIR}/generated/${PROJECT_NAME}Config.cmake"
)

set(config_install_dir "${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME}")
set(MODULE_INSTALL_DIR "cmake/module")

include(CMakePackageConfigHelpers)

# Use:
# * PROJECT_NAME
# * MODULE_INSTALL_DIR
configure_package_config_file(
    cmake/template/Config.cmake.in
    ${project_config}
    INSTALL_DESTINATION "${config_install_dir}"
    PATH_VARS MODULE_INSTALL_DIR
)

install(DIRECTORY cmake/module/ DESTINATION ${MODULE_INSTALL_DIR})
install(FILES ${project_config} DESTINATION ${config_install_dir})
