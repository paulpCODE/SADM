import QtQuick 2.0

Item {

    // fire date input ref
    property alias mFireInput: firedate_input
    // Fire reason. If true - Necessary. False - Excessive
    property bool mIsNecessary: true

    //fire cancel button ref
    property alias fireCancelButtonRef: fireCancelButton
    // fire accept button ref
    property alias fireAcceptButtonRef: fireAcceptButton

    function update() {
        firedate_input.setDate(new Date())
        isNecessaryButton.fSwitchOn()
        isExcessiveButton.fSwitchOff()
        mIsNecessary = true
    }

    Rectangle {
        id:background
        anchors.fill: parent
        radius: 20
        border.width: 1

        MouseArea { anchors.fill: parent }

        Item {
            id: fireDateItem
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.topMargin: 10
            height: firedate_input.height + firedate_text.height + firedate_text.anchors.bottomMargin

            DATEINPUT {
                id: firedate_input
               anchors.bottom: parent.bottom
               anchors.horizontalCenter: parent.horizontalCenter
               width: 100
               height: 20

               Component.onCompleted: {
                   setDate(new Date())
               }

               Text {
                   id:firedate_text
                   text: "Fire Date:"
                   font.pixelSize: 14
                   anchors.bottom: parent.top
                   anchors.horizontalCenter: parent.horizontalCenter
                   anchors.bottomMargin: 1
               }
            }
        }

        Item {
            id: fireReasonTextItem
            anchors.top: fireDateItem.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.topMargin: 10
            height: firereason_text.height

            Text {
                id: firereason_text
                text: "Fire Reason:"
                font.pixelSize: 14
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
            }
        }

        Item {
            id: firereasonItem
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: fireReasonTextItem.bottom
            anchors.topMargin: 1
            height: isNecessaryButton.height

            Item {
                anchors.centerIn: parent

                BUTTON {
                    id: isNecessaryButton
                    width: 16
                    height: 16
                    bCanToggle: true
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.left
                    anchors.rightMargin: 2 + isNecessaryButton_text.width + isNecessaryButton_text.anchors.leftMargin
                    bHoverEnabled: false
                    bText: ""
                    callSignalOnlyIfButtonOff: true
                    bBorderWidth: 1
                    bStateOnColor: "#A7C7E7"
                    bBorderColor: "#042647"

                    Component.onCompleted: {
                        sButtonChecked.connect(fSwitchOn)
                        sButtonChecked.connect(isExcessiveButton.fSwitchOff)
                        sButtonChecked.connect(function() { mIsNecessary = true })
                    }

                    Text {
                        id: isNecessaryButton_text
                        font.pixelSize: 14
                        text: "Necessary"
                        anchors.left: parent.right
                        anchors.leftMargin: 1
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }

                BUTTON {
                    id: isExcessiveButton
                    width: 16
                    height: 16
                    bCanToggle: true
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.right
                    anchors.leftMargin: 2
                    bHoverEnabled: false
                    bText: ""
                    callSignalOnlyIfButtonOff: true
                    bBorderWidth: 1
                    bStateOnColor: "#A7C7E7"
                    bBorderColor: "#042647"

                    Component.onCompleted: {
                        sButtonChecked.connect(fSwitchOn)
                        sButtonChecked.connect(isNecessaryButton.fSwitchOff)
                        sButtonChecked.connect(function() { mIsNecessary = false })
                    }

                    Text {
                        id: isExcessiveButton_text
                        font.pixelSize: 14
                        text: "Excessive"
                        anchors.left: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.leftMargin: 1
                    }
                }
            }
        }

        BUTTON {
            id: fireCancelButton
            bCanToggle: false
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            anchors.margins: 10
            width: 50
            height: 25
            bText: "Cancel"
            bBorderWidth: 1
            bBorderRadius: 10
        }

        BUTTON {
            id: fireAcceptButton
            bCanToggle: false
            anchors.right: fireCancelButton.left
            anchors.verticalCenter: fireCancelButton.verticalCenter
            anchors.rightMargin: 10
            width: 50
            height: 25
            bText: "Fire"
            bBorderWidth: 1
            bBorderRadius: 10
            bColor: "#e03c36"
            bEnteredColor: "#de332c"
            bPressedColor: "#db1c14"
            bBorderColor: "#470404"
        }
    }
}
