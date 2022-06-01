#include "workerslistmodel.h"
#include <workerslist.h>

int WorkersListModel::rowCount(const QModelIndex &parent) const
{
    // For list models only the root node (an invalid parent) should return the list's size. For all
    // other (valid) parents, rowCount() should return 0 so that it does not become a tree model.
    if (parent.isValid() || !m_list)
        return 0;

    return m_list->workersList().size();
}

QVariant WorkersListModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || !m_list)
        return QVariant();

    const Worker* const item = m_list->workersList().at(index.row());
    switch (role) {
    case WorkerStatusRole: return QVariant(item->Status());
    case FirstNameRole: return QVariant(item->Name().first);
    case LastNameRole: return QVariant(item->Name().second);
    case GenderRole: return QVariant(item->Gender());
    case BirthDateRole: return QVariant(item->BirthDate());
    case EmploymentDateRole: return QVariant(item->EmploymentDate());
    case FireDateRole: return QVariant(item->FireDate());
    case FireReasonRole: return QVariant(item->FireReason());
    case SalaryRole: return QVariant(item->Salary());
    case AdditionalInfoRole: return QVariant(item->AdditionalInfo());
    }
    return QVariant();
}

bool WorkersListModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if(!m_list){
        return false;
    }
    if (data(index, role) != value) {
        Worker* const item = m_list->workersList().at(index.row());

        switch(role) {
        case WorkerStatusRole:  Worker::changeWorker(item)->setStatus(Worker::WorkerStatus(value.toInt())); break;
        case FirstNameRole:     Worker::changeWorker(item)->setFirstName(value.toString()); break;
        case LastNameRole:      Worker::changeWorker(item)->setLastName(value.toString()); break;
        case GenderRole:        Worker::changeWorker(item)->setGender(value.toBool()); break;
        case BirthDateRole:     Worker::changeWorker(item)->setBirthDate(value.toDate()); break;
        case EmploymentDateRole:Worker::changeWorker(item)->setEmploymentDate(value.toDate()); break;
        case FireDateRole:      Worker::changeWorker(item)->setFireDate(value.toDate()); break;
        case FireReasonRole:    Worker::changeWorker(item)->setFireReason(Worker::WorkerFireReason(value.toInt())); break;
        case SalaryRole:        Worker::changeWorker(item)->setSalary(value.toUInt()); break;
        case AdditionalInfoRole:Worker::changeWorker(item)->setAdditionalInfo(value.toString()); break;
        default: break;
        }

        if(m_list->setWorkerAt(index.row(),item)) {
            emit dataChanged(index, index, QVector<int>() << role);
            return true;
        }
    }
    return false;
}

Qt::ItemFlags WorkersListModel::flags(const QModelIndex &index) const
{
    if(!index.isValid())
        return Qt::NoItemFlags;

    return Qt::ItemIsEditable;
}

QHash<int, QByteArray> WorkersListModel::roleNames() const
{
    QHash<int, QByteArray> Roles;
    Roles[WorkerStatusRole] = "status";
    Roles[FirstNameRole] = "firstname";
    Roles[LastNameRole] = "lastname";
    Roles[GenderRole] = "gender";
    Roles[BirthDateRole] = "birthdate";
    Roles[EmploymentDateRole] = "employmentdate";
    Roles[FireDateRole] = "firedate";
    Roles[FireReasonRole] = "firereason";
    Roles[SalaryRole] = "salary";
    Roles[AdditionalInfoRole] = "additionalinfo";
    return Roles;

}

WorkersList *WorkersListModel::getList() const
{
    return m_list;
}

void WorkersListModel::setList(WorkersList *newList)
{
    beginResetModel();
    if(m_list){
        m_list->disconnect(this);
    }

    m_list = newList;

    if(m_list){
        connect(m_list,&WorkersList::preWorkerAdded,this,[=](){
            const int index = 0;// вставка в начало
            beginInsertRows(QModelIndex(),index,index);
        });
        connect(m_list,&WorkersList::postWorkerAdded,this,[=](){
            endInsertRows();
        });
        connect(m_list,&WorkersList::preWorkerDeleted,this,[=](int index){
            beginRemoveRows(QModelIndex(),index,index);
        });
        connect(m_list,&WorkersList::postWorkerDeleted,this,[=](){
            endRemoveRows();
        });
    }

    endResetModel();;
}

QDate JSQVariantConverter::toDate(const QVariant &value)
{
    return value.toDate();
}

QString JSQVariantConverter::toString(const QVariant &value)
{
    return value.toString();
}

int JSQVariantConverter::toInt(const QVariant &value)
{
    return value.toInt();
}
