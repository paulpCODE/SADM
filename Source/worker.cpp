#include "worker.h"
#include "sqlmanager.h"
#include "iddistributor.h"

WorkerBuilder* WorkerBuilder::m_Instance = nullptr;

unsigned int Worker::ID() const
{
    return m_ID;
}

Worker::WorkerStatus Worker::Status() const
{
    return m_Status;
}

const QPair<QString, QString> &Worker::Name() const
{
    return m_Name;
}

QChar Worker::Gender() const
{
    return m_Gender;
}

const QDate &Worker::BirthDate() const
{
    return m_BirthDate;
}

const QDate &Worker::EmploymentDate() const
{
    return m_EmploymentDate;
}

const QDate &Worker::FireDate() const
{
    return m_FireDate;
}

unsigned int Worker::Salary() const
{
    return m_Salary;
}

const QString &Worker::AdditionalInfo() const
{
    return m_AdditionalInfo;
}

WorkerBuilder * const Worker::change()
{
    return Worker::changeWorker(this);
}

void Worker::forceDelete()
{
    SQLManager::deleteWorker(m_ID);
    IDDistributor::freeID(m_ID);
}

WorkerBuilder *const Worker::buildNewWorker()
{
    return WorkerBuilder::build();
}

Worker *Worker::buildExistingWorker(unsigned int id)
{
    Worker* worker = new Worker();

    worker->m_ID = id;

    auto query = SQLManager::selectWorkerInfoByID(id);

    if(!query.exec()) {
        qFatal("Cant execute query in Worker::buildExistingWorker");
    }

    // index of worker_id field. We dont set id. Its a reason of usage ++index construction in while loop.
    int index = 0;

    // worker_id - first_name - last_name - status - gender - birth_date
    // employment_date - fire_date - fire_reason - salary - additional_info
    while (query.next()) {
        worker->m_Name.first = query.value(++index).toString();
        worker->m_Name.second = query.value(++index).toString();
        auto status = query.value(++index).toString();
        if(status == "ACTIVE") {
            worker->m_Status = ACTIVE;
        } else {
            worker->m_Status = FIRED;
        }
        worker->m_Gender = query.value(++index).toChar();
        worker->m_BirthDate = QDate::fromString(query.value(++index).toString());
        worker->m_EmploymentDate = QDate::fromString(query.value(++index).toString());
        if(status == "ACTIVE") {
            worker->m_FireDate = QDate::fromString(query.value(++index).toString());
            auto firereason = query.value(++index).toString();
            if(firereason == "NECESSARY") {
                worker->m_FireReason = NECESSARY;
            } else if (firereason == "EXCESSIVE") {
                worker->m_FireReason = EXCESSIVE;
            } else {
                worker->m_FireReason = NONE;
            }
        } else {
            index += 2;
        }
        worker->m_Salary = query.value(++index).toUInt();
        worker->m_AdditionalInfo = query.value(++index).toString();
    }

    return worker;
}

Worker::WorkerFireReason Worker::FireReason() const
{
    return m_FireReason;
}

WorkerBuilder *const Worker::changeWorker(Worker *worker)
{
    return WorkerBuilder::build(worker, false);
}


WorkerBuilder *const WorkerBuilder::build(Worker* worker, bool isNew)
{
    if(!m_Instance) {
        m_Instance = new WorkerBuilder();
    }
    if(!worker) {
        qFatal("WORKER IS NULL IN WorkerBuilder::build(Worker* worker)\n");
    }
    if(isNew) {
        worker->m_ID = IDDistributor::getID();
        //Insert into database
        SQLManager::insertIntoWorkers(worker);
    }
    m_Instance->m_BuildedWorker = worker;
    return m_Instance;
}


// worker_id - first_name - last_name - status - gender - birth_date
// employment_date - fire_date - fire_reason - salary - additional_info
WorkerBuilder *const WorkerBuilder::setStatus(Worker::WorkerStatus status)
{
    m_BuildedWorker->m_Status = status;
    QString value;
    if(status == Worker::ACTIVE) {
        value = "ACTIVE";
    } else {
        value = "FIRED";
    }
    SQLManager::updateColumnByName(m_BuildedWorker->ID(), "status", value);
    return this;
}

