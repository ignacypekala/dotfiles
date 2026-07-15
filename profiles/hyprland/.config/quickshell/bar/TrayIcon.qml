import Quickshell
import QtQuick.Layouts
import Quickshell.Services.SystemTray
import QtQuick

Image {
    required property string sourceUrl
    source: sourceUrl
    sourceSize {
        width: 64
        height: 64
    }
}
