import Quickshell
import "bar" as Bar

Scope {
    Variants {
        model: Quickshell.screens

        delegate: Bar.Bar {
            required property var modelData
            screen: modelData
        }
    }
}