WorkerBuilder * const WorkerBuilder::setFirstName(const QString &first)
{
    m_BuildedWorker->m_Name.first = first;
    SQLManager::updateColumnByName(m_BuildedWorker->ID(), "first_name", first);
    return this;
}

WorkerBuilder * const WorkerBuilder::setLastName(const QString &last)
{
    m_BuildedWorker->m_Name.second = last;
    SQLManager::updateColumnByName(m_BuildedWorker->ID(), "last_name", last);
    return this;
}

WorkerBuilder *const WorkerBuilder::setGender(bool male)
{
    if(male) {
        m_BuildedWorker->m_Gender = 'M';
        SQLManager::updateColumnByName(m_BuildedWorker->ID(), "gender", "M");
    }  else {
        m_BuildedWorker->m_Gender = 'F';
        SQLManager::updateColumnByName(m_BuildedWorker->ID(), "gender", "F");
    }
    return this;
}

WorkerBuilder * const WorkerBuilder::setGender(const QChar &gender)
{
    m_BuildedWorker->m_Gender = gender;
    SQLManager::updateColumnByName(m_BuildedWorker->ID(), "gender", gender);
    return this;
}

WorkerBuilder *const WorkerBuilder::setBirthDate(const QDate &birthDate)
{
    m_BuildedWorker->m_BirthDate = birthDate;
    SQLManager::updateColumnByName(m_BuildedWorker->ID(), "birth_date", birthDate.toString());
    return this;
}

WorkerBuilder *const WorkerBuilder::setEmploymentDate(const QDate &employmentDate)
{
    m_BuildedWorker->m_EmploymentDate = employmentDate;
    SQLManager::updateColumnByName(m_BuildedWorker->ID(), "employment_date", employmentDate.toString());
    return this;
}

WorkerBuilder * const WorkerBuilder::setFireDate(const QDate &fireDate)
{
    m_BuildedWorker->m_FireDate = fireDate;
    SQLManager::updateColumnByName(m_BuildedWorker->ID(), "fire_date", fireDate.toString());
    return this;
}

WorkerBuilder * const WorkerBuilder::setFireReason(Worker::WorkerFireReason reason)
{
    m_BuildedWorker->m_FireReason = reason;
    QString value;
    if(reason == Worker::NECESSARY) {
        value = "NECESSARY";
    } else if(reason == Worker::EXCESSIVE) {
        value = "EXCESSIVE";
    } else {
        value = "NONE";
    }
    SQLManager::updateColumnByName(m_BuildedWorker->ID(), "fire_reason", value);
    return this;
}

WorkerBuilder *const WorkerBuilder::setSalary(unsigned int salary)
{
    m_BuildedWorker->m_Salary = salary;
    SQLManager::updateColumnByName(m_BuildedWorker->ID(), "salary", QString::number(salary));
    return this;
}

WorkerBuilder *const WorkerBuilder::setAdditionalInfo(const QString &info)
{
    m_BuildedWorker->m_AdditionalInfo = info;
    SQLManager::updateColumnByName(m_BuildedWorker->ID(), "additional_info", info);
    return this;
}

WorkerBuilder * const WorkerBuilder::copyData(const Worker * const from)
{
    setStatus(from->Status());
    setFirstName(from->Name().first);
    setLastName(from->Name().second);
    setGender(from->Gender());
    setBirthDate(from->BirthDate());
    setEmploymentDate(from->EmploymentDate());
    setFireDate(from->FireDate());
    setSalary(from->Salary());
    setAdditionalInfo(from->AdditionalInfo());
    return this;
}

Worker *WorkerBuilder::getWorker()
{
    Worker * tmp = m_BuildedWorker;
    m_BuildedWorker = nullptr;
    return tmp;
}

WorkerBuilder::operator Worker *()
{
    return getWorker();
}

