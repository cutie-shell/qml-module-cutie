import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15
import Cutie 1.0

import org.nemomobile.configuration 1.0

Window {
    visible: true
    color: "transparent"

    property alias pageStack: stackView
    property alias initialPage: stackView.initialItem

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

    StackView {
        id: stackView
        anchors.fill: parent
        anchors.bottomMargin: panelSize

        property real panelSize: 0
        property real imSize: Qt.inputMethod.keyboardRectangle.height

        onImSizeChanged: {
            panelSize = imSize
        }

        clip: true

        pushEnter: Transition {
            PropertyAnimation {
                property: "x"
                from: stackView.width
                to: 0
                duration: 500
                easing.type: Easing.OutQuad
            }
        }

        pushExit: Transition {
            PropertyAnimation {
                property: "x"
                to: -stackView.width
                duration: 500
                easing.type: Easing.OutQuad
            }
        }
        
        popEnter: Transition {
            PropertyAnimation {
                property: "x"
                from: -stackView.width
                to: 0
                duration: 500
                easing.type: Easing.OutQuad
            }
        }

        popExit: Transition {
            PropertyAnimation {
                property: "x"
                to: stackView.width
                duration: 500
                easing.type: Easing.OutQuad
            }
        }
    }
}