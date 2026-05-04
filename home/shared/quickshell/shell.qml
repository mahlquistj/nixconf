import Quickshell
import Quickshell.Io
import QtQuick

PanelWindow {
    anchors {
        top: true
        left: true
        right: true
    }

    implicitHeight: 30

    Text {
        text: "Today is " + DateTime.day + " " + DateTime.date + " and the time is " + DateTime.time
        // fill the width of the parent and center text within
        width: parent.width
        horizontalAlignment: Text.AlignHCenter
        wrapMode: Text.NoWrap
    }
}
