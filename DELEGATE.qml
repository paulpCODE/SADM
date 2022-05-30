import QtQuick 2.0

Item {

    property string dFirstName: "Fname"
    property string dLastName: "Lname"


    BUTTON {
        id: button
        bCanToggle: true
        callSignalOnlyIfButtonOff: true
        anchors.fill: parent

        bText.text: dFirstName + " " + dLastName

    }

    SEPARATOR {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        height: 1
    }
}
