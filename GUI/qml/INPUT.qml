import QtQuick 2.0
import QtQuick.Controls 2.0

// Simple input field with background

TextField {
    placeholderText: "Placeholder"
    font.pixelSize: 16
    selectByMouse: true

    background: Rectangle {
        color: "white"
        border.width: 1
        border.color: "black"
    }

}
