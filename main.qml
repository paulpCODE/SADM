import QtQuick 2.15
import QtQuick.Window 2.15
import Model 1.0

import "modelfunctions.js" as ModelFuncs
import "buttonsfunctions.js" as Buttons

Window {
    id: mainwindow
    width: 800
    height: 600
    visible: true
    title: qsTr("Hello World")

    WorkersModel {
        id: model
        list: activeWorkersList

        Component.onCompleted: {
            wlistwindow.listRef.model = model
        }
    }

    property alias wlist: wlistwindow
    property alias wchangeandshow: wchangeandshowwindow

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

        visible: wlistwindow.listRef.currentIndex === -1 ? false : true

        anchors.left: separatorItem.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.right: parent.right
    }
}
