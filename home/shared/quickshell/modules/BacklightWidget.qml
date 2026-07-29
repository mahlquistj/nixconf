import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import "colors.js" as Colors

// Backlight/brightness control module
Item {
    id: root
    implicitHeight: 22
    height: 22
    implicitWidth: childrenRect.width

    property int brightness: 100

    Timer {
        interval: 5000
        running: true
        repeat: true
        onTriggered: refresh()
        Component.onCompleted: refresh()
    }

    function refresh() {
        backlightProc.running = true
    }

    Process {
        id: backlightProc
        command: ["sh", "-c", "brightnessctl info | grep -oP '\\d+(?=%)'"]
        running: false

        stdout: StdioCollector {
            onStreamFinished: {
                var collectedText = this.text.replace(/\n/g, "").replace(/\r/g, "").trim()
                var val = parseInt(collectedText)
                if (!isNaN(val)) root.brightness = val
            }
        }
    }

    function getIcon() {
        if (brightness <= 33) return "\uf0de" // 󰃞
        if (brightness <= 66) return "\uf0df" // 󰃟
        return "\uf0e0" // 󰃠
    }

    Text {
        anchors.verticalCenter: parent.verticalCenter
        text: root.getIcon()
        color: Colors.text
        font.pixelSize: 14
        font.family: "SauceCodePro Nerd Font Mono"
        font.bold: true
    }
}
