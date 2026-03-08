import "../components"
import QtMultimedia 5.6
import QtQuick 2.0
import Sailfish.Silica 1.0

Page {

    id: mainPage

    property int currentFilter: CameraImageProcessing.ColorFilterNone

    function syncCameraSettings() {
        camera.flash.mode = camera.isFlashOn ? Camera.FlashTorch : Camera.FlashOff;
        filterDelay.restart();
    }

    allowedOrientations: Orientation.Portrait

    Camera {
        id: camera

        property bool isFlashOn: false

        captureMode: Camera.CaptureVideo
        viewfinder.resolution: "1920x1080"
        onCameraStatusChanged: {
            if (cameraStatus === Camera.ActiveStatus)
                syncCameraSettings();

        }

        focus {
            focusMode: Camera.FocusContinuous
        }

    }

    Timer {
        id: filterDelay

        interval: 150
        repeat: false
        onTriggered: {
            camera.imageProcessing.colorFilter = CameraImageProcessing.ColorFilterNone;
            camera.imageProcessing.colorFilter = mainPage.currentFilter;
        }
    }

    SilicaFlickable {
        anchors.fill: parent
        contentHeight: parent.height

        PushUpMenu {
            MenuItem {
                text: qsTr("About")
                onClicked: {
                    pageStack.push(Qt.resolvedUrl("AboutPage.qml"));
                }
            }

        }

        VideoOutput {
            // 'PreserveAspectCrop' ensures the screen is fully covered
            // without stretching the image

            id: viewfinder

            source: camera
            anchors.fill: parent
            fillMode: VideoOutput.PreserveAspectCrop
        }

        Rectangle {
            // Height adjusts based on the content inside (the Column)
            // Semi-transparent dark background

            id: controlOverlay

            anchors.bottom: parent.bottom
            width: parent.width
            height: controlsColumn.height + (Theme.paddingLarge * 2)
            color: Theme.rgba(Theme.overlayBackgroundColor, 0.6)

            Column {
                id: controlsColumn

                width: parent.width
                spacing: Theme.paddingMedium
                anchors.bottom: parent.bottom
                anchors.bottomMargin: Theme.paddingLarge
                anchors.topMargin: Theme.paddingLarge

                ComboBox {
                    width: parent.width
                    label: qsTr("Filter")
                    labelColor: Theme.primaryColor

                    menu: ContextMenu {
                        MenuItem {
                            text: qsTr("None")
                            onClicked: {
                                currentFilter = CameraImageProcessing.ColorFilterNone;
                                syncCameraSettings();
                            }
                        }

                        MenuItem {
                            text: qsTr("Black and white")
                            onClicked: {
                                currentFilter = CameraImageProcessing.ColorFilterGrayscale;
                                syncCameraSettings();
                            }
                        }

                        MenuItem {
                            text: qsTr("Negative")
                            onClicked: {
                                currentFilter = CameraImageProcessing.ColorFilterNegative;
                                syncCameraSettings();
                            }
                        }

                        MenuItem {
                            text: qsTr("Whiteboard")
                            onClicked: {
                                currentFilter = CameraImageProcessing.ColorFilterWhiteboard;
                                syncCameraSettings();
                            }
                        }

                        MenuItem {
                            text: qsTr("Blackboard")
                            onClicked: {
                                currentFilter = CameraImageProcessing.ColorFilterBlackboard;
                                syncCameraSettings();
                            }
                        }

                    }

                }

                Slider {
                    id: zoomSlider

                    width: parent.width - (Theme.paddingSmall * 2)
                    label: "Zoom: " + value.toFixed(1) + "x"
                    minimumValue: 1
                    maximumValue: camera.maximumDigitalZoom > 1 ? camera.maximumDigitalZoom : 4
                    value: 1
                    onValueChanged: {
                        camera.digitalZoom = value;
                    }
                }

                Row {
                    id: controlsRow

                    property real itemWidth: width / 3

                    width: parent.width
                    anchors.horizontalCenter: parent.horizontalCenter
                    height: Theme.itemSizeLarge

                    Item {
                        width: controlsRow.itemWidth
                        height: parent.height

                        IconButton {
                            anchors.centerIn: parent
                            icon.width: Theme.iconSizeLarge
                            icon.height: Theme.iconSizeLarge
                            icon.source: "image://theme/icon-m-remove"
                            icon.color: pressed ? Theme.highlightColor : Theme.primaryColor
                            onClicked: {
                                var step = (zoomSlider.maximumValue - zoomSlider.minimumValue) / 4;
                                zoomSlider.value = Math.max(zoomSlider.minimumValue, zoomSlider.value - step);
                            }
                        }

                    }

                    Item {
                        width: controlsRow.itemWidth
                        height: parent.height

                        IconButton {
                            id: flashButton

                            anchors.centerIn: parent
                            icon.source: camera.isFlashOn ? "image://theme/icon-camera-flash-on" : "image://theme/icon-camera-flash-off"
                            icon.color: pressed ? Theme.highlightColor : Theme.primaryColor
                            icon.width: Theme.iconSizeLarge
                            icon.height: Theme.iconSizeLarge
                            onClicked: {
                                camera.isFlashOn = !camera.isFlashOn;
                                syncCameraSettings();
                            }
                        }

                    }

                    Item {
                        width: controlsRow.itemWidth
                        height: parent.height

                        IconButton {
                            anchors.centerIn: parent
                            icon.width: Theme.iconSizeLarge
                            icon.height: Theme.iconSizeLarge
                            icon.source: "image://theme/icon-m-add"
                            icon.color: pressed ? Theme.highlightColor : Theme.primaryColor
                            anchors.verticalCenter: parent.verticalCenter
                            onClicked: {
                                var step = (zoomSlider.maximumValue - zoomSlider.minimumValue) / 4;
                                zoomSlider.value = Math.min(zoomSlider.maximumValue, zoomSlider.value + step);
                            }
                        }

                    }

                }

            }

        }

        Connections {
            target: Qt.application
            onActiveChanged: {
                if (Qt.application.active) {
                    camera.start();
                } else {
                    camera.stop();
                    camera.isFlashOn = false;
                }
            }
        }

    }

}
