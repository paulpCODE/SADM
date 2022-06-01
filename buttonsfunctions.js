
.import "modelfunctions.js" as ModelF

// Contains buttons Implementation

function activeButtonImplementation() {
    ModelF.toggleListToActive()
}

function firedButtonImplementation() {
    ModelF.toggleListToFired()
}

function addButtonImplementation() {
    if(addButton.isButtonOn) {
        ModelF.addActiveWorker()
        list.changeIndex(0)
        ModelF.updateChangeWindow()
    }
    if(!addButton.isButtonOn) {
        activeWorkersList.forceDelete(model.index(list.currentIndex, 0))
        list.changeIndex(list.currentIndex - 1)
    }
}

function saveButtonImplementation() {
    ModelF.updateModel()
    ModelF.updateShowWindow()
}

function cancelButtonImplementation() {
    if(addButton.isButtonOn) {
        addButton.sButtonChecked()
    } else {
        wchangeandshowwindow.wshowMode()
    }
}

function changeButtonImplementation() {
    ModelF.updateChangeWindow()
}

function fireButtonImplementation() {

}

function sPreIndexChangedImplementation() {

}

function sPostIndexChangedImplementation() {
    ModelF.updateShowWindow()
}
