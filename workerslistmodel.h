#ifndef WORKERSLISTMODEL_H
#define WORKERSLISTMODEL_H

#include <QAbstractListModel>

class WorkersListModel : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(WorkersList* list READ getList WRITE setList)
    // QAbstractItemModel interface
private:
    class WorkersList *m_list;

public:
    enum RoleEnums {
        WORKERSTATUS = Qt::UserRole + 1,
        FIRSTNAME,
        LASTNAME,
        GENDER,
        BIRTHDATE,
        EMPLOYMENTDATE,
        FIREDATE,
        SALARY,
        ADDITIONALINFO
    };
    Q_ENUM(RoleEnums)

    int rowCount(const QModelIndex &parent) const override;
    QVariant data(const QModelIndex &index, int role) const override;
    bool setData(const QModelIndex &index, const QVariant &value, int role) override;
    Qt::ItemFlags flags(const QModelIndex &index) const override;
    QHash<int, QByteArray> roleNames() const override;

    explicit WorkersListModel(QObject * parent = nullptr) : QAbstractListModel(parent), m_list(nullptr) {}

    WorkersList *getList() const;
    void setList(WorkersList *newList);
};

#endif // WORKERSLISTMODEL_H
