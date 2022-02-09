import QtQuick 2.15
import QtQuick.Window 2.15

Item {
    property string text
    property alias font: labelText.font
    property double fontSize: 3

    id: root
    width: labelText.width + 4 * dpi.value
    height: labelText.height + fontSize * 4/3 * dpi.value
    Text {
        id: labelText
        text: root.text
        font.pixelSize: root.fontSize * dpi.value
        font.family: "Lato"
        anchors {
            horizontalCenter: root.horizontalCenter
            verticalCenter: root.verticalCenter
        }
        color: (themeVariantConfig.value == "dark") ? "#ffffff" : "#000000"
    }
}
