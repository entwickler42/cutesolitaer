#include <ccqmlapplication.h>


Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QScopedPointer<CCQmlApplication> app(new CCQmlApplication(argc, argv));

    app->viewer()->setOrientation(QtQuick1ApplicationViewer::ScreenOrientationAuto);
    app->viewer()->setSource(QUrl("qrc:/qml/cutesolitaer/CS.qml"));

#if defined(Q_OS_SYMBIAN) || defined(Q_OS_ANDROID)
    app->viewer()->showFullScreen();
#else
    app->viewer()->setGeometry(0,0, 600, 600);
    app->viewer()->showExpanded();
#endif

    return app->exec();
}
