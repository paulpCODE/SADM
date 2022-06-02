import QtQuick 2.0
import QtQuick.Controls 2.0

import "buttonsfunctions.js" as Buttons

// Worker Show Window

Item {
    //Worker Status. If true -> worker Active. false -> Fired. Need for fire info.
    property bool mIsActive: true

    // Model First Name
    property alias mFirstName : mData_lname_text.text
    // Model Last Name
    property alias mLastName : mData_fname_text.text
    // Model Gender (Only text. Set Male or Female)
    property alias mGender : mData_gender_text.text
    // Model Birth Date (Only text. Set QString)
    property alias mBirthDate : mData_birthdate_text.text
    // Model Employment Date (Only text. Set QString)
    property alias mEmploymentDate : mData_employmentdate_text.text
    //Model Fire Date (Only text. Set QString). Show only if mIsActive is true
    property alias mFireDate : mData_firedate_text.text
    //Model Fire Reason (Only text. Set QString). Show only if mIsActive is true
    property alias mFireReason : mData_firereason_text.text
    // Model Salary (Only text. Set QString)
    property alias mSalary : mData_salary_text.text
    // Model Additional Info
    property alias mAdditionalInfo : mData_additionalinfo_area.text


    // Change Button Ref
    property alias changeButtonRef: changeButton
    // Fire Button Ref
    property alias fireButtonRef: fireButton
    // fire menu ref
    property alias fireMenuRef: fireMenu

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
            height: mData_lname_text.height

            Text {
                id: mData_lname_text
                anchors.left: parent.left
                anchors.top: parent.top

                font.bold: true
                font.pixelSize: 20
                text: mLastName
            }

            Text {
                id: mData_fname_text
                anchors.left: mData_lname_text.right
                anchors.leftMargin: 3
                anchors.verticalCenter: mData_lname_text.verticalCenter

                font.bold: true
                font.pixelSize: 20
                text: mFirstName
            }
        }

        Item {
            id: genderItem
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.right: parent.right
            anchors.top: nameItem.bottom
            anchors.topMargin: 10
            height: gender_text.height

            Text {
                id: gender_text
                font.pixelSize: 14
                anchors.left: parent.left
                anchors.top: parent.top
                text: "Gender: "

                Text {
                    id: mData_gender_text
                    font.pixelSize: parent.font.pixelSize
                    anchors.left: parent.right
                    anchors.verticalCenter: parent.verticalCenter
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
            height: salary_text.height

            Text {
                id: salary_text
                font.pixelSize: 14
                anchors.left: parent.left
                anchors.top: parent.top
                text: "Salary: "

                Text {
                    id: mData_salary_text
                    font.pixelSize: parent.font.pixelSize
                    anchors.left: parent.right
                    anchors.verticalCenter: parent.verticalCenter
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
            height: birthdate_text.height

            Text {
                id: birthdate_text
                font.pixelSize: 14
                anchors.left: parent.left
                anchors.top: parent.top
                text: "Birth Date: "

                Text {
                    id: mData_birthdate_text
                    font.pixelSize: parent.font.pixelSize
                    anchors.left: parent.right
                    anchors.verticalCenter: parent.verticalCenter
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
            height: employmentdate_text.height

            Text {
                id: employmentdate_text
                font.pixelSize: 14
                anchors.left: parent.left
                anchors.top: parent.top
                text: "Employment Date: "

                Text {
                    id: mData_employmentdate_text
                    font.pixelSize: parent.font.pixelSize
                    anchors.left: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
        }

        Item {
            id: fireDateAndReasonItem
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.right: parent.right
            anchors.top: employmentdateItem.bottom
            anchors.topMargin: 10
            height: firedate_text.height

            visible: mIsActive ? false : true

            Text {
                id: firedate_text
                font.pixelSize: 14
                anchors.left: parent.left
                anchors.top: parent.top
                text: "Fire Date: "

                Text {
                    id: mData_firedate_text
                    font.pixelSize: parent.font.pixelSize
                    anchors.left: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                }

                Text {
                    id: firereason_text
                    font.pixelSize: parent.font.pixelSize
                    anchors.left: mData_firedate_text.right
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.leftMargin: 15
                    text: "Fire Reason: "

                    Text {
                        id: mData_firereason_text
                        font.pixelSize: parent.font.pixelSize
                        anchors.left: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
            }
        }

        Item {
            id: additionalinfoItem
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.right: parent.right
            anchors.top: {
                if(fireDateAndReasonItem.visible) {
                    return fireDateAndReasonItem.bottom
                } else {
                    return employmentdateItem.bottom
                }
            }
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
                        id: mData_additionalinfo_area
                        font.pixelSize: 12
                        wrapMode: TextArea.WordWrap
                        selectByMouse: true
                        readOnly: true
                    }
                }

                Text {
                    id: additionalinfo_text
                    font.pixelSize: 14
                    text: "Additional Info:"
                    anchors.left: parent.left
                    anchors.bottom: parent.top
                    anchors.bottomMargin: 1
                }
            }
        }

        BUTTON {
            id: fireButton
            bCanToggle: true
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            anchors.margins: 10
            width: 80
            height: 25
            bText: "Fire"
            bBorderWidth: 1
            bBorderRadius: 10
            bColor: "#A7C7E7"
            bEnteredColor: "#84b3e3"
            bPressedColor: "#2288f0"
            bBorderColor: "#042647"

            visible: mIsActive

            Component.onCompleted: {
                sButtonChecked.connect(function() {
                    fToggle()
                    fireMenu.update()
                })
            }
        }

        BUTTON {
            id: changeButton
            bCanToggle: false
            anchors.right: fireButton.left
            anchors.verticalCenter: fireButton.verticalCenter
            anchors.rightMargin: 10
            width: 80
            height: 25
            bText: "Change"
            bBorderWidth: 1
            bBorderRadius: 10
            bColor: "#A7C7E7"
            bEnteredColor: "#84b3e3"
            bPressedColor: "#2288f0"
            bBorderColor: "#042647"

            visible: mIsActive

            Component.onCompleted: {
                sButtonChecked.connect(Buttons.changeButtonImplementation)
            }
        }

        BUTTON {
            id: forceDeleteButton
            bCanToggle: false
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            anchors.margins: 10
            width: 80
            height: 25
            bText: "Force delete"
            bBorderWidth: 1
            bBorderRadius: 10
            bColor: "#e03c36"
            bEnteredColor: "#de332c"
            bPressedColor: "#db1c14"
            bBorderColor: "#470404"

            visible: mIsActive ? false : true

            Component.onCompleted: {
                sButtonChecked.connect(Buttons.forceDeleteButtonImplementation)
            }
        }

        Item {
            id: fireMenuItem
            anchors.fill: parent

            visible: fireButton.isButtonOn

            Rectangle {
                anchors.fill: parent
                opacity: 0.8
                MouseArea {
                    anchors.fill: parent
                    z: fireButton.z - 1
                    onClicked: {
                        fireButton.fSwitchOff()
                    }
                }
            }


            FIREWINDOW {
                id: fireMenu
                anchors.centerIn: parent
                width: 200
                height: 200

                Component.onCompleted: {
                    fireCancelButtonRef.sButtonChecked.connect(fireButton.fSwitchOff)
                    fireAcceptButtonRef.sButtonChecked.connect(function() {
                        fireButton.fSwitchOff()
                        Buttons.fireButtonImplementation()
                    })
                }
            }
        }
    }
}

