import QtQuick 2.0
import Sailfish.Silica 1.0
import "pages"

ApplicationWindow {
    property bool isLightTheme: (Theme.colorScheme === Theme.LightOnDark) ? false : true

    cover: Qt.resolvedUrl("cover/CoverPage.qml")
    allowedOrientations: defaultAllowedOrientations

    initialPage: Component {
        MainPage {
        }

    }

}
