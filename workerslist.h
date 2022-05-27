#ifndef WORKERSLIST_H
#define WORKERSLIST_H

#include <QObject>
#include <worker.h>
#include <QVector>

class WorkersList : public QObject
{
    Q_OBJECT

private:
    QVector<Worker*> m_Workers;

public:
    explicit WorkersList(QObject * parent = nullptr) : QObject(parent) {};
    ~WorkersList();

    bool setWorkerAt(int index, Worker* worker);
    const QVector<Worker*>& workersList() const;

signals:
    void preWorkerAdded();
    void postWorkerAdded();
    //void preWorkerFired(int index);
    //void postWorkerFired();

public slots:

    void addWorker();
    //void fireWorker(int index);

};

#endif // WORKERSLIST_H
