import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import "colors.js" as Colors

// Disk usage module - uses `df` to get disk usage info
Item {
    id: root
    implicitHeight: 22
    height: 22
    implicitWidth: childrenRect.width

    property int usedPercent: 0

    function stateClass(pct) {
        if (pct >= 90) return Colors.red
        if (pct >= 70) return Colors.yellow
        return Colors.green
    }

    Timer {
        interval: 30000
        running: true
        repeat: true
        onTriggered: refresh()
        Component.onCompleted: refresh()
    }

    function refresh() {
        diskProcess.running = true
    }

    Process {
        id: diskProcess
        command: ["sh", "-c", "df -h / | tail -1 | awk '{print $5}'"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: {
                var val = parseInt(this.text)
                if (!isNaN(val)) root.usedPercent = val
            }
        }
    }

    Row {
        spacing: 3
        anchors.verticalCenter: parent.verticalCenter

        Text {
            text: "\uf0a0" // 
            color: Colors.text
            font.pixelSize: 11
            font.family: "SauceCodePro Nerd Font Mono"
            font.bold: true
        }

        Text {
            text: root.usedPercent + "%"
            color: root.stateClass(root.usedPercent)
            font.pixelSize: 11
            font.family: "SauceCodePro Nerd Font Mono"
            font.bold: true
        }
    }
}
