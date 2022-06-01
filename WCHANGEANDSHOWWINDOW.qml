import QtQuick 2.0

// Worker Change and Show Window

Item {
    // Reference to WSHOWWINDOW
    property alias wshow: wshowwindow
    // Reference to WCHANGEWINDOW
    property alias wchange: wchangewindow

    // Shows WSHOWWINDOW. Hides WCHANGEWINDOW
    function wshowMode() {
        wshowwindow.visible = true
    }

    // Shows WCHANGEWINDOW. Hides WSHOWWINDOW.
    function wchangeMode() {
        wshowwindow.visible = false
    }

    function isChangeMode() {
        return wchangewindow.visible
    }

    WSHOWWINDOW {
        id: wshowwindow
        anchors.fill: parent
    }


    WCHANGEWINDOW {
        id: wchangewindow
        anchors.fill: parent

        visible: wshowwindow.visible ? false : true
    }

}
