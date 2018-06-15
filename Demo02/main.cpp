#include <QGuiApplication>
#include <QtWidgets/QApplication>
#include <QQmlApplicationEngine>
#include <QtQuick/QQuickView>
#include <QtQml>
#include <QFontDatabase>
#include "getsysinfo.h"


int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QApplication app(argc, argv);

    //SysInfo
//       GetSysInfo *sss = new GetSysInfo;
    //

    //载入字体文件
    QFontDatabase::addApplicationFont(":/Fonts/themify.ttf");
    QFontDatabase::addApplicationFont(":/Fonts/PhantasmAllCaps.ttf");
    QFontDatabase::addApplicationFont(":/Fonts/DISPLAY_FREE_TFB.ttf");
    QFontDatabase::addApplicationFont(":/Fonts/幼圆.ttf");

    QDir::setCurrent(app.applicationDirPath());


    QQuickView viewer;

    QObject::connect(viewer.engine(), &QQmlEngine::quit, &viewer, &QWindow::close);

//    viewer.setTitle(QStringLiteral("Flat Dark"));
    viewer.rootContext()->setContextProperty("GetSysInfo", new GetSysInfo);
    viewer.setSource(QUrl("qrc:/main.qml"));    //将源代码设置额为url，装入QML组件并实例化它
    viewer.setResizeMode(QQuickView::SizeRootObjectToView);
    viewer.setColor(QColor("#00000000"));


    viewer.setFlags(Qt::Window | Qt::FramelessWindowHint);

//    将viewer注册为mainWindow对象
    viewer.rootContext()->setContextProperty("rootWindow",&viewer);

//    DataManage dataManage;
//    viewer.rootContext()->setContextProperty("dataManage", &dataManage);

    viewer.show();

    return app.exec();
}
