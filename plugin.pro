TEMPLATE = lib
CONFIG += qt plugin
QT += qml quick dbus

TARGET  = qmlcutieplugin

SOURCES += plugin.cpp \
           standardpaths.cpp

HEADERS += plugin.h \
           pagestatusclass.h \
           truncationmodeclass.h \
           standardpaths.h

lib.files = Cutie Sailfish
lib.path = $$[QT_INSTALL_QML]
target.path = $$[QT_INSTALL_QML]/Cutie
INSTALLS += lib target