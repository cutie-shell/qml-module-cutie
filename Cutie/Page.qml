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
    property int allowedOrientations: Qt.PortraitOrientation


    HapticsEffect {
        id: rumbleEffect
        attackIntensity: 0.0
        attackTime: 250
        intensity: 1.0
        duration: 100
        fadeTime: 250
        fadeIntensity: 0.0
    }

    default  property alias __content: content.data

    Flickable {
        id: content
        anchors.fill: parent
        property real oldContentX: contentX
        property int threshold: dpi.value * 15
        flickableDirection: Flickable.HorizontalFlick
        onContentXChanged: {
            if (contentX < 0 && dragging) {
                if (pageRoot.x < pageRoot.width && pageRoot.index > 0) {
                    pageRoot.x -= contentX - oldContentX;
                }
            }
            contentX = oldContentX;
            oldContentX = contentX;
        }

        onDraggingChanged: {
            if (!dragging) {
                if (pageRoot.x > threshold) {
                    rumbleEffect.start();
                    pageRoot.view.pop();
                } else {
                    pageRoot.x = 0;
                }
            }
        }

        RadialGradient {
            visible: pageRoot.index > 0
            opacity: (pageRoot.status == StackView.Active || pageRoot.status == StackView.Activating) ? 1 : 0
            gradient: Gradient {
                GradientStop { position: 0.0; color:(themeVariantConfig.value == "dark") ? "#ffffff" : "#000000" }
                GradientStop { position: 0.5; color: "transparent" }
            }
            width: dpi.value * 6
            height: dpi.value * 6
            x: - dpi.value * 3
            y: dpi.value * 3

            Behavior on opacity {
                NumberAnimation { duration: 200 }
            }
        }
    }

    /*MouseArea {
        id: gestureArea
        anchors.fill: parent
        drag.target: pageRoot
        drag.axis: Drag.XAxis
        drag.minimumX: 0
        drag.maximumX: pageRoot.index > 0 ? pageRoot.width : 0
        preventStealing: true
        propagateComposedEvents: true
        z: 0

        property int threshold: dpi.value * 15

        onReleased: {
            mouse.accepted = false;
            if (pageRoot.index > 0 && Math.abs(pageRoot.x) > threshold) {
                mouse.accepted = true;
                rumbleEffect.start();
                pageRoot.view.pop();
            } else {
                pageRoot.x = 0;
            }
        }
    }*/
}