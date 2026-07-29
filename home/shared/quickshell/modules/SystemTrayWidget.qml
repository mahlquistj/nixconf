import Quickshell.Services.SystemTray
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import "colors.js" as Colors

// System tray - replicates Waybar's tray module
Item {
    id: root
    implicitHeight: 22
    height: 22
    implicitWidth: childrenRect.width

    visible: trayLayout.count > 0

    Row {
        id: trayLayout
        spacing: 5
        anchors.verticalCenter: parent.verticalCenter

        Repeater {
            model: SystemTray.items

            delegate: Item {
                id: trayItem
                required property var modelData

                width: 20
                height: 20

                // Try to load the icon; fall back to text placeholder
                IconImage {
                    id: trayIcon
                    anchors.fill: parent
                    implicitSize: 18
                    source: {
                        var ico = modelData.icon || ""
                        return ico ? ico : ""
                    }
                    visible: status !== Image.Error
                }

                Text {
                    anchors.centerIn: parent
                    text: {
                        var title = modelData.title || modelData.id || "?"
                        return title.charAt(0).toUpperCase()
                    }
                    color: Colors.surface2
                    font.pixelSize: 10
                    font.family: "SauceCodePro Nerd Font Mono"
                    font.bold: true
                    visible: trayIcon.status === Image.Error || trayIcon.source === ""
                }

                MouseArea {
                    anchors.fill: parent
                    acceptedButtons: Qt.LeftButton | Qt.RightButton
                    cursorShape: Qt.PointingHandCursor
                    onClicked: (mouse) => {
                        if (mouse.button === Qt.LeftButton)
                            modelData.activate(0, 0)
                        else
                            modelData.contextMenu(0, 0)
                    }
                }
            }
        }
    }
}
