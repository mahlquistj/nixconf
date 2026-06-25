import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import "colors.js" as Colors

// Power group: shutdown, logout, lock, reboot
Item {
    id: root
    implicitHeight: 22
    height: 22
    implicitWidth: childrenRect.width

    // Reusable process for power actions
    Process {
        id: cmdProcess
        command: []
    }

    Row {
        id: powerRow
        spacing: 0
        anchors.verticalCenter: parent.verticalCenter

        // Shut down
        PowerButton {
            iconText: ""
            iconColor: Colors.red
            tooltipText: "Shut down"
            onClicked: {
                cmdProcess.command = ["shutdown", "now"];
                cmdProcess.startDetached();
            }
        }

        // Logout
        PowerButton {
            iconText: "󰗼"
            iconColor: Colors.text
            tooltipText: "Logout"
            onClicked: {
                cmdProcess.command = ["niri", "msg", "action", "quit"];
                cmdProcess.startDetached();
            }
        }

        // Lock
        PowerButton {
            iconText: "󰍁"
            iconColor: Colors.text
            tooltipText: "Lock"
            onClicked: {
                cmdProcess.command = ["swaylock"];
                cmdProcess.startDetached();
            }
        }

        // Reboot
        PowerButton {
            iconText: "󰜉"
            iconColor: Colors.text
            tooltipText: "Reboot"
            onClicked: {
                cmdProcess.command = ["reboot"];
                cmdProcess.startDetached();
            }
        }
    }
}
