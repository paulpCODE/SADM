#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickView>
#include <QtWidgets>
#include "workerslistmodel.h"
#include "workerslist.h"

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QApplication app(argc, argv);

    QQmlApplicationEngine engine;

    qmlRegisterType<WorkersListModel>("Model",1,0,"WorkersModel");

    qmlRegisterUncreatableType<WorkersList>("Model",1,0,"WorkersList",
                                          QStringLiteral("This object should not be created in qml"));


    WorkersList w_list;

    engine.rootContext()->setContextProperty("workersList", &w_list);

    //    QCustomPlot* plot = new QCustomPlot();
    //    QVector<double> x(101), y(101); // initialize with entries 0..100
    //    for (int i=0; i<101; ++i)
    //    {
    //      x[i] = i/50.0 - 1; // x goes from -1 to 1
    //      y[i] = x[i]*x[i]; // let's plot a quadratic function
    //    }
    //    // create graph and assign data to it:
    //    plot->addGraph();
    //    plot->graph(0)->setData(x, y);
    //    // give the axes some labels:
    //    plot->xAxis->setLabel("x");
    //    plot->yAxis->setLabel("y");
    //    // set axes ranges, so we see all data:
    //    plot->xAxis->setRange(-1, 1);
    //    plot->yAxis->setRange(0, 1);
    //    plot->replot();
    //    plot->show();


    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}


