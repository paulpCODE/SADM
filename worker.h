#ifndef WORKER_H
#define WORKER_H

#include <QObject>
#include <QDate>

class WorkerBuilder;

// Worker class. Create new instances with WorkerBuilder. Use Static methods changeWorker(Worker*) or buildNewWorker()
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

    enum WorkerFireReason {
        NONE,
        NECESSARY,
        EXCESSIVE
    };
    Q_ENUM(WorkerFireReason)

private:

    //Workers ID. Generetes with IDManager
    unsigned int            m_ID;
    // Worker Status. Enum.
    WorkerStatus            m_Status;
    // First and Last name. m_Name.first -> first name. m_Name.second -> last name
    QPair<QString, QString> m_Name;
    // Gender. Sets only to 'M' or 'F'. 'M' - Male. 'F' - Female.
    QChar                   m_Gender;
    // Date of birth
    QDate                   m_BirthDate;
    // Date of employment
    QDate                   m_EmploymentDate;
    // Date of fire if worker has been fired.
    QDate                   m_FireDate;
    // Fire Reason if worker has been fired. Enum
    WorkerFireReason        m_FireReason;
    // Salary
    unsigned int            m_Salary;
    // Any Additional Info
    QString                 m_AdditionalInfo;

    // Private Constructor with default values
    explicit Worker(QObject * parent = nullptr) :
        QObject(parent),
        m_ID(0),
        m_Name("Vasya","Petya"),
        m_Status(ACTIVE),
        m_Gender('M'),
        m_BirthDate(),
        m_EmploymentDate(),
        m_FireDate(),
        m_Salary(10000),
        m_FireReason(NONE),
        m_AdditionalInfo("Abra kadabra")
    {};

    Worker(const Worker&) = delete;
    Worker(Worker&&) = delete;
    Worker&& operator = (const Worker&) = delete;

public:
    // Changes existing worker
    static WorkerBuilder *const changeWorker(Worker * worker);
    // Builds new worker and generate ID
    static WorkerBuilder *const buildNewWorker();
    //Changes current worker.
    WorkerBuilder *const change();

    ~Worker() {};

    // Getters for all data.
    unsigned int ID() const;
    WorkerStatus Status() const;
    const QPair<QString, QString> &Name() const;
    QChar Gender() const;
    const QDate &BirthDate() const;
    const QDate &EmploymentDate() const;
    const QDate &FireDate() const;
    WorkerFireReason FireReason() const;
    unsigned int Salary() const;
    const QString &AdditionalInfo() const;
};

// Class for creating and changing Workers. Uses Pattern "Builder".
class WorkerBuilder
{
    static WorkerBuilder * m_Instance;
    Worker * m_BuildedWorker;

    WorkerBuilder() : m_BuildedWorker(nullptr) {};

    WorkerBuilder(const WorkerBuilder&) = delete;
    WorkerBuilder(WorkerBuilder&&) = delete;
    WorkerBuilder&& operator = (const WorkerBuilder&) = delete;
public:
    // public function for all workers operation. Change | Build new. Please, use Worker class functions.
    static WorkerBuilder *const build(Worker* worker = new Worker());

    // All setters for data. ID dont changes from builder.
    WorkerBuilder *const setStatus(Worker::WorkerStatus status);
    WorkerBuilder *const setFirstName(const QString& first);
    WorkerBuilder *const setLastName(const QString& last);
    WorkerBuilder *const setGender(bool male);
    WorkerBuilder *const setBirthDate(const QDate& birthDate);
    WorkerBuilder *const setEmploymentDate(const QDate& employmentDate);
    WorkerBuilder *const setFireDate(const QDate& fireDate);
    WorkerBuilder *const setFireReason(Worker::WorkerFireReason reason);
    WorkerBuilder *const setSalary(unsigned int salary);
    WorkerBuilder *const setAdditionalInfo(const QString& info);
    // Copy data from other worker. ID dont copies.
    WorkerBuilder *const copyData(const Worker *const from);
    // function for get Changed | Created worker.
    Worker* getWorker();
    // function for get Changed | Created worker. Use *(WorkerBuilder) expression.
    operator Worker* ();
};

#endif // WORKER_H
