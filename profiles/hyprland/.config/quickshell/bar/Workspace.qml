import Quickshell
import QtQuick.Layouts
import QtQuick
import Quickshell.Hyprland
import "../config.js" as Config
import "../palette.js" as Palette


Item {
    id: root
    required property HyprlandWorkspace workspace

    enum State {
        ACTIVE,
        FOCUSED,
        INACTIVE
    }

    readonly property int state: {
        console.log(workspace.name, workspace.active, workspace.focused, Workspace.State.FOCUSED)
        if (workspace.active) {
            if (workspace.focused) {
                return Workspace.State.FOCUSED;
            } 
            return Workspace.State.ACTIVE;
        } 
        return Workspace.State.INACTIVE;
    }

    Item {
        anchors.fill: parent
        
        BarText {
            id: tile
            anchors.fill: parent
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter

            isIcon: workspace.id < 0

            text: {
                if (workspace.id < 0) {
                    if (workspace.name == "game") {
                        return "󰮂 "
                    }
                } else {
                    return workspace.name
                }
            }
        }
        Rectangle {
            implicitHeight: 3
            color: {
                switch (root.state) {
                    case Workspace.State.FOCUSED:
                        return Palette.color.ui.accent_primary
                    case Workspace.State.ACTIVE:
                        return Palette.color.neutral[400]
                    default:
                        return Palette.color.neutral[600]
                }
            }
            anchors {
                left: parent.left
                right: parent.right
                bottom: parent.bottom
            }
        }
    }
}
