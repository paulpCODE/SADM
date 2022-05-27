#include "workerslist.h"

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

void WorkersList::addWorker()
{
    emit preWorkerAdded();

    Worker* newWorker = *Worker::buildNewWorker();

    m_Workers.push_front(newWorker);

    emit postWorkerAdded();
}
