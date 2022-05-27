#include "worker.h"

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

WorkerBuilder *const Worker::buildNewWorker()
{
    return WorkerBuilder::build();
}

WorkerBuilder *const Worker::changeWorker(Worker *worker)
{
    return WorkerBuilder::build(worker);
}


WorkerBuilder *const WorkerBuilder::build(Worker* worker)
{
    if(!m_Instance) {
        m_Instance = new WorkerBuilder();
    }
    if(!worker) {
        qFatal("WORKER IS NULL IN WorkerBuilder::build(Worker*& worker)\n");
    }
    m_Instance->m_BuildedWorker = worker;
    return m_Instance;
}

WorkerBuilder *const WorkerBuilder::setStatus(Worker::WorkerStatus status)
{
    m_BuildedWorker->m_Status = status;
    return this;
}

WorkerBuilder * const WorkerBuilder::setFirstName(const QString &first)
{
    m_BuildedWorker->m_Name.first = first;
    return this;
}

WorkerBuilder * const WorkerBuilder::setLastName(const QString &last)
{
    m_BuildedWorker->m_Name.second = last;
    return this;
}

WorkerBuilder *const WorkerBuilder::setGender(bool male)
{
    if(male) {
        m_BuildedWorker->m_Gender = 'M';
    }  else {
        m_BuildedWorker->m_Gender = 'F';
    }
    return this;
}

WorkerBuilder *const WorkerBuilder::setBirthDate(const QDate &birthDate)
{
    m_BuildedWorker->m_BirthDate = birthDate;
    return this;
}

WorkerBuilder *const WorkerBuilder::setEmploymentDate(const QDate &employmentDate)
{
    m_BuildedWorker->m_EmploymentDate = employmentDate;
    return this;
}

WorkerBuilder * const WorkerBuilder::setFireDate(const QDate &fireDate)
{
    m_BuildedWorker->m_FireDate = fireDate;
    return this;
}

WorkerBuilder *const WorkerBuilder::setSalary(unsigned int salary)
{
    m_BuildedWorker->m_Salary = salary;
    return this;
}

WorkerBuilder *const WorkerBuilder::setAdditionalInfo(const QString &info)
{
    m_BuildedWorker->m_AdditionalInfo = info;
    return this;
}

WorkerBuilder * const WorkerBuilder::copyData(const Worker * const from)
{
    m_BuildedWorker->m_Status = from->Status();
    m_BuildedWorker->m_Name = from->Name();
    m_BuildedWorker->m_Gender = from->Gender();
    m_BuildedWorker->m_BirthDate = from->BirthDate();
    m_BuildedWorker->m_EmploymentDate = from->EmploymentDate();
    m_BuildedWorker->m_FireDate = from->FireDate();
    m_BuildedWorker->m_Salary = from->Salary();
    m_BuildedWorker->m_AdditionalInfo = from->AdditionalInfo();
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

