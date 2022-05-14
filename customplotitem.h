#ifndef CUSTOMPLOTITEM_H
#define CUSTOMPLOTITEM_H

#include <QtQuick>
#include <QtQuickWidgets/QQuickWidget>
#include <qcustomplot/qcustomplot.h>

//class QCustomPlot;

class CustomPlotItem : public QQuickPaintedItem
{
    Q_OBJECT

public:
    CustomPlotItem( QQuickItem* parent = 0 );
    virtual ~CustomPlotItem();

    void paint( QPainter* painter );

    Q_INVOKABLE void initCustomPlot();

protected:
    void routeMouseEvents( QMouseEvent* event );

    virtual void mousePressEvent( QMouseEvent* event );
    virtual void mouseReleaseEvent( QMouseEvent* event );
    virtual void mouseMoveEvent( QMouseEvent* event );
    virtual void mouseDoubleClickEvent( QMouseEvent* event );

    void setupQuadraticDemo( QCustomPlot* customPlot );

private:
    QCustomPlot*         m_CustomPlot;

private slots:
    void graphClicked( QCPAbstractPlottable* plottable );
    void onCustomReplot();
    void updateCustomPlotSize();

};

#endif // CUSTOMPLOTITEM_H
