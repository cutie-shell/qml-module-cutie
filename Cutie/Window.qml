import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15
import Cutie 1.0

import org.nemomobile.configuration 1.0

Window {
    id: win
    visible: true
    color: "transparent"
    contentOrientation: ((orientationItem.value == Qt.LandscapeOrientation) ? Qt.InvertedLandscapeOrientation 
        : ((orientationItem.value == Qt.InvertedLandscapeOrientation) ? Qt.LandscapeOrientation 
        : orientationItem.value))

    property alias pageStack: appInternal.pageStack
    property alias initialPage: appInternal.initialPage
    property alias toastHandler: appInternal.toastHandler

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

    property ConfigurationValue orientationConfig: orientationItem
    ConfigurationValue {
        id: orientationItem
        key: "/home/cutie/homeScreen/orientation"
        defaultValue: Qt.PortraitOrientation
    }

    CutieApplicationInternal {
        id: appInternal
    }
}