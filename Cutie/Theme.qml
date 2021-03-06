pragma Singleton
import QtQuick 2.15
import Cutie 1.0

import org.nemomobile.configuration 1.0

Item {
    ConfigurationValue {
        id: themeVariant
        key: "/home/cutie/theme/variant"
        defaultValue: "dark"
    }
    ConfigurationValue {
        id: dpiConfig
        key: "/home/cutie/homeScreen/dpi"
    }
    ConfigurationValue {
        id: orientationItem
        key: "/home/cutie/homeScreen/orientation"
        defaultValue: Qt.PortraitOrientation
    }

    property color primaryColor: (themeVariant.value == "dark") ? "#ffffff" : "#000000"
    property color highlightColor: (themeVariant.value == "dark") ? "#ffffff" : "#000000"
    property color secondaryHighlightColor: (themeVariant.value == "dark") ? "#ffffff" : "#000000"
    property color secondaryColor: (themeVariant.value == "dark") ? "#ffffff" : "#000000"
    property real highlightBackgroundOpacity: 0.3
    property real itemSizeSmall: dpiConfig.value * 2
    property real itemSizeMedium: dpiConfig.value * 4
    property real itemSizeLarge: dpiConfig.value * 6
    property real fontSizeExtraLarge: dpiConfig.value * 5
    property real fontSizeLarge: dpiConfig.value * 4
    property real fontSizeSmall: dpiConfig.value * 2
    property real fontSizeExtraSmall: dpiConfig.value
    property real iconSizeSmall: dpiConfig.value * 2

    property real paddingSmall: dpiConfig.value * 1
    property real paddingMedium: dpiConfig.value * 2
    property real paddingLarge: dpiConfig.value * 3
    property real horizontalPageMargin: dpiConfig.value * 3

    function rgba(color, opacity) {
        return Qt.rgba(color.r, color.g, color.b, opacity);
    }
}