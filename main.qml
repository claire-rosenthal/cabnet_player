import QtQuick
// import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.VectorImage

import mpvtest 1.0

ApplicationWindow {
    id: root
    visible: true
    width: 1200
    height: 800
    flags: Qt.Window | Qt.FramelessWindowHint

    color: "#000000"

    menuBar: Rectangle {
        id: titlebar

        height: 30
        color: "#0F0F0F"

        VectorImage {
            id: titlebar_logo
            width: 23
            height: 11
            source: "qrc:///assets/icons/cabnet_logo_pink.svg"

            fillMode: VectorImage.PreserveAspectFit

            preferredRendererType: VectorImage.CurveRenderer

            anchors.left: parent.left
            anchors.leftMargin: 6
            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            id: cabnet_player_logo
            text: "Cabnet Player"
            font.family: "Outfit"
            font.pointSize: 12
            font.weight: Font.DemiBold
            color: "#FFFFFF"

            anchors.left: titlebar_logo.right
            anchors.leftMargin: 5
            anchors.verticalCenter: parent.verticalCenter
        }

        Rectangle {
            id: button_close
            width: 26
            height: 26
            color: titlebar.color
            border.color: "#8F8F8F"
            border.width: button_close_mouse_area.containsMouse ? 1 : 0 // shows the border during mouse hover

            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 5

            VectorImage  {
                id: button_close_image
                source: "qrc:///assets/icons/close_24dp_FFFFFF_FILL0_wght300_GRAD0_opsz24.svg"
                width: 18
                height: 18
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }

            // Technically this functionality is inside the qml, but since it's basic window functionaly, I'd consider
            // it existing more in the view space than in the model space.
            MouseArea {
                id: button_close_mouse_area
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    root.close()
                }
            }
        }

        Rectangle {
            id: button_maximize
            width: 26
            height: 26
            color: titlebar.color
            border.color: "#8F8F8F"
            border.width: button_maximize_mouse_area.containsMouse ? 1 : 0 // shows the border during mouse hover

            anchors.verticalCenter: parent.verticalCenter
            anchors.right: button_close.left

            VectorImage  {
                id: button_maximize_image
                source: "qrc:///assets/icons/ad_24dp_FFFFFF_FILL0_wght300_GRAD0_opsz24.svg"
                width: 18
                height: 18
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }

            // Technically this functionality is inside the qml, but since it's basic window functionaly, I'd consider
            // it existing more in the view space than in the model space.
            MouseArea {
                id: button_maximize_mouse_area
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    root.showMaximized()
                }
            }
        }

        Rectangle {
            id: button_minimize
            width: 26
            height: 26
            color: titlebar.color
            border.color: "#8F8F8F"
            border.width: button_minimize_mouse_area.containsMouse ? 1 : 0 // shows the border during mouse hover

            anchors.verticalCenter: parent.verticalCenter
            anchors.right: button_maximize.left

            VectorImage  {
                id: button_minimize_image
                source: "qrc:///assets/icons/minimize_24dp_FFFFFF_FILL0_wght300_GRAD0_opsz24.svg"
                width: 18
                height: 18
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }

            // Technically this functionality is inside the qml, but since it's basic window functionaly, I'd consider
            // it existing more in the view space than in the model space.
            MouseArea {
                id: button_minimize_mouse_area
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    root.showMinimized()
                }
            }
        }


        DragHandler {
            id: tool_drag_handler
            target: null
            onActiveChanged: {
                if (active) root.startSystemMove()
            }
        }
    }

    // since the header is below the menubar on the Application Window,
    // menuBar is type ToolBar and header is type MenuBar :3
    header: MenuBar {
        id: menu_bar

        delegate: MenuBarItem {
            id: menu_bar_item

            background: Rectangle {
                id: menu_bar_rect
                implicitWidth: 40
                implicitHeight: 20
                opacity: enabled ? 1 : 0.3
                color: "transparent"
                border.width: menu_bar_item.highlighted ? 1 : 0
                border.color: "#8F8F8F"
            }
        }

        background: Rectangle {
            color: "#000000"
        }

        CabnetPlayerMenu {
            title: qsTr("&App")
            Action { text: qsTr("&About") }
            MenuSeparator {
                contentItem: Rectangle {
                    implicitWidth: 200
                    implicitHeight: 1
                    color: "#6F6F6F"
                }
            }
            Action { text: qsTr("&Quit") }
        }

        CabnetPlayerMenu {
            title: qsTr("&Media")
            Action { text: qsTr("&Open File") }
            Action { text: qsTr("&Info") }
            Action { text: qsTr("&Screenshot") }
        }

        CabnetPlayerMenu {
            title: qsTr("&Tracks")
            Action { text: qsTr("&Audio") }
            Action { text: qsTr("&Subtitles") }
        }

        CabnetPlayerMenu {
            title: qsTr("&Settings")
            Action { text: qsTr("&Account") }
            Action { text: qsTr("&Player") }
            Action { text: qsTr("&Downloads") }
        }

        CabnetPlayerMenu {
            title: qsTr("&View")
            Action { text: qsTr("&Cabinet") }
            Action { text: qsTr("&Player") }
            Action { text: qsTr("&Downloads") }
            Action { text: qsTr("&Settings") }
        }

        CabnetPlayerMenu {
            title: qsTr("&Help")
            Action { text: qsTr("&Search Menus") }
            Action { text: qsTr("&Documentation") }
            Action { text: qsTr("&Codebase") }
            Action { text: qsTr("&Contact") }
        }
    }


    StackView {
        anchors.fill: parent
        // this is the video player view
        initialItem: Page {
            background: Rectangle {
                anchors.fill: parent
                color: "#000000"
            }

            Rectangle {
                id: timecode_section_box
                height: 40
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom

                color: "#000000"

                // container for timecode
                Item {
                    id: timecode_container
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.horizontalCenterOffset: -20
                    anchors.verticalCenter: parent.verticalCenter

                    // hour digit large
                    TimecodeText {
                        id: timecode_text_hour_digit_large
                        text: "0"

                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: timecode_text_hour_digit_small.left
                    }

                    // hour digit small
                    TimecodeText  {
                        id: timecode_text_hour_digit_small
                        text: "0"

                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: timecode_text_hour_minute_separator.left
                    }

                    // hour:minute colon
                    TimecodeText {
                        id: timecode_text_hour_minute_separator
                        text: ":"
                        width: 9

                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: timecode_text_minute_digit_large.left
                    }

                    // minute digit large
                    TimecodeText {
                        id: timecode_text_minute_digit_large
                        text: "0"

                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: parent.left
                    }

                    // minite digit small
                    TimecodeText {
                        id: timecode_text_minute_digit_small
                        text: "4"

                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.right
                    }

                    // minute:second separator
                    TimecodeText {
                        id: timecode_text_minute_second_separator
                        text: ":"
                        width: 9

                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: timecode_text_minute_digit_small.right
                    }

                    // second digit large
                    TimecodeText {
                        id: timecode_text_second_digit_large
                        text: "0"

                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: timecode_text_minute_second_separator.right
                    }

                    // second digit small
                    TimecodeText {
                        id: timecode_text_second_digit_small
                        text: "4"

                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: timecode_text_second_digit_large.right
                    }

                    // second:frame separator
                    TimecodeText {
                        id: timecode_text_second_frame_separator
                        text: ":"
                        font.pointSize: 13
                        width: 6

                        anchors.baseline: timecode_text_second_digit_small.baseline
                        anchors.left: timecode_text_second_digit_small.right
                    }

                    // second:frame separator
                    TimecodeText {
                        id: timecode_text_frame_digit_large
                        text: "1"
                        font.pointSize: 13
                        width: 10

                        anchors.verticalCenter: timecode_text_second_frame_separator.verticalCenter
                        anchors.left: timecode_text_second_frame_separator.right
                    }

                    // second:frame separator
                    TimecodeText {
                        id: timecode_text_frame_digit_small
                        text: "3"
                        font.pointSize: 13
                        width: 10

                        anchors.verticalCenter: timecode_text_frame_digit_large.verticalCenter
                        anchors.left: timecode_text_frame_digit_large.right
                    }
                }

                Rectangle {
                    id: caption_box
                    width: 30
                    height: 30
                    color: "#000000"
                    border.color: "#8F8F8F"
                    border.width: caption_box_mouse_area.containsMouse ? 1 : 0 // shows the border during mouse hover

                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenterOffset: -105
                    anchors.horizontalCenter: timecode_container.horizontalCenter

                    VectorImage  {
                        id: caption_icon
                        source: "qrc:///assets/icons/closed_caption_24dp_FFFFFF_FILL0_wght100_GRAD0_opsz24.svg"
                        width: 24
                        height: 24
                        preferredRendererType: VectorImage.GeometryRenderer
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    MouseArea {
                        id: caption_box_mouse_area
                        anchors.fill: parent
                        hoverEnabled: true
                    }
                }

                Rectangle {
                    id: audio_track_box
                    width: 30
                    height: 30
                    color: "#000000"
                    border.color: "#8F8F8F"
                    border.width: audio_track_mouse_area.containsMouse ? 1 : 0 // shows the border during mouse hover

                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: caption_box.left
                    anchors.rightMargin: 30

                    VectorImage  {
                        id: audio_track_icon
                        source: "qrc:///assets/icons/audio_track_24dp_FFFFFF_FILL0_wght200_GRAD0_opsz24.svg"
                        width: 24
                        height: 24
                        preferredRendererType: VectorImage.GeometryRenderer
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    MouseArea {
                        id: audio_track_mouse_area
                        anchors.fill: parent
                        hoverEnabled: true
                    }
                }

                Rectangle {
                    id: volume_icon_box
                    width: 30
                    height: 30
                    color: "#000000"
                    border.color: "#8F8F8F"
                    border.width: volume_icon_mouse_area.containsMouse ? 1 : 0 // shows the border during mouse hover

                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenterOffset: 130
                    anchors.horizontalCenter: timecode_container.horizontalCenter

                    VectorImage  {
                        id: volume_icon
                        source: "qrc:///assets/icons/volume_up_24dp_FFFFFF_FILL0_wght200_GRAD0_opsz24.svg"
                        width: 24
                        height: 24
                        preferredRendererType: VectorImage.GeometryRenderer

                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter

                    }

                    MouseArea {
                        id: volume_icon_mouse_area
                        anchors.fill: parent
                        hoverEnabled: true
                    }
                }

                Rectangle {
                    id: fulscreen_icon_box
                    width: 30
                    height: 30
                    color: "#000000"
                    border.color: "#8F8F8F"
                    border.width: fulscreen_icon_mouse_area.containsMouse ? 1 : 0 // shows the border during mouse hover

                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: volume_icon_box.right
                    anchors.leftMargin: 30

                    VectorImage  {
                        id: fullscreen_icon
                        source: "qrc:///assets/icons/fullscreen_24dp_FFFFFF_FILL0_wght200_GRAD0_opsz24.svg"
                        width: 24
                        height: 24
                        preferredRendererType: VectorImage.GeometryRenderer
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    MouseArea {
                        id: fulscreen_icon_mouse_area
                        anchors.fill: parent
                        hoverEnabled: true
                    }
                }
            }

            Rectangle {
                id: scubbing_bar_section_box
                height: 20
                color: "#000000"
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: timecode_section_box.top

                Rectangle {
                    id: play_button_box
                    width: 30
                    height: 30
                    color: "#000000"
                    border.color: "#8F8F8F"
                    border.width: play_button_box_mouse_area.containsMouse ? 1 : 0 // shows the border during mouse hover

                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left

                    VectorImage {
                        id: play_button_icon
                        width: 30
                        height: 30
                        source: "qrc:///assets/icons/play_arrow_24dp_FFFFFF_FILL1_wght300_GRAD0_opsz24.svg"
                        preferredRendererType: VectorImage.CurveRenderer
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.verticalCenter
                    }

                    MouseArea {
                        id: play_button_box_mouse_area
                        anchors.fill: parent
                        hoverEnabled: true
                    }
                }

                Image {
                    id: ponyo_barcode_image
                    height: 8
                    source: "qrc:/assets/images/ponyo_barcode_fps1-48.png"
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: play_button_box.right
                    anchors.right: parent.right
                }

                Rectangle {
                    id: scrubbing_marker
                    height: 20
                    width: 5
                    color: "#FFFFFF"
                    radius: 5
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.horizontalCenterOffset: -200
                }
            }
        }
    }


    // MpvObject {
    //     id: renderer
    //     anchors.fill: parent

    //     MouseArea {
    //         anchors.fill: parent
    //         onClicked: renderer.command(["loadfile", "ponyo.mp4"])
    //     }
    // }

    // Rectangle {
    //     id: labelFrame
    //     anchors.margins: -50
    //     radius: 5
    //     color: "white"
    //     border.color: "black"
    //     opacity: 0.8
    //     anchors.fill: box
    // }

    // Row {
    //     id: box
    //     anchors.bottom: renderer.bottom
    //     anchors.left: renderer.left
    //     anchors.right: renderer.right
    //     anchors.margins: 100

    //     Text {
    //         anchors.margins: 10
    //         wrapMode: Text.WordWrap
    //         text: "QtQuick and mpv are both rendering stuff.\n
    //                Click to load test.mkv"
    //     }

    //     // Don't take these controls too seriously. They're for testing.
    //     Column {
    //         CheckBox {
    //             id: checkbox
    //             anchors.margins: 10
    //             // Heavily filtered means good, right?
    //             text: "Make video look like on a Smart TV"
    //             onClicked: {
    //                 if (checkbox.checked) {
    //                     renderer.setProperty("sharpen", 5.0)
    //                 } else {
    //                     renderer.setProperty("sharpen", 0)
    //                 }
    //             }
    //         }
    //         Slider {
    //             id: slider
    //             anchors.margins: 10
    //             anchors.left: checkbox.left
    //             anchors.right: checkbox.right
    //             from: -100
    //             to:  100
    //             value: 0
    //             onValueChanged: renderer.setProperty("gamma", slider.value | 0)
    //         }
    //     }

    //     Button {
    //         id: pause_button
    //         text: "pause / play"
    //         onClicked: renderer.command(["cycle", "pause"])
    //     }
    // }
}
