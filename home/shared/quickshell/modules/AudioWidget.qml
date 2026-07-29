import Quickshell
import Quickshell.Io
import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Layouts
import "colors.js" as Colors

// Audio/wireplumber volume control module
Item {
    id: root
    implicitHeight: 22
    height: 22
    implicitWidth: childrenRect.width

    property var sink: Pipewire.defaultAudioSink
    property bool ready: sink !== null && sink.ready && sink.audio !== null

    function getIcon() {
        if (!root.ready) return "\ueee9" // 
        if (sink.audio.muted) return "\ueee9" //  muted
        var vol = sink.audio.volume
        if (vol <= 0.3) return "\uf026" // 
        if (vol <= 0.6) return "\uf027" // 
        return "\uf028" // 
    }

    function getColor() {
        if (!root.ready) return Colors.red
        if (sink.audio.muted) return Colors.red
        return Colors.text
    }

    Text {
        id: audioIcon
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
        onClicked: Process.exec(["hyprctl", "dispatch", "exec", "pavucontrol"])
    }
}
