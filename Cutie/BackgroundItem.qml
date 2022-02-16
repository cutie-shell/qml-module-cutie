import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15
import QtGraphicalEffects 1.15
import QtFeedback 5.0
import Cutie 1.0

import org.nemomobile.configuration 1.0

MouseArea {
    id: root
    height: 7 * dpi.value
    width: (parent) ? parent.width : height
    property bool down: false

    onPressed: {
        root.down = true;
    }

    onReleased: {
        root.down = false
    }
}
