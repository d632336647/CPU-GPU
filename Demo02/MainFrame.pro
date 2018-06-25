QT += charts qml quick
QT += charts
CONFIG += c++11
#CONFIG += console
# The following define makes your compiler emit warnings if you use
# any feature of Qt which as been marked deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if you use deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += main.cpp \
    getsysinfo.cpp \
    gpufft1000.cpp \
    thrift/src/Collect.cpp \
    thrift/src/msg_types.cpp \
    thrift/src/server.cpp \
    thrift/src/thriftlocal.cpp

RESOURCES += qml.qrc \
    rc.qrc


# Additional import path used to resolve QML modules in Qt Creator's code model
#QML_IMPORT_PATH = $$PWD/UILibrary/   #加入路径以支持插件语法高亮
QML_IMPORT_PATH = $$PWD/Plugin/

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

DISTFILES +=

HEADERS += \
    getsysinfo.h \
    gpufft1000.h \
    thrift/src/Collect.h \
    thrift/src/msg_types.h \
    thrift/src/thriftlocal.h


win32:CONFIG(release, debug|release): LIBS += -L$$PWD/LIB/NVML/ -lnvml
else:win32:CONFIG(debug, debug|release): LIBS += -L$$PWD/LIB/NVML/ -lnvmld

INCLUDEPATH += $$PWD/LIB/NVML
DEPENDPATH += $$PWD/LIB/NVML


win32:CONFIG(release, debug|release): LIBS += -L$$PWD/LIB/GpuFFTdll_v8.0/ -lgpuFFT
else:win32:CONFIG(debug, debug|release): LIBS += -L$$PWD/LIB/GpuFFTdll_v8.0/ -lgpuFFTd

INCLUDEPATH += $$PWD/LIB/GpuFFTdll_v8.0
DEPENDPATH += $$PWD/LIB/GpuFFTdll_v8.0

INCLUDEPATH += $$PWD/thrift/include
LIBS += -L$$PWD/thrift/lib -llibthrift -llibssl -llibcrypto
