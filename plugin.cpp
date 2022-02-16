#include "plugin.h"

void CutiePlugin::registerTypes(const char *uri)
{
    qRegisterMetaType<PageStatus>("PageStatus");
    qmlRegisterUncreatableType<PageStatusClass>("Cutie", 1, 0, "CutiePageStatus", "Not creatable as it is an enum type");
    qmlRegisterUncreatableType<PageStatusClass>("Sailfish.Silica", 1, 0, "PageStatus", "Not creatable as it is an enum type");
    qRegisterMetaType<TruncationMode>("TruncationMode");
    qmlRegisterUncreatableType<TruncationModeClass>("Cutie", 1, 0, "CutieTruncationMode", "Not creatable as it is an enum type");
    qmlRegisterUncreatableType<TruncationModeClass>("Sailfish.Silica", 1, 0, "TruncationMode", "Not creatable as it is an enum type");
    qmlRegisterSingletonType<StandardPaths>("Cutie", 1, 0, "CutieStandardPaths", standard_paths_singletontype_provider);
    qmlRegisterSingletonType<StandardPaths>("Sailfish.Silica", 1, 0, "StandardPaths",standard_paths_singletontype_provider);
}