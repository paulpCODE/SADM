#include "iddistributor.h"
#include <QSettings>

IDDistributor* IDDistributor::m_Instance = nullptr;

IDDistributor::IDDistributor() : nextID(0), freeIDs()
{
    QSettings settings;

    nextID = settings.value("NextID").toUInt();

    const int size = settings.beginReadArray("FreeIDs");

    for(int i = 0; i < size; i++) {
        settings.setArrayIndex(i);

        freeIDs.push_back(settings.value("FreeID").toUInt());
    }
    settings.endArray();

}

IDDistributor::~IDDistributor()
{
    QSettings settings;

    settings.setValue("NextID", nextID);

    settings.beginWriteArray("IDs");

    for(int i = 0; i < freeIDs.size(); i++) {
        settings.setArrayIndex(i);

        settings.setValue("FreeID", freeIDs[i - 1]);
    }
    settings.endArray();
}

unsigned int IDDistributor::getID()
{
    if(!m_Instance) {
        m_Instance = new IDDistributor();
    }

    if(m_Instance->freeIDs.size() != 0) {
        auto id = m_Instance->freeIDs.front();
        m_Instance->freeIDs.removeFirst();
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

    m_Instance->freeIDs.push_back(id);
}
