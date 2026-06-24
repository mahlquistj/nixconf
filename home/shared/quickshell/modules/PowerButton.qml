import QtQuick
import "colors.js" as Colors

// A single power action button with tooltip
Item {
    id: btn
    implicitWidth: 24
    implicitHeight: 22
    height: 22

    property string iconText: "\uf011"
    property string iconColor: Colors.text
    property string tooltipText: ""
    signal clicked()

    Text {
        anchors.centerIn: parent
        text: btn.iconText
        color: btn.iconColor
        font.pixelSize: 14
        font.family: "SauceCodePro Nerd Font Mono"
        font.bold: true
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: btn.clicked()
    }

    // Simple tooltip
    Rectangle {
        id: tooltip
        visible: mouseArea.containsMouse && btn.tooltipText !== ""
        anchors {
            bottom: parent.top
            bottomMargin: 4
            horizontalCenter: parent.horizontalCenter
        }
        width: tooltipLabel.width + 10
        height: tooltipLabel.height + 4
        radius: 8
        color: Colors.base
        z: 100

        Text {
            id: tooltipLabel
            anchors.centerIn: parent
            text: btn.tooltipText
            color: Colors.text
            font.pixelSize: 10
            font.family: "SauceCodePro Nerd Font Mono"
            font.bold: true
        }
    }
}
