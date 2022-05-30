import QtQuick 2.15
import QtQuick.Window 2.15

//for button
import QtQuick.Controls

import Model 1.0



Window {
    id: mainwindow
    width: 800
    height: 600
    visible: true
    title: qsTr("Hello World")

    ListView {
        id: listW
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        width: mainwindow.width / 3

        currentIndex: -1

        WorkersModel {
            id: workersmodel
            list: workersList

            Component.onCompleted: {
                workersList.addWorker()
                workersList.addWorker()
                workersList.addWorker()
            }
        }

//        SWITCHER {
//            id: testSwitcher
//            anchors.right: parent.right
//            width: 200
//            height: 50
//            leftButton.bBorderRadius: 50
//            leftButton.bBorderWidth: 1
//            rightButton.bBorderRadius: 50
//            rightButton.bBorderWidth: 1

//        }

        model: workersmodel

        delegate: DELEGATE {
            width:listW.width
            height: 50
        }

//        Button {
//            id: addbutton
//            text: "Add"
//            anchors.left: parent.right
//            anchors.top: parent.top
//            anchors.margins: 20
//            onClicked: {
//                workersList.addWorker()
//            }
//        }

//        BUTTON {
//            id: addbutton
//            bCanToggle: true
//            bHoverEnabled: false
//            bIsCheckBox: true
//            bStateOnColor: "blue"
//            bBorderWidth: 1
//            bBorderColor: "blue"
//            width: 40
//            height: 40
//            anchors.left: parent.right
//            anchors.top: parent.top

//            Component.onCompleted: {
//                sButtonChecked.connect(listW.onAddButtonClicked)
//                sButtonChecked.connect(fToggle)
//            }
//        }







        function onAddButtonClicked() {
            workersList.addWorker()
        }

    }

    Item {
        id: genderItem
        x:100
        y:400
        width: 1
        height: isMaleButton.height

        Rectangle {
            anchors.fill: parent
            border.width: 1
        }

        BUTTON {
            id: isMaleButton
            width: 16
            height: 16
            bCanToggle: true
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.leftMargin: 50
            bHoverEnabled: false
            bIsCheckBox: true
            callSignalOnlyIfButtonOff: true
            bBorderWidth: 1
            bStateOnColor: "#A7C7E7"

            Component.onCompleted: {
                sButtonChecked.connect(fSwitchOn)
                sButtonChecked.connect(isFemaleButton.fSwitchOff)
            }

            TextField {
                id: isMaleButton_text
                font.pixelSize: 14

                text: "Male"
                padding: 0
                //width: qsTr(text).toInt() * 3

                anchors.left: parent.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: 1
                readOnly: true
                background: Rectangle { visible: false }
            }

            TextField {
                id: gender_text
                font.pixelSize: 16
                font.bold: true
                text: "Gender:"
                padding: 0
                anchors.right: parent.left
                anchors.verticalCenter: parent.verticalCenter
                anchors.rightMargin: 5
                readOnly: true
                background: Rectangle { visible: false }
            }
        }

        BUTTON {
            id: isFemaleButton
            width: 16
            height: 16
            bCanToggle: true
            anchors.top: parent.top
            anchors.left: isMaleButton.right
            anchors.leftMargin: 10 + isMaleButton_text.width + isMaleButton_text.anchors.leftMargin
            bHoverEnabled: false
            bIsCheckBox: true
            callSignalOnlyIfButtonOff: true
            bBorderWidth: 1
            bStateOnColor: "#A7C7E7"

            Component.onCompleted: {
                sButtonChecked.connect(fSwitchOn)
                sButtonChecked.connect(isMaleButton.fSwitchOff)
            }

            TextField {
                id: isFemaleButton_text
                font.pixelSize: 14
                text: "Female"
                padding: 0
                anchors.left: parent.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: 1
                readOnly: true
                background: Rectangle { visible: false }
            }

        }
    }

    WCHANGEWINDOW {
        id: changeWindow
        anchors.left: listW.right
        anchors.bottom: parent.bottom
        anchors.top: parent.top
        anchors.right: parent.right
    }

}
