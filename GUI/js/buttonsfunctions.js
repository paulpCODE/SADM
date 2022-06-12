
.import "modelfunctions.js" as ModelFuncs

// Contains buttons Implementation

function activeButtonImplementation() {
    list.changeIndex(-1)
    ModelFuncs.toggleListToActive()
    if(ModelFuncs.rowCount() !== 0) {
        list.changeIndex(0)
    }
}

function firedButtonImplementation() {
    list.changeIndex(-1)
    ModelFuncs.toggleListToFired()
    if(ModelFuncs.rowCount() !== 0) {
        list.changeIndex(0)
    }
}

function addButtonImplementation() {
    if(addButton.isButtonOn) {
        ModelFuncs.addActiveWorker()
        list.changeIndex(0)
        ModelFuncs.updateChangeWindow()
    }
    if(!addButton.isButtonOn) {
        ModelFuncs.forceDelete(list.currentIndex)
        if(ModelFuncs.rowCount() === 0) {
            list.changeIndex(list.currentIndex - 1)
        }
        ModelFuncs.updateShowWindow()
    }
}

function saveButtonImplementation() {
    ModelFuncs.updateModel()
    wlist.addButtonRef.fSwitchOff()
    ModelFuncs.updateShowWindow()
}

function cancelButtonImplementation() {
    if(wlist.addButtonRef.isButtonOn) {
        wlist.addButtonRef.sButtonChecked()
    } else {
        wchangeandshow.wshowMode()
    }
}

function changeButtonImplementation() {
    ModelFuncs.updateChangeWindow()
}

function fireButtonImplementation() {
    ModelFuncs.moveToFired()
    if(wlist.listRef.currentIndex === ModelFuncs.rowCount()) {
        wlist.listRef.changeIndex(wlist.listRef.currentIndex - 1)
    }
    ModelFuncs.updateShowWindow()
}

function forceDeleteButtonImplementation() {
    ModelFuncs.forceDelete()
    if(wlist.listRef.currentIndex === ModelFuncs.rowCount()) {
        wlist.listRef.changeIndex(wlist.listRef.currentIndex - 1)
    }
    ModelFuncs.updateShowWindow()
}

function sPreIndexChangedImplementation() {
    wchangeandshow.wshow.fireButtonRef.fSwitchOff()
    if(wchangeandshow.isChangeMode()) {
        cancelButtonImplementation()
    }
}

function sPostIndexChangedImplementation() {
    ModelFuncs.updateShowWindow()
}
