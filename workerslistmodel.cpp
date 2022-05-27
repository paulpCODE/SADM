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
    case WORKERSTATUS: return QVariant(item->Status());
    case FIRSTNAME: return QVariant(item->Name().first);
    case LASTNAME: return QVariant(item->Name().second);
    case GENDER: return QVariant(item->Gender());
    case BIRTHDATE: return QVariant(item->BirthDate());
    case EMPLOYMENTDATE: return QVariant(item->EmploymentDate());
    case FIREDATE: return QVariant(item->FireDate());
    case SALARY: return QVariant(item->Salary());
    case ADDITIONALINFO: return QVariant(item->AdditionalInfo());
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
        case WORKERSTATUS:  Worker::changeWorker(item)->setStatus(Worker::WorkerStatus(value.toInt())); break;
        case FIRSTNAME:     Worker::changeWorker(item)->setFirstName(value.toString()); break;
        case LASTNAME:      Worker::changeWorker(item)->setLastName(value.toString()); break;
        case GENDER:        Worker::changeWorker(item)->setGender(value.toBool()); break;
        case BIRTHDATE:     Worker::changeWorker(item)->setBirthDate(value.toDate()); break;
        case EMPLOYMENTDATE:Worker::changeWorker(item)->setEmploymentDate(value.toDate()); break;
        case FIREDATE:      Worker::changeWorker(item)->setFireDate(value.toDate()); break;
        case SALARY:        Worker::changeWorker(item)->setSalary(value.toUInt()); break;
        case ADDITIONALINFO:Worker::changeWorker(item)->setAdditionalInfo(value.toString()); break;
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
    Roles[WORKERSTATUS] = "WORKERSTATUS";
    Roles[FIRSTNAME] = "FIRSTNAME";
    Roles[LASTNAME] = "LASTNAME";
    Roles[GENDER] = "GENDER";
    Roles[BIRTHDATE] = "BIRTHDATE";
    Roles[EMPLOYMENTDATE] = "EMPLOYMENTDATE";
    Roles[FIREDATE] = "FIREDATE";
    Roles[SALARY] = "SALARY";
    Roles[ADDITIONALINFO] = "ADDITIONALINFO";
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
//        connect(m_list,&DiaryList::preItemDeleted,this,[=](int index){
//            beginRemoveRows(QModelIndex(),index,index);
//        });
//        connect(m_list,&DiaryList::postItemDeleted,this,[=](){
//            endRemoveRows();
//        });
    }

    endResetModel();;
}
