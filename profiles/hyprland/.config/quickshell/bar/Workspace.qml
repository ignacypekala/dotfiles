import Quickshell
import QtQuick.Layouts
import QtQuick
import Quickshell.Hyprland
import "../config.js" as Config
import "../palette.js" as Palette


Item {
    required property HyprlandWorkspace workspace

    implicitWidth: 30
    
    BarText {
        id: tile
        anchors {
            top: parent.top
            bottom: parent.bottom
        }
        isIcon: workspace.id < 0

        verticalAlignment: Text.AlignVCenter
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
}
