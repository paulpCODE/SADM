import QtQuick 2.0

Item {

    property alias leftButton: lButton
    property alias rightButton: rButton


    BUTTON {
        id: lButton
        bCanToggle: true
        callSignalOnlyIfButtonOff: true
        width: parent.width/2
        height: parent.height
        anchors.left: parent.left
        anchors.top:parent.top
        bText.text: "Left"
        Component.onCompleted: {
            sButtonChecked.connect(fSwitchOn)
            sButtonChecked.connect(rButton.fSwitchOff)
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
        bText.text: "Right"
        Component.onCompleted: {
            sButtonChecked.connect(fSwitchOn)
            sButtonChecked.connect(lButton.fSwitchOff)
        }
    }
}
