#ifndef WORKERSLISTMODEL_H
#define WORKERSLISTMODEL_H

#include <QDate>
#include <QAbstractListModel>

//class JSQVariantConverter : public QObject {
//    Q_OBJECT

//public:
//    JSQVariantConverter(QObject * parent = nullptr) : QObject(parent) {}
//    ~JSQVariantConverter() {}

//public slots:
//    QDate toDate(const QVariant& value);
//    QString toString(const QVariant& value);
//    int toInt(const QVariant& value);
//};

class WorkersListModel : public QAbstractListModel
{
    Q_OBJECT
    // List that model shows in ListView
    Q_PROPERTY(WorkersList* list READ getList WRITE setList)
private:
    // List instance
    class WorkersList *m_list;

public:
    // Roles. Registretes in roleNames() method.
    // Uses by model and delegate in qml
    enum RoleEnums {
        WorkerStatusRole = Qt::UserRole + 1,
        FirstNameRole,
        LastNameRole,
        GenderRole,
        BirthDateRole,
        EmploymentDateRole,
        FireDateRole,
        FireReasonRole,
        SalaryRole,
        AdditionalInfoRole
    };
    Q_ENUM(RoleEnums)

    explicit WorkersListModel(QObject * parent = nullptr) : QAbstractListModel(parent), m_list(nullptr) {}

    // Returns row count in model (m_list.size())
    int rowCount(const QModelIndex &parent) const override;
    // Returns data from model by index and role. Uses by js to update information.
    QVariant data(const QModelIndex &index, int role) const override;
    // Sets data to model by index and role. Uses by js for set data to model.
    bool setData(const QModelIndex &index, const QVariant &value, int role) override;
    Qt::ItemFlags flags(const QModelIndex &index) const override;
    // Registretes roles for qml.
    QHash<int, QByteArray> roleNames() const override;

    // Getter from UPROPERTY
    WorkersList *getList() const;
    // Setter from UPROPERTY
    void setList(WorkersList *newList);

//    QString getFirstName(const QModelIndex &index);
//    QString getLastName(const QModelIndex &index);
//    QString getGender(const QModelIndex &index);
//    QDate getBirthDate(const QModelIndex &index);

#endif // WORKERSLISTMODEL_H
