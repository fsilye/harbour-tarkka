import QtQuick 2.0
import Sailfish.Silica 1.0

Slider {
    id: root

    property string customLabelText: ""

    label: ""

    Label {
        id: customLabel

        text: root.customLabelText
        color: root.down ? Theme.highlightColor : Theme.lightPrimaryColor
        font.pixelSize: Theme.fontSizeExtraSmall

        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
        }

    }

    Rectangle {
        id: backgroundRect

        z: -1
        radius: height / 2
        color: Theme.darkPrimaryColor
        opacity: root.down ? 0.6 : 0.4
        scale: root.down ? 1.05 : 1

        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            bottom: customLabel.bottom
            leftMargin: Theme.paddingLarge
            rightMargin: Theme.paddingLarge
            topMargin: Theme.paddingMedium
            bottomMargin: -Theme.paddingMedium
        }

        Behavior on opacity {
            NumberAnimation {
                duration: 150
            }

        }

        Behavior on scale {
            NumberAnimation {
                duration: 150
                easing.type: Easing.InOutQuad
            }

        }

    }

}
