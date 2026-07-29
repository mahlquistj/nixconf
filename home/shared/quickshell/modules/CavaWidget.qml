import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Layouts
import "colors.js" as Colors

// Cava-like audio visualizer using Pipewire peak monitor
Item {
    id: root
    implicitHeight: 22
    height: 22
    implicitWidth: 72
    visible: false // starts hidden, shown when sink is available

    property real peak: 0.0
    property var bars: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    property var sink: null

    // Monitor the default audio sink
    PwNodePeakMonitor {
        id: peakMonitor
        node: root.sink
        enabled: root.sink !== null

        onPeakChanged: {
            root.peak = peak
            var numBars = root.bars.length
            var scaledPeak = Math.min(peak * 2.5, 1.0)

            for (var i = 0; i < numBars; i++) {
                var target = (i / numBars) < scaledPeak ? 0.6 + Math.random() * 0.4 : 0.02
                root.bars[i] = root.bars[i] * 0.7 + target * 0.3
            }
        }
    }

    // React to Pipewire becoming ready and sink changes
    Connections {
        target: Pipewire
        function onReadyChanged() { updateSink() }
        function onDefaultAudioSinkChanged() { updateSink() }
    }

    function updateSink() {
        if (Pipewire.ready && Pipewire.defaultAudioSink !== null) {
            root.sink = Pipewire.defaultAudioSink
            peakMonitor.node = Pipewire.defaultAudioSink
            peakMonitor.enabled = true
            root.visible = true
        } else {
            root.sink = null
            peakMonitor.node = null
            peakMonitor.enabled = false
            root.visible = false
        }
    }

    Component.onCompleted: updateSink()

    Row {
        anchors.centerIn: parent
        spacing: 2

        Repeater {
            model: 12

            delegate: Rectangle {
                required property int index
                width: 4
                height: Math.max(2, root.bars[index] * 20)
                radius: 2
                color: Colors.green
                anchors.verticalCenter: parent.verticalCenter

                Behavior on height {
                    NumberAnimation { duration: 60 }
                }
            }
        }
    }
}
