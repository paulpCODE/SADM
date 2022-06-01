import QtQuick 2.0
import QtQuick.Controls 2.0

import "buttonsfunctions.js" as Buttons

// Worker Change Window

Item {

    // Model First Name
    property alias mFirstName: fname_input.text
    // Model Last Name
    property alias mLastName: lname_input.text
    // Model Gender if == 'M' => true | else - false
    property bool isMale: true
    // Model Birth Date Input (DATEINPUT)
    property alias mBirthDateInput: birthdate_input
    // Model Employment Date Input (DATEINPUT)
    property alias mEmploymentDateInput: employmentdate_input
    // Model Salary
    property alias mSalary: salary_input.text
    //Model Additional Info
    property alias mAdditionalInfo: additionalinfo_area.text

    // If any data changed -> true
    property bool isChanged: false

    //CALL AFTER MODEL UPDATE
    function update() {
        if(isMale) {
            isMaleButton.fSwitchOn()
            isFemaleButton.fSwitchOff()
        } else {
            isFemaleButton.fSwitchOn()
            isMaleButton.fSwitchOff()
        }
        isChanged = false
    }

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

                onTextChanged: {
                    isChanged = true
                }
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

                onTextChanged: {
                    isChanged = true
                }
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
                bText: ""
                callSignalOnlyIfButtonOff: true
                bBorderWidth: 1
                bStateOnColor: "#A7C7E7"

                Component.onCompleted: {
                    sButtonChecked.connect(fSwitchOn)
                    sButtonChecked.connect(isFemaleButton.fSwitchOff)
                    sButtonChecked.connect(function() { isChanged = true; isMale = true })
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
                bText: ""
                callSignalOnlyIfButtonOff: true
                bBorderWidth: 1
                bStateOnColor: "#A7C7E7"

                Component.onCompleted: {
                    sButtonChecked.connect(fSwitchOn)
                    sButtonChecked.connect(isMaleButton.fSwitchOff)
                    sButtonChecked.connect(function() { isChanged = true; isMale = false })
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
                validator: IntValidator { bottom: 0 }

                onTextChanged: {
                    isChanged = true
                }

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

                onIsDateChangedChanged: {
                    if(isDateChanged) {
                        isChanged = true
                    }
                }

                Component.onCompleted: {
                    setDate(new Date())
                }

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

                onIsDateChangedChanged: {
                    if(isDateChanged) {
                        isChanged = true
                    }
                }

                Component.onCompleted: {
                    setDate(new Date())
                }

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

                        onTextChanged: {
                            isChanged = true
                        }
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
            bText: "Cancel"
            bBorderWidth: 1
            bBorderRadius: 5

            Component.onCompleted: {
                sButtonChecked.connect(Buttons.cancelButtonImplementation)
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
            bText: "Save"
            bBorderWidth: 1
            bBorderRadius: 5

            Component.onCompleted: {
                sButtonChecked.connect(Buttons.saveButtonImplementation)
            }
        }
    }

}
