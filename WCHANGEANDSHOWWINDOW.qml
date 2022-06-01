import QtQuick 2.0

import "modelfunctions.js" as MF
import "buttonsfunctions.js" as BF


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
