import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15
import Cutie 1.0

Label {
    id: labelText
    z: 3
    text: root.text
    font.pixelSize: 3 * dpi.value
    font.family: "Lato"
    color: (themeVariantConfig.value == "dark") ? "#ffffff" : "#000000"
    clip: truncationMode != CutieTruncationMode.None
    property int truncationMode: CutieTruncationMode.None
}
