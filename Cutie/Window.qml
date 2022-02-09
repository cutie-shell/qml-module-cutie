import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15
import Cutie 1.0

import org.nemomobile.configuration 1.0

Window {
    id: win
    visible: true
    color: "transparent"

    property alias pageStack: stackView
    property alias initialPage: stackView.initialItem
    property Component cover
    property Item coverInstance

    onActiveChanged: {
        if (coverInstance) {
            coverInstance.visible = !win.active
        }
    }

    Component.onCompleted: {
        if (cover) {
            coverInstance = cover.createObject(win, {
                visible: false,
                anchors: {
                    centerIn: win
                }
            });
        }
    }

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

    Item {
        id: statusBar
        width: parent.width
        height: 5 * dpi.value
        visible: win.active
        anchors {
            left: parent.left
            top: parent.top
            right: parent.right
        }

        Text { 
            id: timeIndicator
            color: themeVariantConfig.value == "dark" ? "white" : "black"
            text: Qt.formatDateTime(new Date(), "HH:mm:ss")
            font.pixelSize: 2.5 * dpi.value
            font.family: "Lato"
            anchors {
                left: parent.left
                leftMargin: 2 * dpi.value
                verticalCenter: parent.verticalCenter    
            }

            function timeChanged() {
                text = Qt.formatDateTime(new Date(), "HH:mm:ss");
            }

            Timer {
                interval: 100; running: true; repeat: true;
                onTriggered: parent.timeChanged()
            }
        }
    }

    StackView {
        id: stackView
        anchors.fill: parent
        anchors.topMargin: statusBar.height
        anchors.bottomMargin: panelSize
        visible: (cover) ? win.active : true

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