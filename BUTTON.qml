import QtQuick 2.0

Item {

    id: button

    //Width | Height -- Item

    //Emits when Button Checked (MouseArea) | s = signal
    signal sButtonChecked()

    // if true - Button Can Toggle / On / Off
    property bool bCanToggle: false

    property bool bHoverEnabled: true

    property bool callSignalOnlyIfButtonOff: false

    property bool bIsCheckBox: true

    readonly property bool isButtonOn: privatevariables.pbOn

    //COLOR b = button
    property color bColor: "white"
    property color bEnteredColor: "#E8E8E8"
    property color bPressedColor: "#DCDCDC"

    //BUTTON TEXT
    property alias bText: text

    //BORDER
    property color bBorderColor: "black"
    property int bBorderWidth: 0
    property int bBorderRadius: 0

    //TURN ON STATE
    property color bStateOnColor: "white"
    property color bStateOnTextColor: "black"
    property bool bStateOnBoldText: true



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
            id: text
            anchors.centerIn: parent
            text: {
                if(bIsCheckBox) {
                    return ""
                }
                return "Button"
            }
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

    property bool pButtonOn: false

    function fToggle() {
        if(isButtonOn) {
            fSwitchOff()
        } else {
            fSwitchOn()
        }
    }

    function fSwitchOn() {
        if(bCanToggle) {
            privatevariables.pbOn = true
        }
    }
    function fSwitchOff() {
        if(bCanToggle) {
            privatevariables.pbOn = false
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
                target: text
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
