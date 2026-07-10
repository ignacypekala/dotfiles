import QtQuick
import "../config.js" as Config

Text {
    property bool isIcon: false

    color: Config.bar.colors.fg
    font.family: isIcon ? Config.fonts.nerd : Config.fonts.ui;
    font.weight: 500;
    font.pointSize: 12;
    verticalAlignment: Text.AlignVCenter
}
