import Quickshell
import QtQuick

Scope {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            // Injecting screen info?
            required property var modelData
            screen: modelData

            anchors {
                top: true
                left: true
                right: true
            }

            implicitHeight: 30

            ClockWidget {
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                // anchors.right: parent
            }
        }
    }
}
