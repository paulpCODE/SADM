
.import Model 1.0 as CPP

.import WorkerClass 1.0 as Enums

//Contains functions for model

//Change

function updateShowWindow() {

    wchangeandshow.wshowMode()

    if(wlist.listRef.currentIndex === -1) {
        return
    }

    var modelIndex = model.index(wlist.listRef.currentIndex, 0)

    wchangeandshow.wshow.mFirstName = model.stringData(
                modelIndex, CPP.WorkersModel.FirstNameRole)

    wchangeandshow.wshow.mLastName = model.stringData(
                modelIndex, CPP.WorkersModel.LastNameRole)

    var gender = model.stringData(
                modelIndex, CPP.WorkersModel.GenderRole)
    if(gender === "M") {
        wchangeandshow.wshow.mGender = "Male"
    } else {
        wchangeandshow.wshow.mGender = "Female"
    }

    wchangeandshow.wshow.mBirthDate = Qt.formatDate(
                model.dateData(modelIndex, CPP.WorkersModel.BirthDateRole), 'd/MM/yyyy')

    wchangeandshow.wshow.mEmploymentDate = Qt.formatDate(
                model.dateData(modelIndex, CPP.WorkersModel.EmploymentDateRole), 'd/MM/yyyy')

    wchangeandshow.wshow.mSalary = model.stringData(
                modelIndex, CPP.WorkersModel.SalaryRole)

    wchangeandshow.wshow.mAdditionalInfo = model.stringData(
                modelIndex, CPP.WorkersModel.AdditionalInfoRole)

    if(model.intData(modelIndex, CPP.WorkersModel.WorkerStatusRole) === Enums.Worker.ACTIVE) {
        wchangeandshow.wshow.mIsActive = true
    } else {
        wchangeandshow.wshow.mIsActive = false
    }

    if(!wchangeandshow.wshow.mIsActive) {
        wchangeandshow.wshow.mFireDate = Qt.formatDate(
                    model.dateData(modelIndex, CPP.WorkersModel.FireDateRole), 'd/MM/yyyy')

        var firereason = model.intData(modelIndex, CPP.WorkersModel.FireReasonRole)
        if(firereason === Enums.Worker.NECESSARY) {
            wchangeandshow.wshow.mFireReason = "Necessary"
        } else if(firereason === Enums.Worker.EXCESSIVE) {
            wchangeandshow.wshow.mFireReason = "Excessive"
        } else {
            wchangeandshow.wshow.mFireReason = ""
        }
    }
}

function updateChangeWindow() {

    wchangeandshow.wchangeMode()

    if(wlist.listRef.currentIndex === -1) {
        return
    }

    var modelIndex = model.index(wlist.listRef.currentIndex, 0)

    wchangeandshow.wchange.mFirstName = model.stringData(
                modelIndex, CPP.WorkersModel.FirstNameRole)

    wchangeandshow.wchange.mLastName = model.stringData(
                modelIndex, CPP.WorkersModel.LastNameRole)

    var gender = model.stringData(
                modelIndex, CPP.WorkersModel.GenderRole)
    if(gender === "M") {
        wchangeandshow.wchange.isMale = true
    } else {
        wchangeandshow.wchange.isMale = false
    }

    wchangeandshow.wchange.mBirthDateInput.setDate(model.dateData(
                                                       modelIndex, CPP.WorkersModel.BirthDateRole))

    wchangeandshow.wchange.mEmploymentDateInput.setDate(model.dateData(
                                                            modelIndex, CPP.WorkersModel.EmploymentDateRole))

    wchangeandshow.wchange.mSalary = model.stringData(
                modelIndex, CPP.WorkersModel.SalaryRole)

    wchangeandshow.wchange.mAdditionalInfo = model.stringData(
                modelIndex, CPP.WorkersModel.AdditionalInfoRole)

    wchangeandshow.wchange.update()
}

function updateModel() {
    if(wlist.listRef.currentIndex === -1) {
        return
    }

    if(wchange.isChanged) {
        var modelIndex = model.index(wlist.listRef.currentIndex, 0)

        model.setData(modelIndex, wchangeandshow.wchange.mFirstName, CPP.WorkersModel.FirstNameRole)
        model.setData(modelIndex, wchangeandshow.wchange.mLastName, CPP.WorkersModel.LastNameRole)
        model.setData(modelIndex, wchangeandshow.wchange.isMale, CPP.WorkersModel.GenderRole)
        model.setData(modelIndex, wchangeandshow.wchange.mBirthDateInput.currentDate, CPP.WorkersModel.BirthDateRole)
        model.setData(modelIndex, wchangeandshow.wchange.mEmploymentDateInput.currentDate, CPP.WorkersModel.EmploymentDateRole)
        model.setData(modelIndex, wchangeandshow.wchange.mSalary, CPP.WorkersModel.SalaryRole)
        model.setData(modelIndex, wchangeandshow.wchange.mAdditionalInfo, CPP.WorkersModel.AdditionalInfoRole)
    }
}

function updateModelFiredInfo() {
    if(wlist.listRef.currentIndex === -1) {
        return
    }

    var modelIndex = model.index(wlist.listRef.currentIndex, 0)

    model.setData(modelIndex, wchangeandshow.wshow.fireMenuRef.mFireInput.currentDate, CPP.WorkersModel.FireDateRole)

    if(wchangeandshow.wshow.fireMenuRef.mIsNecessary) {
        model.setData(modelIndex, Enums.Worker.NECESSARY, CPP.WorkersModel.FireReasonRole)
    } else {
        model.setData(modelIndex, Enums.Worker.EXCESSIVE, CPP.WorkersModel.FireReasonRole)
    }
}

function rowCount() {
   return model.list.size()
}

function addActiveWorker() {
    activeWorkersList.addWorker()
}

function moveToFired() {
    if(wlist.listRef.currentIndex === -1) {
        return
    }

    var modelIndex = model.index(wlist.listRef.currentIndex, 0)

    model.setData(modelIndex, Enums.Worker.FIRED, CPP.WorkersModel.WorkerStatusRole)

    activeWorkersList.moveToList(modelIndex, firedWorkersList)
}

function forceDelete() {
    if(wlist.listRef.currentIndex === -1) {
        return
    }

    var modelIndex = model.index(wlist.listRef.currentIndex, 0)

    model.list.forceDelete(modelIndex)
}

function toggleListToActive() {
    model.list = activeWorkersList
}

function toggleListToFired() {
    model.list = firedWorkersList
}
