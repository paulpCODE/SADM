#ifndef WORKER_H
#define WORKER_H

#include <QObject>
#include <QDate>

class WorkerBuilder;

class Worker : public QObject
{
    Q_OBJECT

    friend class WorkerBuilder;

public:
    enum WorkerStatus
    {
        ACTIVE,
        FIRED
    };
    Q_ENUM(WorkerStatus)

private:

    unsigned int            m_ID;
    WorkerStatus            m_Status;
    QPair<QString, QString> m_Name;
    QChar                    m_Gender;
    QDate                   m_BirthDate;
    QDate                   m_EmploymentDate;
    QDate                   m_FireDate;
    unsigned int            m_Salary;
    QString                 m_AdditionalInfo;

    explicit Worker(QObject * parent = nullptr) :
        QObject(parent),
        m_ID(0),
        m_Status(WorkerStatus::ACTIVE),
        m_Gender('M'),
        m_Salary(0)
    {};

    Worker(const Worker&) = delete;
    Worker(Worker&&) = delete;
    Worker&& operator = (const Worker&) = delete;

public:
    static WorkerBuilder *const changeWorker(Worker * worker);
    static WorkerBuilder *const buildNewWorker();

    ~Worker() {};

    unsigned int ID() const;
    WorkerStatus Status() const;
    const QPair<QString, QString> &Name() const;
    QChar Gender() const;
    const QDate &BirthDate() const;
    const QDate &EmploymentDate() const;
    const QDate &FireDate() const;
    unsigned int Salary() const;
    const QString &AdditionalInfo() const;

    WorkerBuilder *const change();
};

class WorkerBuilder
{
    static WorkerBuilder * m_Instance;
    Worker * m_BuildedWorker;

    WorkerBuilder() : m_BuildedWorker(nullptr) {};

    WorkerBuilder(const WorkerBuilder&) = delete;
    WorkerBuilder(WorkerBuilder&&) = delete;
    WorkerBuilder&& operator = (const WorkerBuilder&) = delete;
public:

    static WorkerBuilder *const build(Worker* worker = new Worker());

    WorkerBuilder *const setStatus(Worker::WorkerStatus status);
    WorkerBuilder *const setFirstName(const QString& first);
    WorkerBuilder *const setLastName(const QString& last);
    WorkerBuilder *const setGender(bool male);
    WorkerBuilder *const setBirthDate(const QDate& birthDate);
    WorkerBuilder *const setEmploymentDate(const QDate& employmentDate);
    WorkerBuilder *const setFireDate(const QDate& fireDate);
    WorkerBuilder *const setSalary(unsigned int salary);
    WorkerBuilder *const setAdditionalInfo(const QString& info);
    WorkerBuilder *const copyData(const Worker *const from);
    Worker* getWorker();

    operator Worker* ();
};

#endif // WORKER_H
