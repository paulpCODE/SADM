
.import Model 1.0 as M
.import Converter 1.0 as Qvar

//Contains functions for model

function updateShowWindow() {
    if(list.currentIndex === -1) {
        return
    }

    var modelIndex = model.index(list.currentIndex, 0)

    wchangeandshowwindow.wshow.mFirstName = Qvar.toString(model.data(modelIndex, M.WorkersModel.FirstNameRole))
    wchangeandshowwindow.wshow.mLastName = Qvar.toString(model.data(modelIndex, M.WorkersModel.LastNameRole))
    var gender = Qvar.toString(model.data(modelIndex, M.WorkersModel.GenderRole))
    if(gender === "M") {
        wchangeandshowwindow.wshow.mGender = "Male"
    } else {
        wchangeandshowwindow.wshow.mGender = "Female"
    }
    wchangeandshowwindow.wshow.mBirthDate = Qt.formatDate(Qvar.toDate(model.data(modelIndex, M.WorkersModel.BirthDateRole)), 'd/MM/yyyy')
    wchangeandshowwindow.wshow.mEmploymentDate = Qt.formatDate(Qvar.toDate(model.data(modelIndex, M.WorkersModel.EmploymentDateRole)), 'd/MM/yyyy')
    wchangeandshowwindow.wshow.mSalary = Qvar.toInt(model.data(modelIndex, M.WorkersModel.SalaryRole))
    wchangeandshowwindow.wshow.mAdditionalInfo = Qvar.toString(model.data(modelIndex, M.WorkersModel.AdditionalInfoRole))

    if(model.data(modelIndex, M.WorkersModel.WorkerStatusRole) === M.Worker.WorkerStatus.ACTIVE) {
        wchangeandshowwindow.wshow.mIsActive = true
    } else {
        wchangeandshowwindow.wshow.mIsActive = false
    }

    if(!wchangeandshowwindow.wshow.mIsActive) {
        wchangeandshowwindow.wshow.mFireDate = Qt.formatDate(Qvar.toDate(model.data(modelIndex, M.WorkersModel.FireDateRole)), 'd/MM/yyyy')

        var firereason = model.data(modelIndex, M.WorkersModel.FireReasonRole)
        if(firereason === M.Worker.WorkerFireReason.NECESSARY) {
            wchangeandshowwindow.wshow.mFireReason = "Necessary"
        } else if(firereason === M.Worker.WorkerFireReason.EXCESSIVE) {
            wchangeandshowwindow.wshow.mFireReason = "Excessive"
        } else {
            wchangeandshowwindow.wshow.mFireReason = ""
        }
    }

    wchangeandshowwindow.wshowMode()
}

function updateChangeWindow() {
    if(list.currentIndex === -1) {
        return
    }

    var modelIndex = model.index(list.currentIndex, 0)

    wchangeandshowwindow.wchange.mFirstName = Qvar.toString(model.data(modelIndex, M.WorkersModel.FirstNameRole))
    wchangeandshowwindow.wchange.mLastName = Qvar.toString(model.data(modelIndex, M.WorkersModel.LastNameRole))
    var gender = Qvar.toString(model.data(modelIndex, M.WorkersModel.GenderRole))
    if(gender === "M") {
        wchangeandshowwindow.wchange.isMale = true
    } else {
        wchangeandshowwindow.wchange.isMale = false
    }
    wchangeandshowwindow.wchange.mBirthDateInput.setDate(Qvar.toDate(model.data(modelIndex, M.WorkersModel.BirthDateRole)))
    wchangeandshowwindow.wchange.mEmploymentDateInput.setDate(Qvar.toDate(qsTr(model.data(modelIndex, M.WorkersModel.EmploymentDateRole))))
    wchangeandshowwindow.wchange.mSalary = Qvar.toInt(model.data(modelIndex, M.WorkersModel.SalaryRole))
    wchangeandshowwindow.wchange.mAdditionalInfo = Qvar.toString(model.data(modelIndex, M.WorkersModel.AdditionalInfoRole))

    wchangeandshowwindow.wchange.update()

    wchangeandshowwindow.wchangeMode()

    console.log(wchangeandshowwindow.wchange.mFirstName)
    console.log(wchangeandshowwindow.wchange.mLastName)
    console.log(gender)
    console.log(wchangeandshowwindow.wchange.mSalary)
}

function updateModel() {
    if(list.currentIndex === -1) {
        return
    }

    if(wchangeandshowwindow.wchange.isChanged) {
        var modelIndex = model.index(list.currentIndex, 0)

        model.setData(modelIndex, qsTr(wchangeandshowwindow.wchange.mFirstName), M.WorkersModel.FirstNameRole)
        model.setData(modelIndex, qsTr(wchangeandshowwindow.wchange.mLastName), M.WorkersModel.LastNameRole)
        model.setData(modelIndex, wchangeandshowwindow.wchange.isMale, M.WorkersModel.GenderRole)
        model.setData(modelIndex, wchangeandshowwindow.wchange.mBirthDateInput.currentDate, M.WorkersModel.BirthDateRole)
        model.setData(modelIndex, wchangeandshowwindow.wchange.mEmploymentDateInput.currentDate, M.WorkersModel.EmploymentDateRole)
        model.setData(modelIndex, qsTr(wchangeandshowwindow.wchange.mSalary), M.WorkersModel.SalaryRole)
        model.setData(modelIndex, qsTr(wchangeandshowwindow.wchange.mAdditionalInfo), M.WorkersModel.AdditionalInfoRole)
    }
}

function rowCount() {
   return model.list.size()
}

function addActiveWorker() {
    activeWorkersList.addWorker()
}

function moveToFired(index) {
    if(index === -1) {
        return
    }

    activeWorkersList.moveToList(index, firedWorkersList)
}

function forceDelete(index) {
    if(index === -1) {
        return
    }

    model.list.forceDelete(index)
}

function toggleListToActive() {
    model.list = activeWorkersList
}

function toggleListToFired() {
    model.list = firedWorkersList
}
