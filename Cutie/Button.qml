import QtQuick 2.15
import QtQuick.Window 2.15

Rectangle {
    signal clicked()
    property string buttonText: ""

    id: root
    width: buttonText.width + 4 * dpi.value
    height: buttonText.height + 2 * dpi.value
    radius: dpi.value
    color: (themeVariantConfig.value == "dark") ? "#CCffffff" : "#80000000"
    Text {
        id: buttonText
        text: root.buttonText
        font.pixelSize: 3 * dpi.value
        anchors {
            horizontalCenter: parent.horizontalCenter
            verticalCenter: parent.verticalCenter
        }
        color: (themeVariantConfig.value == "dark") ? "#000000" : "#ffffff"
    }
    MouseArea {
        anchors.fill: parent
        onClicked: {
            root.clicked();
        }
    }
}
