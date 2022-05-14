#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickView>
#include <customplotitem.h>
#include <QtWidgets>

//class WidgetWithPlot : public QWidget {
//    Q_OBJECT

//public:
//    explicit WidgetWithPlot(QObject* parent = nullptr) {}

//    void show() {

//        QWidget::show();
//    }

//};


int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);
    QApplication app2(argc, argv);

    QQmlApplicationEngine engine;


    //WidgetWithPlot plt;
    //    plt.resize(200, 200);
    //    plt.show();

//    QWidget* window = new QWidget();
//    window->resize(200, 200);
//    window->setWindowTitle("DADAYA");

    QCustomPlot* plot = new QCustomPlot();
    QVector<double> x(101), y(101); // initialize with entries 0..100
    for (int i=0; i<101; ++i)
    {
      x[i] = i/50.0 - 1; // x goes from -1 to 1
      y[i] = x[i]*x[i]; // let's plot a quadratic function
    }
    // create graph and assign data to it:
    plot->addGraph();
    plot->graph(0)->setData(x, y);
    // give the axes some labels:
    plot->xAxis->setLabel("x");
    plot->yAxis->setLabel("y");
    // set axes ranges, so we see all data:
    plot->xAxis->setRange(-1, 1);
    plot->yAxis->setRange(0, 1);
    plot->replot();
    plot->show();

    //    window.
    //    window.show();
    qmlRegisterType<CustomPlotItem>("CustomPlot", 1, 0, "CustomPlotItem");

    //    QQuickView *view = new QQuickView;
    //    view->setSource(QUrl::fromLocalFile("main.qml"));
    //    view->show();

    //    QQuickView view(QUrl("qrc:///qml/main.qml"));
    //    view.setResizeMode(QQuickView::SizeRootObjectToView);
    //    view.resize(500, 500);
    //    view.show();

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    app.exec();
    return app2.exec();
}


