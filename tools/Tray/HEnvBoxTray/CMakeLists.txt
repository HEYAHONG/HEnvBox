cmake_minimum_required(VERSION 3.5)

project(HEnvBoxTray VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(QT NAMES Qt6 Qt5 REQUIRED COMPONENTS Widgets  Network)
find_package(Qt${QT_VERSION_MAJOR} REQUIRED COMPONENTS Widgets Network)
find_package(Qt${QT_VERSION_MAJOR} COMPONENTS LinguistTools)

set(TS_FILES HEnvBoxTray_zh_CN.ts)

set(PROJECT_SOURCES
        main.cpp
        mainwindow.cpp
        mainwindow.h
        mainwindow.ui
        resource.qrc
        ${TS_FILES}
)

if(WIN32)
    list(APPEND PROJECT_SOURCES
         win32/window_resources.rc
    )
    execute_process(COMMAND cmd /c echo %PATH% OUTPUT_VARIABLE WIN32PATH)
    message(STATUS "WIN32PATH:${WIN32PATH}")
    execute_process(COMMAND cmd /c echo %USERPROFILE% OUTPUT_VARIABLE USERPROFILE)
    string(REPLACE "\n" "" USERPROFILE ${USERPROFILE})
    string(REPLACE "\r" "" USERPROFILE ${USERPROFILE})
    set(WIN32STARTUP ${USERPROFILE}//AppData/Roaming/Microsoft/Windows/Start\ Menu/Programs/Startup)
    message(STATUS "WIN32STARTUP:${WIN32STARTUP}")
endif()

if(${QT_VERSION_MAJOR} GREATER_EQUAL 6)
    qt_add_executable(HEnvBoxTray
        MANUAL_FINALIZATION
        ${PROJECT_SOURCES}
        resource.qrc
    )
# Define target properties for Android with Qt 6 as:
#    set_property(TARGET HEnvBoxTray APPEND PROPERTY QT_ANDROID_PACKAGE_SOURCE_DIR
#                 ${CMAKE_CURRENT_SOURCE_DIR}/android)
# For more information, see https://doc.qt.io/qt-6/qt-add-executable.html#target-creation
if(${Qt6LinguistTools_FOUND})
    qt_create_translation(QM_FILES ${CMAKE_SOURCE_DIR} ${TS_FILES})
endif()

else()
    if(ANDROID)
        add_library(HEnvBoxTray SHARED
            ${PROJECT_SOURCES}
        )
# Define properties for Android with Qt 5 after find_package() calls as:
#    set(ANDROID_PACKAGE_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/android")
    else()
        add_executable(HEnvBoxTray
            ${PROJECT_SOURCES}
        )
    endif()

if(${Qt5LinguistTools_FOUND})
    qt5_create_translation(QM_FILES ${CMAKE_SOURCE_DIR} ${TS_FILES})
endif()

endif()

target_link_libraries(HEnvBoxTray PRIVATE Qt${QT_VERSION_MAJOR}::Widgets)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
if(${QT_VERSION} VERSION_LESS 6.1.0)
  set(BUNDLE_ID_OPTION MACOSX_BUNDLE_GUI_IDENTIFIER cn.hyhsystem.HEnvBoxTray)
endif()
set_target_properties(HEnvBoxTray PROPERTIES
    ${BUNDLE_ID_OPTION}
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

file(REAL_PATH ../../../ HENVBOX_ROOT_PATH)
include(GNUInstallDirs)
if(DEFINED ENV{MINGW_PREFIX})
install(TARGETS HEnvBoxTray
    BUNDLE DESTINATION .
    LIBRARY DESTINATION $ENV{MINGW_PREFIX}/lib/
    RUNTIME DESTINATION $ENV{MINGW_PREFIX}/bin/
)
else()
install(TARGETS HEnvBoxTray
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${HENVBOX_ROOT_PATH}/local/HEnvBoxTray/lib/
    RUNTIME DESTINATION ${HENVBOX_ROOT_PATH}/local/HEnvBoxTray/bin/
)
endif()

set(HENVBOXTRAY_BIN_PATH ${HENVBOX_ROOT_PATH}/local/HEnvBoxTray/bin/HEnvBoxTray${CMAKE_EXECUTABLE_SUFFIX})
#支持自动启动
if(EXISTS /etc/xdg/autostart)
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/xdg/HEnvBoxTray.desktop.in ${CMAKE_BINARY_DIR}/HEnvBoxTray.desktop @ONLY)
install(FILES ${CMAKE_BINARY_DIR}/HEnvBoxTray.desktop DESTINATION /etc/xdg/autostart)
endif()
if(WIN32)
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/win32/HEnvBoxTray.bat.in ${CMAKE_BINARY_DIR}/HEnvBoxTray.bat @ONLY)
install(FILES ${CMAKE_BINARY_DIR}/HEnvBoxTray.bat DESTINATION  ${HENVBOX_ROOT_PATH}/local/HEnvBoxTray/bin/)
install(FILES ${CMAKE_BINARY_DIR}/HEnvBoxTray.bat 
	DESTINATION  ${WIN32STARTUP}
	)
endif()

if(QT_VERSION_MAJOR EQUAL 6)
    qt_finalize_executable(HEnvBoxTray)
endif()

target_compile_definitions(HEnvBoxTray PUBLIC HENVBOX_ROOT_PATH="${HENVBOX_ROOT_PATH}" )
