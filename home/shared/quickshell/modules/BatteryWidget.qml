import Quickshell.Services.UPower
import QtQuick
import QtQuick.Layouts
import "colors.js" as Colors

// Battery module - uses UPower service
Item {
    id: root
    implicitHeight: 22
    height: 22
    implicitWidth: childrenRect.width

    property bool present: false
    property double pct: 0
    property bool charging: false

    visible: present

    // Poll for battery state since UPower may not be ready at startup
    Timer {
        interval: 5000
        running: true
        repeat: true
        onTriggered: refresh()
        Component.onCompleted: refresh()
    }

    function refresh() {
        var dev = UPower.displayDevice
        if (dev && dev.ready && dev.isPresent) {
            root.present = true
            root.pct = dev.percentage
            root.charging = dev.state === UPowerDeviceState.Charging
                        || dev.state === UPowerDeviceState.FullyCharged
        } else {
            root.present = false
        }
    }

    Row {
        spacing: 3
        anchors.verticalCenter: parent.verticalCenter

        Text {
            id: batIcon
            font.pixelSize: 11
            font.family: "SauceCodePro Nerd Font Mono"
            font.bold: true

            function icon() {
                if (root.charging) return "\uf450"
                var icons = ["\uf083", "\uf07d", "\uf07f", "\uf081", "\uf5e2"]
                var idx = Math.min(Math.floor(root.pct / 20), 4)
                return icons[idx]
            }

            text: icon()
            color: root.pct <= 20 ? Colors.red : root.pct <= 40 ? Colors.yellow : Colors.green
        }

        Text {
            id: batPct
            visible: root.charging || root.pct > 0
            font.pixelSize: 11
            font.family: "SauceCodePro Nerd Font Mono"
            font.bold: true

            text: Math.round(root.pct) + "%"
            color: root.pct <= 20 ? Colors.red : root.pct <= 40 ? Colors.yellow : Colors.green
        }
    }
}
