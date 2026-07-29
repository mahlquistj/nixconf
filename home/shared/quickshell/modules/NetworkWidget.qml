import Quickshell
import Quickshell.Io
import Quickshell.Networking
import QtQuick
import QtQuick.Layouts
import "colors.js" as Colors

// Network module - shows wifi or ethernet status via periodic polling
Item {
    id: root
    implicitHeight: 22
    height: 22
    implicitWidth: childrenRect.width

    property bool isConnected: false
    property bool isWifi: false
    property int signalStrength: 0
    property string essid: ""

    Timer {
        interval: 10000
        running: true
        repeat: true
        onTriggered: refresh()
        Component.onCompleted: refresh()
    }

    function refresh() {
        netProc.running = true
    }

    Process {
        id: netProc
        command: ["sh", "-c", "nmcli -t -f TYPE,STATE device status 2>/dev/null | grep -E '^(wifi|ethernet):connected$' | head -1 | cut -d: -f1"]
        running: false

        stdout: StdioCollector {
            onStreamFinished: {
                var collectedText = this.text.replace(/\n/g, "").replace(/\r/g, "").trim()
                var line = collectedText
                if (line === "wifi") {
                    root.isConnected = true
                    root.isWifi = true
                    root.fetchSignal()
                } else if (line === "ethernet") {
                    root.isConnected = true
                    root.isWifi = false
                } else {
                    root.isConnected = false
                }
            }
        }
    }

    Process {
        id: signalProc
        command: ["sh", "-c", "nmcli -t -f IN-USE,SIGNAL,SSID device wifi list 2>/dev/null | grep '^\\*' | head -1 | cut -d: -f2,3"]
        running: false

        stdout: StdioCollector {
            onStreamFinished: {
                var collectedText = this.text.replace(/\n/g, "").replace(/\r/g, "").trim()
                var line = collectedText
                if (line !== "") {
                    var parts = line.split(":")
                    root.signalStrength = parseInt(parts[0]) || 0
                    root.essid = parts.slice(1).join(":") || ""
                }
            }
        }
    }

    function fetchSignal() {
        signalProc.running = true
    }

    function getIcon() {
        if (!isConnected) return "\ufad0" //  disconnected
        if (!isWifi) return "\uf0c1" // 󰈁 ethernet
        var sig = Math.min(signalStrength, 100)
        var icons = ["\uf0ee", "\uf0ef", "\uf0f0", "\uf0f1", "\uf0f2"] // 󰤯 󰤟 󰤢 󰤥 󰤨
        var idx = Math.min(Math.floor(sig / 25), 4)
        return icons[idx]
    }

    function getColor() {
        if (!isConnected) return Colors.red
        return Colors.text
    }

    Text {
        id: netIcon
        anchors.verticalCenter: parent.verticalCenter
        text: root.getIcon()
        color: root.getColor()
        font.pixelSize: 14
        font.family: "SauceCodePro Nerd Font Mono"
        font.bold: true
    }
}
