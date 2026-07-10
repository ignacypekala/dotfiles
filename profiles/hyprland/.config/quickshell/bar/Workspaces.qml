import Quickshell
import QtQuick.Layouts
import QtQuick
import Quickshell.Hyprland
import "../palette.js" as Palette

Item {
    implicitWidth: row.implicitWidth

    RowLayout {
        id: row
        anchors.fill: parent
        spacing: 5

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
                Layout.fillHeight: true
                Layout.preferredWidth: {
                    return height
                }
            }
        }
    }
}
