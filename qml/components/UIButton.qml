import QtQuick 2.0
import Sailfish.Silica 1.0

IconButton {
    id: control

    property real circleBorderWidth: 0
    property color circleBorderColor: "transparent"
    property real backgroundSize: icon.width + Theme.paddingMedium

    visible: !mainPage.isFrozen
    icon.width: Theme.iconSizeLarge
    icon.height: Theme.iconSizeLarge
    anchors.verticalCenter: parent.verticalCenter
    icon.color: pressed ? Theme.lightSecondaryColor : Theme.lightPrimaryColor
    opacity: enabled ? 1 : 0.3

    Rectangle {
        anchors.centerIn: parent
        width: control.backgroundSize
        height: width
        radius: width / 2
        color: Theme.darkPrimaryColor
        border.width: control.circleBorderWidth
        border.color: control.circleBorderColor
        z: -1
        opacity: control.pressed ? 0.6 : 0.4
        scale: control.pressed ? 1.05 : 1

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
