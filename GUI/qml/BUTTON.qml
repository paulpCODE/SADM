import QtQuick 2.0

Item {
    id: button

    //Width | Height -- Item

    //Emits when Button Checked (MouseArea) | s = signal
    signal sButtonChecked()

    // if true - Button Can Toggle / On / Off
    property bool bCanToggle: false
    // For Mouse area. If false -> cant enter to state "Enabled"
    property bool bHoverEnabled: true
    // If true -> sButtonChecked emits only if button is off. Works only if button can toggle
    property bool callSignalOnlyIfButtonOff
    // property for check if button is on.
    readonly property alias isButtonOn: privatevariables.pbOn

    //Color in default state
    property color bColor: "white"
    // Color in entered state
    property color bEnteredColor: "#E8E8E8"
    // Color in pressed state
    property color bPressedColor: "#DCDCDC"

    // Text inside the button
    property alias bText: buttonText.text
    // Reference to Text item.
    property alias bTextItemRef: buttonText

    // Border color
    property color bBorderColor: "black"
    // Border width
    property int bBorderWidth: 0
    // Border radius (Background Rectangle radius property)
    property int bBorderRadius: 0

    // "On" state settings
    // Background color when state is "On"
    property color bStateOnColor: "white"
    // Text color when state is "On"
    property color bStateOnTextColor: "black"
    // if true -> text becomes bold when state is "On"
    property bool bStateOnBoldText: true

    // Use for button toggle. Works only if bCanToggle = true
    function fToggle() {
        if(isButtonOn) {
            fSwitchOff()
        } else {
            fSwitchOn()
        }
    }

    // Use for button switch on. Works only if bCanToggle = true
    function fSwitchOn() {
        if(bCanToggle) {
            privatevariables.pbOn = true
        }
    }

    // Use for button switch off. Works only if bCanToggle = true
    function fSwitchOff() {
        if(bCanToggle) {
            privatevariables.pbOn = false
        }
    }

    Rectangle {
        id: background
        anchors.fill: parent
        color: bColor

        radius: bBorderRadius
        border.width: bBorderWidth
        border.color: bBorderColor

        QtObject {
            id: privatevariables
            //Variable for button state
            //Dont change manually!
            property bool pbOn: false
        }


        Text {
            id: buttonText
            anchors.centerIn: parent
        }

        MouseArea {
            id: mousearea
            anchors.fill: parent
            hoverEnabled: bHoverEnabled
            cursorShape: Qt.PointingHandCursor

            onClicked: {
                if(callSignalOnlyIfButtonOff && isButtonOn) {
                    return
                }
                sButtonChecked()
            }
        }
    }



    states: [
        State {
            name: "Entered"
            when: mousearea.containsMouse && !mousearea.pressed && !isButtonOn
            PropertyChanges {
                target: background
                color: bEnteredColor
            }
        },
        State {
            name: "Pressed"
            when: mousearea.pressed && !isButtonOn
            PropertyChanges {
                target: background
                color: bPressedColor
            }
        },
        State {
            name: "On"
            when: isButtonOn
            PropertyChanges {
                target: background
                color: bStateOnColor
            }
            PropertyChanges {
                target: buttonText
                font.bold: bStateOnBoldText
                color: bStateOnTextColor
            }
        }
    ]

    transitions: [
        Transition {
            from: ""
            to: "Entered"
            PropertyAnimation {
                properties: "color"
                duration: 120
                easing.type: Easing.InQuad
            }
        },
        Transition {
            from: "Entered"
            to: ""
            PropertyAnimation {
                properties: "color"
                duration: 120
                easing.type: Easing.OutQuad
            }
        },
        Transition {
            from: "Entered"
            to: "Pressed"
            PropertyAnimation {
                properties: "color"
                duration: 70
                easing.type: Easing.InQuad
            }
        },
        Transition {
            from: "Pressed"
            to: "Entered"
            PropertyAnimation {
                properties: "color"
                duration: 70
                easing.type: Easing.OutQuad
            }
        },
        Transition {
            from: "Pressed"
            to: ""
            PropertyAnimation {
                properties: "color"
                duration: 120
                easing.type: Easing.OutQuad
            }
        }
    ]

}
