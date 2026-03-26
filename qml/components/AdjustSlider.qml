import QtQuick 2.0
import Sailfish.Silica 1.0

Item {
    id: root

    property alias value: slider.value
    property real defaultValue: 1
    property real minimumValue: 0.5
    property real maximumValue: 2

    Slider {
        id: slider

        anchors.left: parent.left
        anchors.right: resetButton.left
        anchors.verticalCenter: parent.verticalCenter
        label: ""
        minimumValue: root.minimumValue
        maximumValue: root.maximumValue
    }

    IconButton {
        id: resetButton

        anchors.right: parent.right
        anchors.rightMargin: Theme.paddingMedium
        anchors.verticalCenter: parent.verticalCenter
        icon.source: "image://theme/icon-m-refresh"
        onClicked: {
            slider.value = root.defaultValue;
        }
    }

}
