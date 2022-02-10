import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15
import QtGraphicalEffects 1.15
import Cutie 1.0

import org.nemomobile.configuration 1.0

Item {
    id: root
    visible: true
    height: 10 * dpi.value

    property string text: ""

    Item {
        id: statusBar
        width: parent.width
        height: 5 * dpi.value
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

    Text {
        id: headerText
        text: root.text
        anchors.top: statusBar.bottom
        anchors.topMargin: 2 * dpi.value
        anchors.left: parent.left
        anchors.leftMargin: 3 * dpi.value
        font.pixelSize: 5 * dpi.value
        font.family: "Lato"
        font.weight: Font.Light
        anchors {
            horizontalCenter: parent.horizontalCenter
            verticalCenter: parent.verticalCenter
        }
        color: (themeVariantConfig.value == "dark") ? "#ffffff" : "#000000"
    }
}