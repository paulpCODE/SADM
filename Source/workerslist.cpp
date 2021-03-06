#include "workerslist.h"

WorkersList::WorkersList(QSqlQuery idsFromDB, QObject *parent) : QObject(parent)
{
    if(idsFromDB.exec()) {
        while (idsFromDB.next()) {
            m_Workers.push_back(Worker::buildExistingWorker(idsFromDB.value(0).toUInt()));
        }
    } else {
        qDebug() << "Execute failed in WorkersList::WorkersList";
    }
}

WorkersList::~WorkersList()
{
    if(m_Workers.size() > 0) {
        for(auto worker : m_Workers) {
            delete worker;
        }
    }
    m_Workers.clear();
}

bool WorkersList::setWorkerAt(int index, Worker *worker)
{
    if(index < 0 || index > m_Workers.size()) {
        return false;
    }

    if(m_Workers[index]->ID() != worker->ID()) {
        qFatal("IDS NOT EQUAL IN WorkersList::setWorkerAt(int index, Worker *worker)");
    }

    m_Workers[index]->change()->copyData(worker);

    return true;
}

const QVector<Worker *>& WorkersList::workersList() const
{
    return m_Workers;
}

int WorkersList::size() const
{
    return m_Workers.size();
}

void WorkersList::addWorker()
{
    emit preWorkerAdded();

    Worker* newWorker = *Worker::buildNewWorker();

    m_Workers.push_front(newWorker);

    emit postWorkerAdded();
}

void WorkersList::moveToList(const QModelIndex &index, QJSValue &list)
{
    if(index.row() < 0 || index.row() > m_Workers.size() - 1) {
        qDebug() << "Index out of bounds in WorkersList::moveToList";
        return;
    }

    WorkersList* listptr = qobject_cast<WorkersList*>(list.toQObject());

    if(!listptr) {
        qDebug() << "listptr is null in WorkersList::moveToList";
        return;
    }

    if(listptr == this) {
        qDebug() << "The list == this in WorkersList::moveToList";
        return;
    }

    listptr->m_Workers.push_front(m_Workers.value(index.row()));

    deleteWorker(index);
}

void WorkersList::forceDelete(const QModelIndex &index)
{
    if(index.row() < 0 || index.row() > m_Workers.size() - 1) {
        qDebug() << "Index out of bounds in WorkersList::moveToList";
        return;
    }

    auto worker = m_Workers.value(index.row());

    deleteWorker(index);

    worker->forceDelete();

    delete worker;
}

void WorkersList::deleteWorker(const QModelIndex &index)
{
    emit preWorkerDeleted(index.row());

    m_Workers.remove(index.row());

    emit postWorkerDeleted();
}
