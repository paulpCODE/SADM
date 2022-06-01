import QtQuick 2.0

// Simple separator (Rectangle).

Item {
    // Separator color
    property color sColor: "black"

    Rectangle {
        id: background
        anchors.fill: parent
        color: sColor
    }

}
