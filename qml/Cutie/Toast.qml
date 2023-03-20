import QtQuick
import Cutie


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
    width: toastText.width + 20
    height: toastText.height + 15
    radius: 5
    opacity: 0
    color: (Atmosphere.variant == "dark") ? "#ffffff" : "#000000"
    anchors {
        horizontalCenter: parent.horizontalCenter
    }

    Text {
        id: toastText
        text: ""
        font.pixelSize: 15
        font.family: "Lato"
        color: (Atmosphere.variant == "dark") ? "#000000" : "#ffffff"
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
