#include "sqlmanager.h"
#include "worker.h"
#include <QDir>
#include <QtSql/QSqlError>

bool SQLManager::createTables()
{
    QSqlQuery createWorkersCommand;

    createWorkersCommand.prepare(
                "CREATE TABLE IF NOT EXISTS Workers ("
                "worker_id INTEGER PRIMARY KEY NOT NULL,"
                "first_name TEXT NOT NULL,"
                "last_name TEXT NOT NULL,"
                "status TEXT NOT NULL,"
                "gender TEXT NOT NULL,"
                "birth_date TEXT NOT NULL,"
                "employment_date TEXT NOT NULL,"
                "fire_date TEXT,"
                "fire_reason TEXT,"
                "salary TEXT NOT NULL,"
                "additional_info TEXT NOT NULL"
                ")");

    if(!createWorkersCommand.exec()) {
        qDebug()<<"Cant create Workers: " << createWorkersCommand.lastError().text();
        return false;
    }
    return true;
}

bool SQLManager::initWorkersDatabase()
{
    QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE");

    if(!db.isValid()) {
        qDebug() << "DB is not valid!";
        return false;
    }

    db.setDatabaseName(QDir::currentPath() + "/sadmdb.sqlite");

    if(!db.open()) {
        qDebug() << "Cant open DB!";
        return false;
    }

    return createTables();
}

bool SQLManager::insertIntoWorkers(Worker *worker)
{
    if(!worker) {
        qFatal("Worker is null in SQLManager::insertIntoWorkers");
    }

    auto db = QSqlDatabase::database();

    if(!db.isValid()) {
        qFatal("DB isnt valid in SQLManager::insertIntoWorkers. Please, call initDatabase()!");
    }

    QSqlQuery insertWorkerCommand;

    QString status;
    switch (worker->Status()) {
    case Worker::WorkerStatus::ACTIVE: status = "ACTIVE"; break;
    case Worker::WorkerStatus::FIRED: status = "FIRED"; break;
    default: break;
    }

    insertWorkerCommand.prepare(
                "INSERT INTO Workers ("
                "worker_id, first_name, last_name, status, gender,"
                "birth_date, employment_date, salary, additional_info"
                ") "
                "VALUES("
                ":worker_id, :first_name, :last_name, :status, :gender,"
                ":birth_date, :employment_date, :salary, :additional_info"
                ")");
    insertWorkerCommand.bindValue(":worker_id", worker->ID());
    insertWorkerCommand.bindValue(":first_name", worker->Name().first);
    insertWorkerCommand.bindValue(":last_name", worker->Name().second);
    insertWorkerCommand.bindValue(":status", status);
    insertWorkerCommand.bindValue(":gender", worker->Gender());
    insertWorkerCommand.bindValue(":birth_date", worker->BirthDate());
    insertWorkerCommand.bindValue(":employment_date", worker->EmploymentDate());
    insertWorkerCommand.bindValue(":salary", worker->Salary());
    insertWorkerCommand.bindValue(":additional_info", worker->AdditionalInfo());

    if(!insertWorkerCommand.exec()) {
        qDebug() << "Cant insert Worker: " << insertWorkerCommand.lastError().text();
        return false;
    }

    return true;
}

bool SQLManager::updateColumnByName(unsigned int worker_id, const QString &columnName, const QString &value)
{
    auto db = QSqlDatabase::database();

    if(!db.isValid()) {
        qFatal("DB isnt valid in SQLManager::updateColumnByName. Please, call initDatabase()!");
    }

    if(columnName == "worker_id") {
        qDebug() << "You cant update id of worker!";
        return false;
    }

    QSqlQuery updateCommand;

    updateCommand.prepare("UPDATE Workers "
                   "SET " +  columnName + " = :value "
                   "WHERE worker_id = :worker_id");
    updateCommand.bindValue(":value", value);
    updateCommand.bindValue(":worker_id", worker_id);

    if(!updateCommand.exec()) {
        qDebug() << "Cant update worker: " << updateCommand.lastError().text();
        return false;
    }

    return true;
}

bool SQLManager::deleteWorker(unsigned int id)
{
    auto db = QSqlDatabase::database();

    if(!db.isValid()) {
        qFatal("DB isnt valid in SQLManager::deleteWorker. Please, call initDatabase()!");
    }

    QSqlQuery deleteCommand;

    deleteCommand.prepare("DELETE FROM Workers "
                          "WHERE worker_id = :worker_id");
    deleteCommand.bindValue(":worker_id", id);

    if(!deleteCommand.exec()) {
        qDebug() << "Cant delete worker: " << deleteCommand.lastError().text();
        return false;
    }

    return true;
}

QSqlQuery SQLManager::selectWorkerInfoByID(unsigned int id)
{
    auto db = QSqlDatabase::database();

    if(!db.isValid()) {
        qFatal("DB isnt valid in SQLManager::selectAllActiveWorkers. Please, call initDatabase()!");
    }

    QSqlQuery selectCommand;

    selectCommand.prepare("SELECT * FROM Workers "
                          "WHERE worker_id = :worker_id");
    selectCommand.bindValue(":worker_id", id);

    return selectCommand;
}

QSqlQuery SQLManager::selectAllActiveWorkersIDs()
{
    auto db = QSqlDatabase::database();

    if(!db.isValid()) {
        qFatal("DB isnt valid in SQLManager::selectAllActiveWorkers. Please, call initDatabase()!");
    }

    QSqlQuery selectCommand;

    selectCommand.prepare("SELECT worker_id FROM Workers "
                          "WHERE status LIKE 'ACTIVE'");

    return selectCommand;
}

QSqlQuery SQLManager::selectAllFiredWorkersIDs()
{
    auto db = QSqlDatabase::database();

    if(!db.isValid()) {
        qFatal("DB isnt valid in SQLManager::selectAllFiredWorkers. Please, call initDatabase()!");
    }

    QSqlQuery selectCommand;

    selectCommand.prepare("SELECT worker_id FROM Workers "
                          "WHERE status LIKE 'FIRED'");

    return selectCommand;
}
