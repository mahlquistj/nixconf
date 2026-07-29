import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts

import "modules"

PanelWindow {
    id: window

    // Position at the top spanning the full width
    anchors {
        top: true
        left: true
        right: true
    }

    implicitHeight: 26
    color: "transparent"

    // Margins: top: 5, left: 10, right: 10 (left/right margins on RowLayout)
    margins {
        top: 5
        bottom: 0
    }
    exclusiveZone: 26

    // Main bar row
    RowLayout {
        id: barLayout
        anchors {
            fill: parent
            leftMargin: 10
            rightMargin: 10
        }
        spacing: 5

        // ========== LEFT SECTION ==========
        Row {
            id: leftSection
            Layout.alignment: Qt.AlignVCenter
            spacing: 5

            // Power group
            ModuleContainer {
                PowerGroup {}
            }

            // System tray
            ModuleContainer {
                SystemTrayWidget {}
            }

            // Cava visualizer
            ModuleContainer {
                CavaWidget {}
            }
        }

        // ========== CENTER SECTION ==========
        Item {
            Layout.fillWidth: true
            implicitHeight: 26

            ModuleContainer {
                anchors.centerIn: parent
                NiriWorkspaces {}
            }
        }

        // ========== RIGHT SECTION ==========
        Row {
            id: rightSection
            Layout.alignment: Qt.AlignVCenter
            spacing: 5

            // Disk
            ModuleContainer {
                DiskWidget {}
            }

            // Usage (memory + cpu)
            ModuleContainer {
                UsageWidget {}
            }

            // Meta group (audio, backlight, network, notifications)
            ModuleContainer {
                Row {
                    spacing: 8
                    anchors.verticalCenter: parent.verticalCenter

                    AudioWidget {}
                    BacklightWidget {}
                    NetworkWidget {}
                    NotificationWidget {}
                }
            }

            // Clock
            ModuleContainer {
                ClockWidget {}
            }

            // Battery
            ModuleContainer {
                BatteryWidget {}
            }
        }
    }
}
