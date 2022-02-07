import QtQuick 2.14
import QtQuick.Window 2.14
import Cutie 1.0

import org.nemomobile.configuration 1.0

Window {
    visible: true
    color: "transparent"

    property ConfigurationValue themeVariantConfig: themeVariant
    ConfigurationValue {
        id: themeVariant
        key: "/home/cutie/theme/variant"
        defaultValue: "dark"
    }

    property ConfigurationValue dpi: dpiConfig
    ConfigurationValue {
        id: dpiConfig
        key: "/home/cutie/homeScreen/dpi"
        defaultValue: Screen.pixelDensity
    }

    property CutieToastHandler toastHandler: toastHandler
    CutieToastHandler {
        id: toastHandler
    }
}