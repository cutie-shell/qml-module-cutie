import QtQuick 2.15
import QtQuick.Window 2.15
import QtFeedback 5.0

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
        font.family: "Lato"
        anchors {
            horizontalCenter: parent.horizontalCenter
            verticalCenter: parent.verticalCenter
        }
        color: (themeVariantConfig.value == "dark") ? "#000000" : "#ffffff"
    }

    HapticsEffect {
        id: rumbleEffect
        attackIntensity: 0.0
        attackTime: 250
        intensity: 1.0
        duration: 100
        fadeTime: 250
        fadeIntensity: 0.0
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            rumbleEffect.start();
            root.clicked();
        }
    }
}
