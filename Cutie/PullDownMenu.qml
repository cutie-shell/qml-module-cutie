import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15
import QtGraphicalEffects 1.15
import QtFeedback 5.0
import Cutie 1.0

import org.nemomobile.configuration 1.0

Column {
    id: menu
    width: parent.width
    anchors.bottom: parent.top
    anchors.bottomMargin: dpi.value
    property Item flickable: parent
    property real oldContentY: flickable.contentY
    property Item oldHighlighted: null
    property real oldTopMargin: 0

    Component.onCompleted: {
        oldTopMargin = flickable.anchors.topMargin
    }

    Connections {
        target: flickable
        ignoreUnknownSignals: true
        function onContentYChanged() {
            if (flickable.contentY < 0 && flickable.dragging) {
                if (flickable.anchors.topMargin <= menu.height + 10*dpi.value) {
                    flickable.anchors.topMargin -= flickable.contentY - oldContentY;
                } else {
                    flickable.anchors.topMargin = menu.height + 10*dpi.value;
                }
                let ch1 = menu.childAt(0, 8*dpi.value + menu.height - flickable.anchors.topMargin)
                if (ch1) {
                    if (ch1 != oldHighlighted && ch1 instanceof CutieMenuItem) {
                        ch1.down = true;
                        if (oldHighlighted) oldHighlighted.down = false;
                        oldHighlighted = menu.childAt(0, 8*dpi.value + menu.height - flickable.anchors.topMargin);
                    }
                } else if (oldHighlighted) {
                    oldHighlighted.down = false;
                    oldHighlighted = null;
                }
                flickable.contentY = oldContentY;
                oldContentY = flickable.contentY;
            }
        }

        function onDraggingChanged() {
            if (!flickable.dragging) {
                let ch1 = menu.childAt(0, 8*dpi.value + menu.height - flickable.anchors.topMargin)
                if (ch1) {
                    if (ch1 instanceof CutieMenuItem) {
                        ch1.clicked();
                    }
                }
                closeAnimation.start();
            }
        }
    }

    NumberAnimation {
        id: closeAnimation
        target: flickable
        properties: "anchors.topMargin"
        to: oldTopMargin
        duration: 200
    }
}