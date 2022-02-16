import QtQuick 2.15
import QtQuick.Window 2.15

MouseArea {
    property bool down: false
    onPressed: {
        down = true;
    }
    onReleased: {
        down = false;
    }
}
