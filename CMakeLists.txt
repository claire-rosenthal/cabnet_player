cmake_minimum_required(VERSION 3.16)

project(cabnet_player VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTORCC ON)

find_package(Qt6 REQUIRED COMPONENTS Core Quick OpenGL QuickControls2)
find_library(MPV_LIB mpv REQUIRED)

qt_standard_project_setup(REQUIRES 6.10)

qt_add_executable(appcabnet_player
    cabnetplayer.qrc
    main.cpp
)

qt_add_qml_module(appcabnet_player
    URI cabnet_player
    QML_FILES main.qml
    SOURCES
        qthelper.hpp
        main.h
    RESOURCES cabnetplayer.qrc
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appcabnet_player PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appcabnet_player
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appcabnet_player
    PRIVATE
        Qt6::Core
        Qt6::Quick
        Qt6::OpenGL
        Qt6::QuickControls2
        "${MPV_LIB}"
)

install(TARGETS appcabnet_player
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
