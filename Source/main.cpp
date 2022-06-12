#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickView>
#include <QtWidgets>
#include "workerslistmodel.h"
#include "workerslist.h"
#include "sqlmanager.h"

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QApplication app(argc, argv);

    QCoreApplication::setOrganizationName("PP");
    QCoreApplication::setApplicationName("SADM");

    QQmlApplicationEngine engine;

    // Inits database
    SQLManager::initWorkersDatabase();


    // Detects type for creating in qml.
    qmlRegisterType<WorkersListModel>("Model",1,0,"WorkersModel");

    // Detects type for reading in qml.
    qmlRegisterUncreatableType<WorkersList>("Model",1,0,"WorkersList",
                                          QStringLiteral("This object should not be created in qml"));

    qmlRegisterUncreatableType<Worker>("WorkerClass",1,0,"Worker",
                                          QStringLiteral("This object should not be created in qml"));

    // Active workers list
    WorkersList activeWorkers(SQLManager::selectAllActiveWorkersIDs());
    // Fired workers list
    WorkersList firedWorkers(SQLManager::selectAllFiredWorkersIDs());

    // Detects activeWorkers variable for qml.
    engine.rootContext()->setContextProperty("activeWorkersList", &activeWorkers);
    // Detects firedWorkers variable for qml.
    engine.rootContext()->setContextProperty("firedWorkersList", &firedWorkers);

    const QUrl url(QStringLiteral("qrc:/qml/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}


