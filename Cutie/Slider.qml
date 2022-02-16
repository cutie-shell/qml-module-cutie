import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15
import QtGraphicalEffects 1.15
import Cutie 1.0

Slider {
    id: root
    z: 3
    property string valueText: ""
    property string label: ""
    property real minimumValue: 0.0
    property real maximumValue: 1.0
    from: minimumValue
    to: maximumValue
    height: 10*dpi.value
    width: parent.width
    leftPadding: 2*dpi.value
    rightPadding: 2*dpi.value
    topPadding: 1*dpi.value
    bottomPadding: 1*dpi.value

    background: Rectangle {
        x: root.leftPadding + 3 * dpi.value
        y: root.topPadding + 3.5 * dpi.value
        height: dpi.value / 2
        width: root.availableWidth - root.rightPadding - root.leftPadding
        radius: dpi.value / 4
        color: (themeVariantConfig.value == "dark") ? "#8fffffff" : "#60000000"
    }

    handle: RadialGradient {
        x: root.leftPadding + root.visualPosition * (root.availableWidth - width)
        y: root.topPadding + root.availableHeight / 2 - height / 2
        gradient: Gradient {
            GradientStop { position: 0.0; color:(themeVariantConfig.value == "dark") ? "#ffffff" : "#000000" }
            GradientStop { position: 0.5; color: "transparent" }
        }
        width: dpi.value * 6
        height: dpi.value * 6
    }

    CutieLabel {
        anchors.right: parent.right
        anchors.rightMargin: root.rightPadding
        anchors.bottom: parent.bottom
        text: valueText
    }
    CutieLabel {
        anchors.left: parent.left
        anchors.leftMargin: root.leftPadding
        anchors.bottom: parent.bottom
        text: label
    }
}
