import QtMultimedia 5.6
import QtQuick 2.0
import Sailfish.Silica 1.0

Rectangle {
    id: root

    property var cameraObj

    function showAt(touchX, touchY) {
        root.x = touchX - (root.width / 2);
        root.y = touchY - (root.height / 2);
        root.visible = true;
        focusTimer.restart();
    }

    width: Theme.itemSizeMedium
    height: Theme.itemSizeMedium
    color: "transparent"
    border.color: Theme.highlightColor
    border.width: 4
    radius: width / 2
    visible: false

    Timer {
        id: focusTimer

        interval: 1500
        onTriggered: {
            root.visible = false;
            if (root.cameraObj) {
                console.log("Unlock focus");
                root.cameraObj.unlock();
            }
        }
    }

}
