import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import "colors.js" as Colors

// Combined memory and CPU usage group
Item {
    id: root
    implicitHeight: 22
    height: 22
    implicitWidth: childrenRect.width

    function stateClass(pct, crit, warn) {
        if (pct >= crit) return Colors.red
        if (pct >= warn) return Colors.yellow
        return Colors.green
    }

    function barIcon(pct) {
        var idx = Math.min(Math.floor(pct / 11.1), 8)
        var icons = ["\uf10c", "\uf09e", "\uf09f", "\uf0a0", "\uf0a1", "\uf0a2", "\uf0a3", "\uf0a4", "\uf0a5"]
        return icons[idx]
    }

    Row {
        spacing: 8
        anchors.verticalCenter: parent.verticalCenter

        // Memory
        Row {
            spacing: 3
            anchors.verticalCenter: parent.verticalCenter

            Text {
                id: memIcon
                text: "\ue7c5" // 
                color: Colors.text
                font.pixelSize: 11
                font.family: "SauceCodePro Nerd Font Mono"
                font.bold: true
            }

            Text {
                id: memPct
                property int pct: 0
                font.pixelSize: 11
                font.family: "SauceCodePro Nerd Font Mono"
                font.bold: true

                function refresh() {
                    memProc.running = true
                }

                Process {
                    id: memProc
                    command: ["sh", "-c", "free | grep Mem | awk '{printf \"%.0f\", $3/$2*100}'"]
                    running: true

                    stdout: StdioCollector {
                        onStreamFinished: {
                            var val = parseInt(this.text)
                            if (!isNaN(val)) memPct.pct = val
                        }
                    }
                }

                Timer {
                    interval: 10000
                    running: true
                    repeat: true
                    onTriggered: memPct.refresh()
                    Component.onCompleted: memPct.refresh()
                }

                text: root.barIcon(pct)
                color: root.stateClass(pct, 80, 50)
            }
        }

        // Separator
        Text {
            text: "|"
            color: Colors.surface2
            font.pixelSize: 10
            font.family: "SauceCodePro Nerd Font Mono"
            font.bold: true
            anchors.verticalCenter: parent.verticalCenter
        }

        // CPU
        Row {
            spacing: 3
            anchors.verticalCenter: parent.verticalCenter

            Text {
                id: cpuIcon
                text: "\uf2db" // 
                color: Colors.text
                font.pixelSize: 11
                font.family: "SauceCodePro Nerd Font Mono"
                font.bold: true
            }

            Text {
                id: cpuPct
                property int pct: 0
                font.pixelSize: 11
                font.family: "SauceCodePro Nerd Font Mono"
                font.bold: true

                function refresh() {
                    cpuProc.running = true
                }

                Process {
                    id: cpuProc
                    command: ["sh", "-c", "top -bn1 | grep 'Cpu(s)' | sed 's/.*, *\\([0-9]*\\)%* id.*/\\1/' | awk '{printf \"%.0f\", 100-$1}'"]
                    running: true

                    stdout: StdioCollector {
                        onStreamFinished: {
                            var val = parseInt(this.text)
                            if (!isNaN(val)) cpuPct.pct = val
                        }
                    }
                }

                Timer {
                    interval: 10000
                    running: true
                    repeat: true
                    onTriggered: cpuPct.refresh()
                    Component.onCompleted: cpuPct.refresh()
                }

                text: root.barIcon(pct)
                color: root.stateClass(pct, 90, 70)
            }
        }
    }
}
