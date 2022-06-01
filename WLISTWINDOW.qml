import QtQuick 2.0
import "buttonsfunctions.js" as Buttons

// Workers List Window

Item {
    // LIST ref
    property alias list: wlist
    // LIST model ref
    property alias model: wlist.model
    // LIST add button ref
    property alias addButton: addButton

    Item {
        id: switcherItem
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.right: parent.right
        height: listsSwitcher.height

        SWITCHER {
            id: listsSwitcher
            anchors.top: parent.top
            anchors.left: parent.left
            width: parent.width
            height: 30

            leftButton.bText: "ACTIVE"
            rightButton.bText: "FIRED"

            Component.onCompleted: {
                leftButton.sButtonChecked.connect(Buttons.activeButtonImplementation)
                rightButton.sButtonChecked.connect(Buttons.firedButtonImplementation)
            }
        }
    }

    Item {
        id:listItem
        anchors.top: switcherItem.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        LIST {
            id: wlist
            anchors.fill: parent

            Component.onCompleted: {
                sPreIndexChanged.connect(Buttons.sPreIndexChangedImplementation)
                sPostIndexChanged.connect(Buttons.sPostIndexChangedImplementation)
            }

            BUTTON {
                id: addButton
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottomMargin: 15
                width: parent.width/2
                height: 25
                bText: "Add"
                bCanToggle: true
                bBorderWidth: 1
                bBorderRadius: 10

                visible: listsSwitcher.leftButton.isButtonOn ? true : false

                Component.onCompleted: {
                    sButtonChecked.connect(function() {
                        fToggle()
                        Buttons.addButtonImplementation()
                    })
                }
            }
        }
    }
}