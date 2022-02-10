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

    property ConfigurationValue orientationConfig: orientationItem
    ConfigurationValue {
        id: orientationItem
        key: "/home/cutie/homeScreen/orientation"
        defaultValue: Qt.PortraitOrientation
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
        anchors.centerIn: parent
        anchors.verticalCenterOffset: ((orientationItem.value == Qt.PortraitOrientation) ? -panelSize/2
            : ((orientationItem.value == Qt.InvertedPortraitOrientation) ? panelSize/2
            : 0))
        anchors.horizontalCenterOffset: ((orientationItem.value == Qt.LandscapeOrientation) ? panelSize/2
            : ((orientationItem.value == Qt.InvertedLandscapeOrientation) ? -panelSize/2
            : 0))
        rotation: Screen.angleBetween(orientationItem.value, Screen.primaryOrientation)
        width: ((rotation % 180 == 0) 
            ? parent.width : parent.height)
        height: ((rotation % 180 == 0) 
            ? parent.height : parent.width) - panelSize
            
        Behavior on rotation {
            RotationAnimator { 
                duration: 200
                direction: RotationAnimator.Shortest
            }
        }

        Behavior on height {
            NumberAnimation { duration: 200 }
        }

        Behavior on width {
            NumberAnimation { duration: 200 }
        }

        Behavior on anchors.verticalCenterOffset {
            NumberAnimation { duration: 200 }
        }

        Behavior on anchors.horizontalCenterOffset {
            NumberAnimation { duration: 200 }
        }

        property real panelSize: 0
        property real imSize: (((orientationItem.value == Qt.PortraitOrientation) || (orientationItem.value == Qt.InvertedPortraitOrientation)) ? Qt.inputMethod.keyboardRectangle.height : Qt.inputMethod.keyboardRectangle.width)

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