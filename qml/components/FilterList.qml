import QtQuick 2.0
import Sailfish.Silica 1.0

SilicaListView {
    id: root

    property int currentFilter: 0

    orientation: ListView.Horizontal
    spacing: Theme.paddingLarge
    clip: true

    model: ListModel {
        ListElement {
            name: qsTr("None")
            filterType: 0
        }

        ListElement {
            name: qsTr("Grayscale")
            filterType: 1
        }

        ListElement {
            name: qsTr("Negative")
            filterType: 2
        }

        ListElement {
            name: qsTr("Solarize")
            filterType: 3
        }

        ListElement {
            name: qsTr("Whiteboard")
            filterType: 4
        }

        ListElement {
            name: qsTr("Blackboard")
            filterType: 5
        }

        ListElement {
            name: qsTr("Yellow on black")
            filterType: 6
        }

        ListElement {
            name: qsTr("Black on yellow")
            filterType: 7
        }

        ListElement {
            name: qsTr("Yellow on blue")
            filterType: 8
        }

        ListElement {
            name: qsTr("Blue on yellow")
            filterType: 9
        }

        ListElement {
            name: qsTr("White on blue")
            filterType: 10
        }

        ListElement {
            name: qsTr("Blue on white")
            filterType: 11
        }

        ListElement {
            name: qsTr("Red on black")
            filterType: 12
        }

        ListElement {
            name: qsTr("Black on red")
            filterType: 13
        }

    }

    delegate: BackgroundItem {
        width: filterLabel.width + Theme.paddingLarge * 2
        height: root.height
        onClicked: root.currentFilter = filterType

        Label {
            id: filterLabel

            anchors.centerIn: parent
            text: name
            color: root.currentFilter === filterType ? Theme.highlightColor : Theme.primaryColor
        }

    }

}
