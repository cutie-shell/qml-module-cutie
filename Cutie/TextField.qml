import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15

TextField {
    id: root
    z: 3
    height: 8 * dpi.value
    background: Rectangle {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 2 * dpi.value
        height: 0.25 * dpi.value
        color: (themeVariantConfig.value == "dark") ? "#ffffff" : "#000000"
    }
    color: (themeVariantConfig.value == "dark") ? "#ffffff" : "#000000"
    font.pixelSize: 3 * dpi.value
    font.family: "Lato"
}