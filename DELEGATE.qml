import QtQuick 2.0

// Delegate for Listview

Item {
    // button reference
    property alias dButton: button
    // variable for detecting if chosen delegate in list is current. Sets from delegate instance manually.
    property bool isCurrent
    // Model First Name
    property string mFirstName
    // Model Last Name
    property string mLastName

    onIsCurrentChanged: {
        if(isCurrent) {
            button.fSwitchOn()
            return
        }
        button.fSwitchOff()
    }

    BUTTON {
        id: button
        bCanToggle: true
        callSignalOnlyIfButtonOff: true
        anchors.fill: parent

        bText: mLastName + " " + mFirstName
    }

    SEPARATOR {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        height: 1
    }
}
