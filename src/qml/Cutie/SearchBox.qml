import QtQuick
import QtQuick.Controls
import Cutie

CutieTextField {
    id: root

    placeholderTextColor: Atmosphere.textColor
    height: 38
    leftPadding: 16
    rightPadding: 16
    verticalAlignment: Text.AlignVCenter

    background: Rectangle {
        radius: root.height / 2
        color: Atmosphere.primaryAlphaColor
    }
}
