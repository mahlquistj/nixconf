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
    id: clock

    // center the bar in its parent component (the window)
    anchors.centerIn: parent

    Process {
        id: getDate
        command: ["date"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: clock.text = this.text;
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: getDate.running = true
    }
  }
}
