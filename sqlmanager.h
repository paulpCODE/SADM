#ifndef SQLMANAGER_H
#define SQLMANAGER_H

#include <QtSql/QSqlDatabase>
#include <QtSql/QSqlQuery>

class Worker;

class SQLManager
{
private:
    SQLManager() = delete;
    SQLManager(const SQLManager&) = delete;
    SQLManager operator = (const SQLManager&) = delete;
    SQLManager(SQLManager&&) = delete;

    static bool createTables();



public:
    // Initialize database. Must be called for SQL functionality.
    static bool initWorkersDatabase();
    // Inserts worker into database.
    static bool insertIntoWorkers(Worker* worker);
    // Updates Worker Info in Database by column name.
    static bool updateColumnByName(unsigned int worker_id, const QString& columnName, const QString& value);
    // Deletes Worker from database.
    static bool deleteWorker(unsigned int id);
    // Selects all workers IDs wirh ACTIVE STATUS.
    static QSqlQuery selectAllActiveWorkersIDs();
    // Selects all workers IDs with FIRED status.
    static QSqlQuery selectAllFiredWorkersIDs();
    // Selects all info about worker by id
    static QSqlQuery selectWorkerInfoByID(unsigned int id);
};

#endif // SQLMANAGER_H
