import QtQuick

// A container that gives each module the same semi-transparent dark background
Rectangle {
    id: container
    color: Qt.rgba(0, 0, 0, 0.6)
    radius: 12
    implicitHeight: 22

    default property alias content: inner.data

    // Width follows content with 12px horizontal padding
    implicitWidth: inner.childrenRect.width + 12

    // Inner content: fills container, provides horizontal padding
    Item {
        id: inner
        anchors.fill: parent
        anchors.leftMargin: 6
        anchors.rightMargin: 6
        clip: false
    }
}
