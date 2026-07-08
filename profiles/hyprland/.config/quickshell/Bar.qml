import Quickshell;
import QtQuick;
import QtQuick.Layouts;
import "config.js" as Config;
import "palette.js" as Palette;

PanelWindow {
    anchors {
        top: true;
        left: true;
        right: true;
    }

    margins {
        top: 0;
        left: 0;
        right: 0;
        bottom: -5;
    }


    implicitHeight: 40;
    color: Config.bar.colors.bg;


    RowLayout {
        anchors.fill: parent;

        Rectangle {
            id: barLeft
            Layout.fillHeight: true
            Layout.fillWidth: true
            color: Palette.color.base.green

            Text {
                anchors.fill: parent;

                text: barLeft.width;
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }
        }

        Rectangle {
            id: barMiddle
            Layout.fillHeight: true
            Layout.fillWidth: true
            color: Palette.color.base.blue
            Text {
                anchors.fill: parent;

                text: barLeft.width;
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }
        }

        Rectangle {
            id: barRight
            Layout.fillHeight: true
            Layout.fillWidth: true
            color: Palette.color.base.red
            Text {
                anchors.fill: parent;

                text: barLeft.width;
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }
        }
    }
}
