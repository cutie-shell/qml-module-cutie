#include "plugin.h"

QObject *standard_paths_singletontype_provider(QQmlEngine *engine, QJSEngine *scriptEngine)
{
    Q_UNUSED(engine)
    Q_UNUSED(scriptEngine)

    StandardPaths *standardpaths = new StandardPaths();
    return standardpaths;
}

QUrl StandardPaths::home() {
    return QUrl(QStandardPaths::standardLocations(QStandardPaths::HomeLocation).at(0));
}