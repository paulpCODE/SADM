import QtQuick 2.15
import QtQuick.Window 2.15

import "modelfunctions.js" as MF
import "buttonsfunctions.js" as BF

Window {
    id: mainwindow
    width: 800
    height: 600
    visible: true
    title: qsTr("Hello World")

    WLISTWINDOW {
        id: wlistwindow

        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        width: 300
    }

    Item {
        id: separatorItem
        anchors.left: wlistwindow.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        width: 1

        SEPARATOR {
            anchors.fill: parent
        }
    }

    WCHANGEANDSHOWWINDOW {
        id: wchangeandshowwindow

        anchors.left: separatorItem.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.right: parent.right
    }

//    property alias model: list.model

//    Item {
//        id: switcherItem
//        anchors.left: parent.left
//        anchors.top: parent.top
//        width: 300
//        height: listsSwitcher.height

//        SWITCHER {
//            id: listsSwitcher
//            anchors.top: parent.top
//            anchors.left: parent.left
//            width: parent.width
//            height: 30

//            leftButton.bText.text: "ACTIVE"
//            rightButton.bText.text: "FIRED"

//            Component.onCompleted: {
//                leftButton.sButtonChecked.connect(() => model.list = activeWorkersList)
//                rightButton.sButtonChecked.connect(() => model.list = firedWorkersList)
//            }
//        }
//    }

//    Item {
//        id:listItem
//        anchors.top: switcherItem.bottom
//        anchors.left: parent.left
//        width: switcherItem.width
//        anchors.bottom: parent.bottom
//        LIST {
//            id: list
//            anchors.fill: parent

//            BUTTON {
//                id: addButton
//                anchors.bottom: parent.bottom
//                anchors.horizontalCenter: parent.horizontalCenter
//                anchors.bottomMargin: 15
//                width: parent.width/2
//                height: 25
//                bText.text: "Add"
//                bCanToggle: true
//                bBorderWidth: 1
//                bBorderRadius: 10

//                visible: listsSwitcher.leftButton.isButtonOn ? true : false

//                Component.onCompleted: {
//                    sButtonChecked.connect(function() {
//                        fToggle()
//                        F.addButtonImplementation()
//                    })
//                }
//            }
//        }
//    }



//    Item {
//        id: showAndChangeWindowsItem
//        anchors.left: separatorItem.right
//        anchors.right: parent.right
//        anchors.top:parent.top
//        anchors.bottom: parent.bottom

//        WSHOWWINDOW {
//            id: showWindow
//            anchors.fill: parent
//        }

//        WCHANGEWINDOW {
//            id: changeWindow
//            anchors.fill: parent

//            visible: showWindow.visible ? false : true
//        }

//        function showMode() {
//            showWindow.visible = true
//        }

//        function editMode() {
//            showWindow.visible = false
//        }
//    }

//    ListView {
//        id: listW
//        anchors.left: parent.left
//        anchors.top: parent.top
//        anchors.bottom: parent.bottom
//        width: mainwindow.width / 3

//        currentIndex: -1

////        WorkersModel {
////            id: workersmodel
////            list: workersList

////            Component.onCompleted: {
////                workersList.addWorker()
////                workersList.addWorker()
////                workersList.addWorker()
////            }
////        }

////        SWITCHER {
////            id: testSwitcher
////            anchors.right: parent.right
////            width: 200
////            height: 50
////            leftButton.bBorderRadius: 50
////            leftButton.bBorderWidth: 1
////            rightButton.bBorderRadius: 50
////            rightButton.bBorderWidth: 1

////        }

//        //model: workersmodel

//        delegate: DELEGATE {
//            width:listW.width
//            height: 50
//        }

////        Button {
////            id: addbutton
////            text: "Add"
////            anchors.left: parent.right
////            anchors.top: parent.top
////            anchors.margins: 20
////            onClicked: {
////                workersList.addWorker()
////            }
////        }

////        BUTTON {
////            id: addbutton
////            bCanToggle: true
////            bHoverEnabled: false
////            bIsCheckBox: true
////            bStateOnColor: "blue"
////            bBorderWidth: 1
////            bBorderColor: "blue"
////            width: 40
////            height: 40
////            anchors.left: parent.right
////            anchors.top: parent.top

////            Component.onCompleted: {
////                sButtonChecked.connect(listW.onAddButtonClicked)
////                sButtonChecked.connect(fToggle)
////            }
////        }

//    }


}
