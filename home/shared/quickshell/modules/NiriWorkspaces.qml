import Quickshell
import Quickshell.Io
import QtQuick
import "colors.js" as Colors

// Niri workspace buttons via niri msg IPC
Item {
    id: root
    implicitHeight: 22
    height: 22
    implicitWidth: childrenRect.width

    // Reusable process for workspace switching
    Process {
        id: wsProcess
        command: []
    }

    // Workspace data: { id, name, isActive }
    property var workspaces: []

    Timer {
        interval: 500
        running: true
        repeat: true
        onTriggered: refresh()
        Component.onCompleted: refresh()
    }

    function refresh() {
        wsProc.running = true
    }

    Process {
        id: wsProc
        command: ["sh", "-c", "niri msg -j workspaces 2>/dev/null || echo '[]'"]
        running: false

        stdout: StdioCollector {
            onStreamFinished: {
                var raw = this.text.replace(/\n/g, "").replace(/\r/g, "").trim()
                if (raw === "") raw = "[]"
                try {
                    var parsed = JSON.parse(raw)
                    var result = []
                    for (var i = 0; i < parsed.length; i++) {
                        var ws = parsed[i]
                        // niri uses idx for workspace number, name may be null
                        var wsNum = ws.idx
                        result.push({
                            id: ws.id,
                            name: wsNum !== null && wsNum !== undefined ? wsNum.toString() : (i + 1).toString(),
                            isActive: ws.is_focused === true
                        })
                    }
                    root.workspaces = result
                } catch (e) {
                    root.workspaces = []
                }
            }
        }
    }

    Row {
        spacing: 5
        anchors.verticalCenter: parent.verticalCenter

        Repeater {
            model: root.workspaces.length

            delegate: Rectangle {
                id: wsButton
                required property int index
                height: 16
                readonly property var ws: root.workspaces[index]

                width: ws.isActive ? 48 : 14
                radius: 8
                color: ws.isActive ? Colors.peach : Colors.surface0

                Behavior on width {
                    NumberAnimation { duration: 200 }
                }
                Behavior on color {
                    ColorAnimation { duration: 200 }
                }

                Text {
                    anchors.centerIn: parent
                    text: ws.name
                    color: ws.isActive ? Colors.crust : Colors.text
                    font.pixelSize: 10
                    font.bold: true
                    font.family: "SauceCodePro Nerd Font Mono"
                }

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        wsProcess.command = ["niri", "msg", "action", "focus-workspace", ws.name]
                        wsProcess.startDetached()
                    }
                }
            }
        }
    }
}
