import QtQuick 2.0

Item {

    property alias switcherRef: switcher

    Rectangle {
        id:background
        anchors.fill: parent
        color: "#A7C7E7"

        SWITCHER {
            id: switcher
            width: 150
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            anchors.leftMargin: 5
            height: parent.height - 5

            leftButton.bText: "Workers"
            leftButton.bColor: "#A7C7E7"
            leftButton.bEnteredColor: "#84b3e3"
            leftButton.bPressedColor: "#2288f0"

            rightButton.bText: "Statistics"
            rightButton.bColor: "#A7C7E7"
            rightButton.bEnteredColor: "#84b3e3"
            rightButton.bPressedColor: "#2288f0"

        }
    }
}
