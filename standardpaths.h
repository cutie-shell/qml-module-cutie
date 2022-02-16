#pragma once
#include <QDebug>
#include <QtQuick>
#include <QtQml/qqml.h>
#include <QtQml/QQmlExtensionPlugin>

class StandardPaths : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QUrl home READ home)
public:
    QUrl home();
};

QObject *standard_paths_singletontype_provider(QQmlEngine *engine, QJSEngine *scriptEngine);