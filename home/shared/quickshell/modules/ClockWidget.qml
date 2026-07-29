import QtQuick
import QtQuick.Layouts
import "colors.js" as Colors

// Clock module - shows time and date
Item {
    id: root
    implicitHeight: 22
    height: 22
    implicitWidth: childrenRect.width

    property string timeStr: ""
    property string dateStr: ""
    property string dayStr: ""

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: updateTime()
        Component.onCompleted: updateTime()
    }

    function updateTime() {
        var now = new Date()
        var hh = now.getHours().toString().padStart(2, "0")
        var mm = now.getMinutes().toString().padStart(2, "0")
        root.timeStr = hh + ":" + mm

        var dd = now.getDate().toString().padStart(2, "0")
        var mo = (now.getMonth() + 1).toString().padStart(2, "0")
        var yyyy = now.getFullYear()
        root.dateStr = dd + "/" + mo + "/" + yyyy

        var days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
        root.dayStr = days[now.getDay()]
    }

    Text {
        id: clockText
        anchors.verticalCenter: parent.verticalCenter
        text: root.timeStr + " " + root.dateStr
        color: Colors.text
        font.pixelSize: 11
        font.family: "SauceCodePro Nerd Font Mono"
        font.bold: true
    }
}
