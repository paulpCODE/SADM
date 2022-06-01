import QtQuick 2.0

Item {
    // if true - picker shows on top of the button. false - bottom.
    property bool dPickerOnTop: true
    // contains current date in picker
    property date currentDate
    // sets to true if date was changed
    property bool isDateChanged: false

    function setDate(date) {
        currentDate = date

        datepicker.set(currentDate)
        button.bText.text = Qt.formatDate(currentDate, 'd/MM/yyyy')
        isDateChanged = false
    }


    BUTTON {
        id: button
        anchors.fill: parent
        bCanToggle: true
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
                    clicked.connect(dateChosen)
                }

                function dateChosen(chosenDate) {
                    if(currentDate !== chosenDate) {
                        currentDate = chosenDate
                        button.bText.text = Qt.formatDate(currentDate, 'd.MM.yyyy')

                        isDateChanged = true
                    }

                    button.fSwitchOff()
                }
            }
        }
    }
}
