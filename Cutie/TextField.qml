import QtQuick 2.15
import QtQuick.Window 2.15

Item {
    id: root
    height: 8 * dpi.value

    property alias text: inputElement.text

    signal accepted()

    function selectAll() {
        inputElement.selectAll();
    }

    TextInput {
        id: inputElement
        color: (themeVariantConfig.value == "dark") ? "#ffffff" : "#000000"
        font.pixelSize: 3 * dpi.value
        font.family: "Lato"
        anchors.fill: parent
        anchors.margins: 2.5 * dpi.value
        onAccepted: {
            root.accepted();
        }
    }

    Rectangle {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 2 * dpi.value
        height: 0.25 * dpi.value
        color: (themeVariantConfig.value == "dark") ? "#ffffff" : "#000000"
    }
}
