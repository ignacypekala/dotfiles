import Quickshell
import QtQuick.Layouts
import QtQuick
import Quickshell.Hyprland
import "../palette.js" as Palette

Rectangle {
    // color: Palette.color.neutral[700]
    color: "transparent"
    implicitWidth: row.implicitWidth + 30
    implicitHeight: row.implicitHeight + 8
    radius: 15
    
    RowLayout {
        anchors.fill: parent
        spacing: 0

        id: row
        Repeater {
            model: {
                const workspaces = Hyprland.workspaces.values;
                let filtered = [];
                for (let i = 0; i < workspaces.length; i++) {
                    const workspace = workspaces[i];
                    if (workspace.monitor == null || workspace.monitor.name == screen.name) {
                        filtered.push(workspaces[i]);
                    }
                }
                return filtered
            }
            delegate: Workspace {
                required property var modelData
                workspace: modelData

                Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
            }
        }
    }
}
