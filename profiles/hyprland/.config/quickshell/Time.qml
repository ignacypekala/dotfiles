pragma Singleton

import Quickshell
import QtQuick

Singleton {
    readonly property string time: {
        Qt.formatDateTime(clock.date, "hh:mm")
    }
    readonly property string date: {
        // Qt.formatDate(clock.date, "ddd, dd MMM yyyy")
        Qt.formatDate(clock.date, "dd/MM/yyyy")
    }
    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }
}

