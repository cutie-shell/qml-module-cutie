#pragma once
#include <QDebug>
#include <QtQuick>
#include <QtQml/qqml.h>
#include <QtQml/QQmlExtensionPlugin>

class PageStatusClass
{
    Q_GADGET
public:
    enum Value {
        Inactive = 0,
        Deactivating = 1,
        Activating = 2,
        Active = 3
    };
    Q_ENUM(Value)
};

typedef PageStatusClass::Value PageStatus;
