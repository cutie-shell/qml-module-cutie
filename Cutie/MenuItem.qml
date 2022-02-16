import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15
import QtGraphicalEffects 1.15
import QtFeedback 5.0
import Cutie 1.0

import org.nemomobile.configuration 1.0

Item {
    id: root
    height: 7 * dpi.value
    width: parent.width
    
    signal clicked()

    property string text: ""
    property bool down: false
    property Item parentMenu: parent

    HapticsEffect {
        id: rumbleEffect
        attackIntensity: 0.0
        attackTime: 250
        intensity: 1.0
        duration: 100
        fadeTime: 250
        fadeIntensity: 0.0
    }

    Rectangle {
        id: back
        height: 5 * dpi.value
        color: (themeVariantConfig.value == "dark") ? "#ffffff" : "#000000"
        width: parent.width
        opacity: root.down ? 1.0 : 0.6
        onOpacityChanged: {
            if (opacity == 1.0) rumbleEffect.start();
        }
    }

    Text {
        id: buttonText
        text: root.text
        font.pixelSize: 3 * dpi.value
        font.family: "Lato"
        anchors {
            horizontalCenter: back.horizontalCenter
            verticalCenter: back.verticalCenter
        }
        color: (themeVariantConfig.value == "dark") ? "#000000" : "#ffffff"
    }

    MouseArea {
        anchors.fill: parent
        onPressed: {
            root.down = true;
        }
        onReleased: {
            root.down = false;
        }
        onClicked: {
            root.clicked();
            if (parentMenu instanceof CutieContextMenu) parentMenu.close();
        }
    }
}
