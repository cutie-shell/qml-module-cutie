import QtQuick 2.15
import QtQuick.Window 2.15

Rectangle {
    property real fadingTime: 300
    function show(text, duration) {
        toastText.text = text;
        if(typeof duration !== "undefined" ) {
            fadingTime = duration;
        }
        animation.start();
    }

    id: toastBody
    width: toastText.width + 4 * dpi.value
    height: toastText.height + 2 * dpi.value
    radius: dpi.value
    opacity: 0
    color: (themeVariantConfig.value == "dark") ? "#ffffff" : "#000000"
    anchors {
        horizontalCenter: parent.horizontalCenter
    }

    Text {
        id: toastText
        text: ""
        font.pixelSize: 3 * dpi.value
        color: (themeVariantConfig.value == "dark") ? "#000000" : "#ffffff"
        anchors {
            horizontalCenter: parent.horizontalCenter
            verticalCenter: parent.verticalCenter
        }
    }

    SequentialAnimation on opacity {
        id: animation
        running: false

        NumberAnimation {
            to: .9
            duration: fadingTime / 10
        }

        PauseAnimation {
            duration: fadingTime
        }

        NumberAnimation {
            to: 0
            duration: fadingTime / 10
        }
    }
}
