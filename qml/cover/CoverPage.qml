import QtQuick 2.0
import Sailfish.Silica 1.0

CoverBackground {
    Image {
        id: coverimg

        fillMode: Image.PreserveAspectFit
        source: isLightTheme ? "../../images/cover-bg-dark.png" : "../../images/cover-bg-light.png"
        opacity: 0.1
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width
        height: sourceSize.height * width / sourceSize.width
    }

}
