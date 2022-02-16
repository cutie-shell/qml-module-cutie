import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15
import QtFeedback 5.0
import Cutie 1.0

Button {
    id: root
    z: 3
    width: contentItem.implicitWidth + 4 * dpi.value
    height: contentItem.implicitHeight + 2 * dpi.value
    background: Rectangle {
        anchors.fill: parent
        radius: dpi.value
        color: (themeVariantConfig.value == "dark") ? "#CCffffff" : "#80000000"
    }

    contentItem: CutieLabel {
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: 3 * dpi.value
        font.family: "Lato"
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

    onClicked: {
        rumbleEffect.start();
    }
}
