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
    // center the bar in its parent component (the window)
    anchors.centerIn: parent
  }
}
