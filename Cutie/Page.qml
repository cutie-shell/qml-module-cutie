import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15
import QtGraphicalEffects 1.15
import Cutie 1.0

import org.nemomobile.configuration 1.0

Page {
    id: root
    visible: true
    background: Item {}

    property int index: StackView.index
    property StackView view: StackView.view
    property int status: StackView.status

    MouseArea {
        anchors.fill: parent
        drag.target: parent
        drag.axis: Drag.XAxis
        drag.minimumX: 0
        drag.maximumX: root.index > 0 ? parent.width : 0

        property int threshold: dpi.value * 15

        onReleased: {
            mouse.accepted = false;
            if (root.index > 0 && Math.abs(parent.x) > threshold) {
                mouse.accepted = true;
                root.view.pop();
            } else {
                parent.x = 0;
            }
        }
    }

    RadialGradient {
        visible: root.index > 0
        opacity: (root.status == StackView.Active || root.status == StackView.Activating) ? 1 : 0
        gradient: Gradient {
            GradientStop { position: 0.0; color:(themeVariantConfig.value == "dark") ? "#ffffff" : "#000000" }
            GradientStop { position: 0.5; color: "transparent" }
        }
        width: dpi.value * 10
        height: dpi.value * 10
        x: - dpi.value * 5
        y: dpi.value * 5

        Behavior on opacity {
            NumberAnimation { duration: 200 }
        }
    }
}