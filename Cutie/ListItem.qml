import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15
import QtGraphicalEffects 1.15
import QtFeedback 5.0
import Cutie 1.0

import org.nemomobile.configuration 1.0

Item {
    id: root
    z: 3
    height: content.height + (menu ? (menu.visible ? menu.height : 0) : 0)
    width: parent.width

    property Item menu: null
    
    default  property alias __content: content.data

    Connections {
        target: root.menu
        ignoreUnknownSignals: true
        function onClose() {
            root.menu.visible = false;
        }
    }

    onMenuChanged: {
        menu.parent = root;
        menu.y = content.height
    }

    function remorseAction(string, action, timeout) {
        action();
    }

    MouseArea {
        id: content
        height: 7 * dpi.value
        width: parent.width

        onPressAndHold: {
            if (menu) {
                menu.visible = true;
                root.height += menu.implicitHeight
            }
        }

        onClicked: {
            if (menu) {
                if (menu.visible) {
                    menu.visible = false;
                    root.height -= menu.implicitHeight;
                }
            }
        }
    }
}
