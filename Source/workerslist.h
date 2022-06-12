#ifndef WORKERSLIST_H
#define WORKERSLIST_H

#include <QObject>
#include "worker.h"
#include <QVector>
#include <QModelIndex>
#include <QJSValue>
#include <QtSql/QSqlQuery>

class WorkersList : public QObject
{
    Q_OBJECT

private:
    // List of workers
    QVector<Worker*> m_Workers;

public:
    explicit WorkersList(QObject * parent = nullptr) : QObject(parent) {};

    explicit WorkersList(QSqlQuery idsFromDB, QObject * parent = nullptr);

    ~WorkersList();

    // Sets worker at index. Only if ids equals. Uses by model.
    bool setWorkerAt(int index, Worker* worker);
    // Getter for m_Workers
    const QVector<Worker*>& workersList() const;

    Q_INVOKABLE int size() const;

signals:
    // Emits before worker added to list. Uses by model.
    void preWorkerAdded();
    // Emits after worker added to list. Uses by model.
    void postWorkerAdded();
    // Emits before worker deleted from list. Uses by model.
    void preWorkerDeleted(int index);
    // Emits after worker deleted from list. Uses by model.
    void postWorkerDeleted();

// Slots. Uses in qml.
public slots:
    // Adds new worker to list.
    void addWorker();
    // Move worker to another list
    void moveToList(const QModelIndex& index, QJSValue& list);
    // Deletes worker from list and clears memory
    void forceDelete(const QModelIndex& index);

private:
    // Deletes worker from list.
    void deleteWorker(const QModelIndex& index);
};

#endif // WORKERSLIST_H
