import QtQuick 2.15
import QtQuick.Window 2.15

//for button
import QtQuick.Controls 2.0

import Model 1.0

Window {
    id: mainwindow
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    ListView {
        id: listW
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        width: mainwindow.width / 2

        currentIndex: -1

        WorkersModel {
            id: workersmodel
            list: workersList
        }

        SWITCHER {
            id: testSwitcher
            anchors.right: parent.right
            width: 200
            height: 50
            leftButton.bBorderRadius: 50
            leftButton.bBorderWidth: 1
            rightButton.bBorderRadius: 50
            rightButton.bBorderWidth: 1

        }

        model: workersmodel

        delegate: Rectangle {
            width:listW.width
            height: 50
            border.color: "black"
            border.width: 5
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

        BUTTON {
            id: addbutton
            bCanToggle: false
            bHoverEnabled: false
            width: 100
            height: 40
            bText.text: "Add"
            anchors.left: parent.right
            anchors.top: parent.top


            Component.onCompleted: {
                sButtonChecked.connect(listW.onAddButtonClicked)
            }
        }

        function onAddButtonClicked() {
            workersList.addWorker()
        }

    }
}
