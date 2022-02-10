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

    Text {
        id: headerText
        text: root.text
        anchors.top: root.top
        anchors.topMargin: 7 * dpi.value
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