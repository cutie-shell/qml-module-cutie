import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import Cutie

Button {
	id: root
	width: parent.width
	height: contentItem.height + 25
	property string subText: ""
	property bool iconOverlay: true
	property CutieMenu menu
	padding: 15
	bottomPadding: 10
	icon.width: 20
	icon.height: 20

	onPressAndHold: {
		if (menu) {
        	CutieFeedback.trigger(Application.name, "button-pressed", {}, -1);
			menu.open();
		}
	}

    onClicked: {
        CutieFeedback.trigger(Application.name, "button-pressed", {}, -1);
    }

	background: CutieTile {
		anchors.fill: parent
		anchors.topMargin: 5
		anchors.leftMargin: 10
		anchors.rightMargin: 10
		opacity: highlighted || pressed ? 1.0 : 0.0
	}

	contentItem: RowLayout {
		spacing: 15
		anchors.left: parent.left
		anchors.right: parent.right
		anchors.leftMargin: 30
		anchors.rightMargin: 30
		height: Math.max(iconItem.height, textCol.height)
		Item {
			id: iconItem
			width: iconImage.status == Image.Ready ? iconImage.width : 0
			height: width
			Image {
				id: iconImage
				width: root.icon.width
				height: root.icon.height
				source: root.icon.source
				fillMode: Image.PreserveAspectFit
				sourceSize.width: width
				sourceSize.height: height
				visible: !root.iconOverlay
			}

			ColorOverlay {
				anchors.fill: iconImage
				source: iconImage
				color: Atmosphere.textColor
				visible: root.iconOverlay
			}
		}

		ColumnLayout {
			id: textCol
        		Layout.fillWidth: true
			Text {
				id: mainTextItem
				text: root.text
				font.pixelSize: 15
				font.family: "Lato"
				color: Atmosphere.textColor
        			Layout.fillWidth: true
				wrapMode: Text.Wrap
			}
			Text {
				id: subTextItem
				text: root.subText
				visible: root.subText !== ""
				font.pixelSize: 10
				font.family: "Lato"
				color: Atmosphere.textColor
        			Layout.fillWidth: true
				wrapMode: Text.Wrap
			}
		}
	}
}