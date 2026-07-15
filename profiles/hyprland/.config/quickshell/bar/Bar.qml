import Quickshell;
import Quickshell.Wayland
import QtQuick;
import QtQuick.Layouts;
import "../config.js" as Config;
import "../palette.js" as Palette;


PanelWindow {
    id: root;

    anchors {
        top: true;
        left: true;
        right: true;
    }

    implicitHeight: 40;
    color: Config.bar.colors.bg;

    surfaceFormat.opaque: false;

    Item {
        anchors.fill: parent;

        RowLayout {
            id: barLeft

            anchors {
                left: parent.left
                top: parent.top
                bottom: parent.bottom
                leftMargin: 10
            }

            Layout.margins: {
                left: 10
            }

            Clock {
                id: clock
                Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft;
                verticalAlignment: Text.AlignVCenter;
            }

            Date {
                Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft;
            }
        }

        RowLayout {
            id: barMiddle

            anchors {
                top: parent.top
                bottom: parent.bottom
                horizontalCenter: parent.horizontalCenter
                leftMargin: 10
                rightMargin: 10
            }

            Layout.margins: {
                left: 10
                right: 10
            }

            Workspaces {
                Layout.fillHeight: true
            }
        }

        RowLayout {
            id: barRight

            anchors {
                top: parent.top
                bottom: parent.bottom
                right: parent.right
                rightMargin: 10
            }

            spacing: 5

            Tray {
                Layout.margins: {
                    top: 12
                    bottom: 12
                }
            }
        }
    }
}
