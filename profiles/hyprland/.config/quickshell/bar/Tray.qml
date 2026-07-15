import Quickshell
import Quickshell.Services.SystemTray
import QtQuick.Layouts
import QtQuick

RowLayout {
    spacing: 5

    property string tooltipText: ""
    property bool tooltipVisible: false
    BarText {
        id: tooltipLabel
        text: tooltipText
    }
    Item { Layout.fillHeight: true; Layout.preferredWidth: 5 }

    Repeater {
        model: {
            SystemTray.items.values
        }
        delegate: TrayItem {
            required property var modelData
            item: modelData

            Layout.fillHeight: true
            Layout.preferredWidth: height

            onTooltipRequested: text => {
                tooltipText = text
                tooltipVisible = true
            }

            onTooltipCleared: {
                tooltipVisible = false
                tooltipText = ""
            }
        }
    }
}
