pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root
    property string day
    property string date
    property string time

    Process {
        id: getDate
        command: ["date", "+%Y-%m-%d"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: root.date = this.text.replace(/\n/g, "").replace(/\r/g, "")
        }
    }

    Process {
        id: getTime
        command: ["date", "+%H:%M"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: root.time = this.text.replace(/\n/g, "").replace(/\r/g, "")
        }
    }

    Process {
        id: getDay
        command: ["date", "+%A"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: root.day = this.text.replace(/\n/g, "").replace(/\r/g, "")
        }
    }

    // Run each minute
    Timer {
        interval: 60000
        running: true
        repeat: true
        onTriggered: {
            getDate.running = true
            getTime.running = true
            getDay.running = true
        }
    }
}
