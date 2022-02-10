import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15
import QtGraphicalEffects 1.15
import QtFeedback 5.0
import Cutie 1.0

import org.nemomobile.configuration 1.0

Page {
    id: pageRoot
    visible: true
    background: Item {}

    property int index: StackView.index
    property StackView view: StackView.view
    property int status: StackView.status

    property ListModel menu: ListModel {}

    Behavior on y {
        NumberAnimation { duration: 200 }
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
        id: gestureArea
        anchors.fill: parent
        drag.target: pageRoot
        drag.axis: Drag.XAndYAxis
        drag.minimumX: 0
        drag.maximumX: pageRoot.index > 0 ? pageRoot.width : 0
        drag.minimumY: 0
        drag.maximumY: menu.height > 0 ? menu.height + 7*dpi.value : 0

        property int threshold: dpi.value * 15

        onPositionChanged: {
            if (Math.abs(pageRoot.x) > dpi.value) {
                pageRoot.y = 0;
                gestureArea.drag.axis = Drag.XAxis;
            } else if (Math.abs(pageRoot.y) > dpi.value) {
                pageRoot.x = 0;
                gestureArea.drag.axis = Drag.YAxis;
            }
        }

        onReleased: {
            mouse.accepted = false;
            if (drag.axis == Drag.XAxis) {
                if (pageRoot.index > 0 && Math.abs(pageRoot.x) > threshold) {
                    mouse.accepted = true;
                    rumbleEffect.start();
                    pageRoot.view.pop();
                } else {
                    pageRoot.x = 0;
                }
            } else if (drag.axis == Drag.YAxis) {
                let selIndex = Math.floor(pageRoot.menu.count - (pageRoot.y - 14 * dpi.value / 3) / (7 * dpi.value));
                pageRoot.y = 0;
                if (selIndex >= 0 && selIndex < pageRoot.menu.count) {
                    let callback = pageRoot.menu.get(selIndex).callback;
                    rumbleEffect.start();
                    if (callback) callback();
                }
            }
            drag.axis = Drag.XAndYAxis;
        }
    }

    RadialGradient {
        visible: pageRoot.index > 0
        opacity: (pageRoot.status == StackView.Active || pageRoot.status == StackView.Activating) ? 1 : 0
        gradient: Gradient {
            GradientStop { position: 0.0; color:(themeVariantConfig.value == "dark") ? "#ffffff" : "#000000" }
            GradientStop { position: 0.5; color: "transparent" }
        }
        width: dpi.value * 5
        height: dpi.value * 5
        x: - dpi.value * 2.5
        y: dpi.value * 7.5

        Behavior on opacity {
            NumberAnimation { duration: 200 }
        }
    }

    Column {
        id: menu
        width: parent.width
        anchors.bottom: parent.top
        Repeater {
            model: pageRoot.menu
            delegate: Item {
                height: 7 * dpi.value
                width: parent.width
                opacity: ((pageRoot.y > 2*height/3 + height*(pageRoot.menu.count - index - 1)) && (pageRoot.y < height*(pageRoot.menu.count - index) + 2*height/3)) ? 1 : 0.6
                
                onOpacityChanged: {
                    if (opacity == 1.0) rumbleEffect.start();
                }
                
                Rectangle {
                    height: 5 * dpi.value
                    color: (themeVariantConfig.value == "dark") ? "#ffffff" : "#000000"
                    width: parent.width

                    Text {
                        id: buttonText
                        text: model.text
                        font.pixelSize: 3 * dpi.value
                        font.family: "Lato"
                        anchors {
                            horizontalCenter: parent.horizontalCenter
                            verticalCenter: parent.verticalCenter
                        }
                        color: (themeVariantConfig.value == "dark") ? "#000000" : "#ffffff"
                    }
                }
            }
        }
    }
}