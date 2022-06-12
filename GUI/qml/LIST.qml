import QtQuick 2.0

Item {
    // Model reference
    property alias model: listview.model
    // Current index of list. ReadOnly. For Change use changeIndex function
    readonly property alias currentIndex: listview.currentIndex
    // Emits before currentIndex changed
    signal sPreIndexChanged()
    // Emits after currentIndex changed
    signal sPostIndexChanged()
    //Uses for change currentIndex from other files
    function changeIndex(index) {
        if(index < -1) {
            return
        }
        //emit signal
        sPreIndexChanged()
        //change currentIndex
        listview.currentIndex = index
        //emit signal
        sPostIndexChanged()
    }

    ListView {
        id: listview
        anchors.fill: parent

        currentIndex: -1

        //model

        delegate: DELEGATE {
            width: listview.width
            height: 40

            property int indexOfThisDelegate: index

            isCurrent: listview.currentIndex == indexOfThisDelegate ? true : false

            mFirstName: model.firstname
            mLastName: model.lastname

            Component.onCompleted: {
                dButton.sButtonChecked.connect(function() { changeIndex(indexOfThisDelegate) });
            }

        }
    }
}
