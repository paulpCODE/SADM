import QtQuick 2.0

Item {

    property bool dPickerOnTop: true

    property date dModelDate: new Date()

    readonly property string dDate: button.bText.text

    BUTTON {
        id: button
        anchors.fill: parent
        bCanToggle: true
        bText.text: Qt.formatDate(dModelDate, 'd.MM.yyyy')
        bBorderWidth: 1

        Component.onCompleted: {
            sButtonChecked.connect(fToggle)
        }

        Rectangle {
            id: background
            width: 150
            height: 150
            radius: 20
            visible: button.isButtonOn

            anchors.bottom: {
                if(dPickerOnTop) {
                    return button.top
                }
            }
            anchors.top: {
                if(!dPickerOnTop) {
                    return button.bottom
                }
            }
            anchors.horizontalCenter: button.horizontalCenter

            DATEPICKER {
                id: datepicker
                anchors.fill: parent

                Component.onCompleted: {
                    set(dModelDate)
                    clicked.connect(dateChosen)
                }

                function dateChosen(chosenDate) {
                    button.bText.text = Qt.formatDate(chosenDate, 'd.MM.yyyy')
                    button.fSwitchOff()
                }
            }
        }
    }
}
