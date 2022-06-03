#ifndef IDDISTRIBUTOR_H
#define IDDISTRIBUTOR_H

#include <QVector>

class IDDistributor
{
private:
    IDDistributor();

    IDDistributor(const IDDistributor&) = delete;
    IDDistributor operator = (const IDDistributor&) = delete;
    IDDistributor(IDDistributor&&) = delete;


    static IDDistributor * m_Instance;

    QVector<unsigned int> freeIDs;
    unsigned int nextID;
public:

    ~IDDistributor();

    // get free id from distributor
    static unsigned int getID();
    // free id to get.
    static void freeID(unsigned int id);
};

#endif // IDDISTRIBUTOR_H
