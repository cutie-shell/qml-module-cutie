import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.15
import Cutie 1.0

MenuItem {
	id: root
	width: parent.width
	padding: 15
	bottomPadding: 10

	background: CutieTile {
		anchors.fill: parent
		anchors.topMargin: 5
		anchors.leftMargin: 10
		anchors.rightMargin: 10
		opacity: highlighted || pressed ? 1.0 : 0.0
		color: (Atmosphere.variant == "dark") ? "#5c000000" : "#5cffffff"
	}

	contentItem: RowLayout {
		spacing: 15
		anchors.fill: parent
		anchors.leftMargin: 30
		anchors.rightMargin: 30
		anchors.topMargin: 15
		anchors.bottomMargin: 15
		Item {
			width: iconImage.status == Image.Ready ? 20 : 0
			height: width
			Image {
				id: iconImage
				anchors.fill: parent
				source: root.icon.source
				fillMode: Image.PreserveAspectFit
				sourceSize.width: parent.width
				sourceSize.height: parent.height
				visible: false
			}

			ColorOverlay {
				anchors.fill: iconImage
				source: iconImage
				color: (Atmosphere.variant == "dark") ? "#000000" : "#ffffff"
			}
		}

		ColumnLayout {
        		Layout.fillWidth: true
			Text {
				text: root.text
				font.pixelSize: 15
				font.family: "Lato"
				color: (Atmosphere.variant == "dark") ? "black" : "white"
        			Layout.fillWidth: true
			}
		}
	}
}