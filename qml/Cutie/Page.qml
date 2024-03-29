import QtQuick
import QtQuick.Controls
import QtQuick.Window
import Qt5Compat.GraphicalEffects
import Cutie

Page {
    background: null

    readonly property Item pageContainer: SwipeView.view

    property bool backNavigation: SwipeView.index > 0
    property bool isCurrentItem: SwipeView.isCurrentItem
    property bool isReady: false

    Component.onCompleted: {
        isReady = true;
    }
    
    RadialGradient {
        opacity: (isCurrentItem && backNavigation && isReady) ? 1.0 : 0.0
        width: 25
        height: 25
        gradient: Gradient {
            GradientStop { position: 0.0; color: Atmosphere.textColor }
            GradientStop { position: 0.5; color: "transparent" }
        }
        anchors.horizontalCenter: parent.left
        anchors.top: parent.top
        anchors.topMargin: 22
        anchors.leftMargin: 25
        Behavior on opacity {
            NumberAnimation { properties: "opacity"; easing.type: Easing.InOutQuad; duration: 500 }
        }
    }
}
