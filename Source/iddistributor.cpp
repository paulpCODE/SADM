#include "iddistributor.h"
#include "sqlmanager.h"

IDDistributor* IDDistributor::m_Instance = nullptr;

IDDistributor::IDDistributor() : nextID(0), freeIDs()
{
    auto activeIds = SQLManager::selectAllActiveWorkersIDs();
    auto firedIds = SQLManager::selectAllFiredWorkersIDs();

    QSet<unsigned int> busyIds;

    activeIds.exec();

    int maxID = -1;
    int id = - 1;
    while(activeIds.next()) {
        id = activeIds.value(0).toInt();
        busyIds.insert(static_cast<unsigned int>(id));
        if(maxID < id) {
            maxID = id;
        }
    }

    firedIds.exec();

    while(firedIds.next()) {
        id = firedIds.value(0).toInt();
        busyIds.insert(static_cast<unsigned int>(id));
        if(maxID < id) {
            maxID = id;
        }
    }

    nextID = maxID + 1;

    for(int i = 0; i < nextID; i++) {
        freeIDs.insert(i);
    }

    if(freeIDs.size() != 0) {
        freeIDs.subtract(busyIds);
    }
}

IDDistributor::~IDDistributor()
{}

unsigned int IDDistributor::getID()
{
    if(!m_Instance) {
        m_Instance = new IDDistributor();
    }

    if(m_Instance->freeIDs.size() != 0) {
        unsigned int id = *(m_Instance->freeIDs.begin());
        m_Instance->freeIDs.remove(id);
        qDebug() << "ID: " << id;
        return id;
    }

    qDebug() << "MAX ID: " << m_Instance->nextID;
    return m_Instance->nextID++;
}

void IDDistributor::freeID(unsigned int id)
{

    qDebug() << "FREE ID: " << id;

    if(!m_Instance) {
        m_Instance = new IDDistributor();
    }

    if(id >= m_Instance->nextID) {
        qDebug() << "ID dont exist in IDDistributor::freeID!";
        return;
    }

    if(id == m_Instance->nextID - 1) {
        m_Instance->nextID--;
        return;
    }

    m_Instance->freeIDs.insert(id);
}
