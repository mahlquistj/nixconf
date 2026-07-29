import Quickshell
import Quickshell.Io
import Quickshell.Services.Notifications
import QtQuick
import QtQuick.Layouts
import "colors.js" as Colors

// Notification indicator - shows if there are pending notifications
Item {
    id: root
    implicitHeight: 22
    height: 22
    implicitWidth: childrenRect.width

    property int count: NotificationServer.trackedNotifications ? NotificationServer.trackedNotifications.length : 0
    property bool dnd: false

    // Reusable process for click actions
    Process {
        id: notifProcess
        command: []
    }

    function getIcon() {
        if (dnd) {
            return count > 0 ? "\uf039" : "\uf028" //  / 
        }
        return count > 0 ? "\ueb9a" : "\ueaa2" //  / 
    }

    function getColor() {
        if (dnd) return Colors.red
        if (count > 0) return Colors.blue
        return Colors.text
    }

    Text {
        id: notifIcon
        anchors.verticalCenter: parent.verticalCenter
        text: root.getIcon()
        color: root.getColor()
        font.pixelSize: 14
        font.family: "SauceCodePro Nerd Font Mono"
        font.bold: true
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: {
            notifProcess.command = ["swaync-client", "-t", "-sw"]
            notifProcess.startDetached()
        }
        onPressAndHold: {
            notifProcess.command = ["swaync-client", "-d", "-sw"]
            notifProcess.startDetached()
        }
        acceptedButtons: Qt.LeftButton | Qt.RightButton
    }
}
