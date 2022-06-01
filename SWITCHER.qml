import QtQuick 2.0

// Switches between two buttons.

Item {

    // Left button reference (BUTTON)
    property alias leftButton: lButton
    // Right Button reference (BUTTON)
    property alias rightButton: rButton


    BUTTON {
        id: lButton
        bCanToggle: true
        callSignalOnlyIfButtonOff: true
        width: parent.width/2
        height: parent.height
        anchors.left: parent.left
        anchors.top:parent.top
        //bText: "Left"
        Component.onCompleted: {
            sButtonChecked.connect(fSwitchOn)
            sButtonChecked.connect(rButton.fSwitchOff)
            fSwitchOn()
        }
    }

    BUTTON {
        id: rButton
        bCanToggle: true
        callSignalOnlyIfButtonOff: true
        width: parent.width/2
        height: parent.height
        anchors.left: leftButton.right
        anchors.top: leftButton.top
        //bText: "Right"
        Component.onCompleted: {
            sButtonChecked.connect(fSwitchOn)
            sButtonChecked.connect(lButton.fSwitchOff)
        }
    }
}
