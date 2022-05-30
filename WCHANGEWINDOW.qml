import QtQuick 2.0
import QtQuick.Controls 2.0

Item {

    Rectangle {
        id: background
        anchors.fill: parent
        color: "white"

        Item {
            id: nameItem
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.topMargin: 15
            anchors.leftMargin: 10
            height: fname_input.height + lname_input.height + lname_input.anchors.topMargin

            INPUT {
                id: fname_input
                anchors.top: parent.top
                anchors.left: parent.left
                placeholderText: "First Name"
                width: 200
                maximumLength: 30
                font.pixelSize: 20
            }
            INPUT {
                id: lname_input
                anchors.top: fname_input.bottom
                anchors.left: parent.left
                anchors.topMargin: 6
                placeholderText: "Last Name"
                width: 200
                maximumLength: 30
                font.pixelSize: 20
            }
        }

        Item {
            id: genderItem
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.right: parent.right
            anchors.top: nameItem.bottom
            anchors.topMargin: 10
            height: isMaleButton.height

            BUTTON {
                id: isMaleButton
                width: 16
                height: 16
                bCanToggle: true
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.leftMargin: gender_text.width + gender_text.anchors.rightMargin
                bHoverEnabled: false
                bIsCheckBox: true
                callSignalOnlyIfButtonOff: true
                bBorderWidth: 1
                bStateOnColor: "#A7C7E7"

                Component.onCompleted: {
                    sButtonChecked.connect(fSwitchOn)
                    sButtonChecked.connect(isFemaleButton.fSwitchOff)
                    fSwitchOn()
                }

                Text {
                    id: isMaleButton_text
                    font.pixelSize: 14
                    text: "Male"
                    anchors.left: parent.right
                    anchors.leftMargin: 1
                    anchors.verticalCenter: parent.verticalCenter
                }

                Text {
                    id: gender_text
                    font.pixelSize: 14
                    font.bold: true
                    text: "Gender:"
                    anchors.right: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.rightMargin: 5
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

                Text {
                    id: isFemaleButton_text
                    font.pixelSize: 14
                    text: "Female"
                    anchors.left: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.leftMargin: 1
                }

            }
        }

        Item {
            id: salaryItem
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.right: parent.right
            anchors.top: genderItem.bottom
            anchors.topMargin: 10
            height: salary_input.height

            INPUT {
                id: salary_input
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.leftMargin: salary_text.width + salary_text.anchors.rightMargin
                placeholderText: "Salary"
                width: 100
                maximumLength: 10
                font.pixelSize: 14

                Text {
                    id: salary_text
                    font.pixelSize: 14
                    font.bold: true
                    text: "Salary:"
                    anchors.right: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.rightMargin: 5
                }
            }
        }

        Item {
            id: birthdateItem
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.right: parent.right
            anchors.top: salaryItem.bottom
            anchors.topMargin: 10
            height: birthdate_input.height

            DATEINPUT {
                id: birthdate_input
                width: 100
                height: 20
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.leftMargin: birthdate_text.width + birthdate_text.anchors.rightMargin

                Text {
                    id: birthdate_text
                    font.pixelSize: 14
                    font.bold: true
                    text: "Birth Date:"
                    anchors.right: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.rightMargin: 5
                }
            }
        }

        Item {
            id: employmentdateItem
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.right: parent.right
            anchors.top: birthdateItem.bottom
            anchors.topMargin: 10
            height: employmentdate_input.height

            DATEINPUT {
                id: employmentdate_input
                width: 100
                height: 20
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.leftMargin: employmentdate_text.width + employmentdate_text.anchors.rightMargin

                Text {
                    id: employmentdate_text
                    font.pixelSize: 14
                    font.bold: true
                    text: "Employment Date:"
                    anchors.right: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.rightMargin: 5
                }
            }
        }

        Item {
            id: additionalinfoItem
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.right: parent.right
            anchors.top: employmentdateItem.bottom
            anchors.topMargin: 30
            height: additionalinfo_background.height + additionalinfo_text.height + additionalinfo_text.anchors.bottomMargin

            Rectangle {
                id: additionalinfo_background
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.topMargin: additionalinfo_text.height + additionalinfo_text.anchors.bottomMargin
                anchors.rightMargin: parent.width / 4
                border.width: 1
                height: 250

                ScrollView {
                    anchors.fill: parent
                    anchors.margins: 1

                    TextArea {
                        id: additionalinfo_area
                        //anchors.fill: parent
                        font.pixelSize: 12
                        placeholderText: "Any additional info about worker"
                        wrapMode: TextArea.WordWrap
                        selectByMouse: true
                    }
                }

                Text {
                    id: additionalinfo_text
                    font.pixelSize: 14
                    font.bold: true
                    text: "Additional Info:"
                    anchors.left: parent.left
                    anchors.bottom: parent.top
                    anchors.bottomMargin: 1
                }
            }
        }

        BUTTON {
            id: cancelButton
            bCanToggle: false
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            anchors.margins: 10
            width: 50
            height: 22
            bText.text: "Cancel"
            bBorderWidth: 1
            bBorderRadius: 5

            Component.onCompleted: {

            }
        }

        BUTTON {
            id: saveButton
            bCanToggle: false
            anchors.right: cancelButton.left
            anchors.verticalCenter: cancelButton.verticalCenter
            anchors.rightMargin: 10
            width: 50
            height: 22
            bText.text: "Save"
            bBorderWidth: 1
            bBorderRadius: 5

            Component.onCompleted: {

            }
        }
    }

}
