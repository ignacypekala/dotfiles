import Quickshell
import Quickshell.Hyprland
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Window
import Quickshell.Services.SystemTray
import QtQuick
import "../palette.js" as Palette
import "../config.js" as Config

MouseArea {
    id: area
    required property SystemTrayItem item

    signal tooltipRequested(text: string)
    signal tooltipCleared()

    hoverEnabled: true
    acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton

    QsMenuAnchor {
        id: menuAnchor
        menu: item.menu
        anchor {
            item: area
            edges: Edges.Bottom | Edges.Right
            gravity: Edges.Bottom | Edges.Left
        }
    }

    TrayIcon {
        id: icon
        anchors.fill: parent
        sourceUrl: item.icon
    }

    Rectangle {
        visible: item.status === Status.NeedsAttention
        implicitWidth: 8
        implicitHeight: 8
        radius: 4
        color: Palette.color.base.red

        anchors {
            top: parent.top
            left: parent.left
        }
    }

    onEntered: {
        tooltipAppearTimer.running = true
    }
    Timer {
        id: tooltipAppearTimer
        interval: 500
        running: false
        repeat: true
        onTriggered: {
            tooltipRequested(item.tooltipTitle || item.title)
        }
    }
    onExited: {
        tooltipCleared()
        tooltipAppearTimer.running = false
    }

    onClicked: mouse => {
        switch (mouse.button) {
            case Qt.LeftButton:
                item.activate()
                break
            case Qt.MiddleButton:
                item.secondaryActivate()
                break
            case Qt.RightButton:
                menuAnchor.open()
                break
        }
    }
}
