cmake_minimum_required(VERSION 3.14)

project(SADM VERSION 0.1 LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(QT NAMES Qt6 Qt5 COMPONENTS Core Quick Sql REQUIRED)
find_package(Qt${QT_VERSION_MAJOR} COMPONENTS Core Quick Sql REQUIRED)

find_package(Qt6 COMPONENTS Widgets PrintSupport REQUIRED)

#find_package(Qt6 REQUIRED COMPONENTS QuickControls2)

#add_library(qcustomplot SHARED)
#target_compile_definitions(qcustomplot PRIVATE QCUSTOMPLOT_COMPILE_LIBRARY)
#target_include_directories(qcustomplot PUBLIC ${CMAKE_CURRENT_LIST_DIR}/qcustomplot)
#target_sources(qcustomplot PUBLIC ${CMAKE_CURRENT_LIST_DIR}/qcustomplot/qcustomplot.h)
#target_sources(qcustomplot PUBLIC ${CMAKE_CURRENT_LIST_DIR}/qcustomplot/qcustomplot.cpp)
#target_link_libraries(qcustomplot PUBLIC Qt6::Core Qt6::Gui Qt6::Widgets Qt6::PrintSupport)


set(PROJECT_SOURCES
        Source/main.cpp
        GUI/qml.qrc
        qcustomplot/qcustomplot.h
        qcustomplot/qcustomplot.cpp
        Source/worker.h Source/worker.cpp
        Source/workerslist.h Source/workerslist.cpp
        Source/workerslistmodel.h Source/workerslistmodel.cpp
        Source/sqlmanager.h Source/sqlmanager.cpp
        Source/iddistributor.h Source/iddistributor.cpp
)

if(${QT_VERSION_MAJOR} GREATER_EQUAL 6)
    qt_add_executable(SADM
        MANUAL_FINALIZATION
        ${PROJECT_SOURCES}
    )
# Define target properties for Android with Qt 6 as:
#    set_property(TARGET SADM APPEND PROPERTY QT_ANDROID_PACKAGE_SOURCE_DIR
#                 ${CMAKE_CURRENT_SOURCE_DIR}/android)
# For more information, see https://doc.qt.io/qt-6/qt-add-executable.html#target-creation
else()
    if(ANDROID)
        add_library(SADM SHARED
            ${PROJECT_SOURCES}
        )
# Define properties for Android with Qt 5 after find_package() calls as:
#    set(ANDROID_PACKAGE_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/android")
    else()
        add_executable(SADM
          ${PROJECT_SOURCES}
        )
    endif()
endif()

target_compile_definitions(SADM
  PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>
  QCUSTOMPLOT_COMPILE_LIBRARY)
target_link_libraries(SADM
  PRIVATE Qt${QT_VERSION_MAJOR}::Core Qt${QT_VERSION_MAJOR}::Quick Qt${QT_VERSION_MAJOR}::Sql
  PUBLIC Qt${QT_VERSION_MAJOR}::Gui Qt${QT_VERSION_MAJOR}::Widgets Qt${QT_VERSION_MAJOR}::PrintSupport)

set_target_properties(SADM PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
)

if(QT_VERSION_MAJOR EQUAL 6)
    qt_import_qml_plugins(SADM)
    qt_finalize_executable(SADM)
endif()
