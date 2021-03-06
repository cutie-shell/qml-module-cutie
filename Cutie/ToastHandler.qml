import QtQuick 2.14

ListView {
    function show(text, duration) {
        model.insert(0, {text: text, duration: duration});
    }

    id: root
    z: Infinity
    spacing: dpi.value
    anchors {
        fill: parent
        bottomMargin: parent.height / 5
    }
    verticalLayoutDirection: ListView.BottomToTop
    interactive: false
    displaced: Transition {
        NumberAnimation {
            properties: "y"
            easing.type: Easing.InOutQuad
        }
    }

    delegate: Toast {
        Component.onCompleted: {
            if (typeof duration === "undefined") {
                show(text);
            }
            else {
                show(text, duration);
            }
        }
    }

    model: ListModel {id: model}
}
