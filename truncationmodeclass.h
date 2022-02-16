#pragma once
#include <QDebug>
#include <QtQuick>
#include <QtQml/qqml.h>
#include <QtQml/QQmlExtensionPlugin>

class TruncationModeClass
{
    Q_GADGET
public:
    enum Value {
        None = 0,
        Elide = 1,
        Fade = 2
    };
    Q_ENUM(Value)
};

typedef TruncationModeClass::Value TruncationMode;
