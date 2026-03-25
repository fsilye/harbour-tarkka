#ifdef QT_QML_DEBUG
#include <QtQuick>
#endif

#include <sailfishapp.h>
#include <QStandardPaths> // NUOVO: Per trovare le cartelle di sistema
#include <QQmlContext>    // NUOVO: Per comunicare con il QML

int main(int argc, char *argv[])
{
    // 1. Inizializziamo l'app e la vista "manualmente" (come suggerito dai commenti dell'SDK)
    QScopedPointer<QGuiApplication> app(SailfishApp::application(argc, argv));
    QScopedPointer<QQuickView> view(SailfishApp::createView());

    // 2. Chiediamo al sistema operativo dove si trova la cartella Immagini corretta
    QString picturesLocation = QStandardPaths::writableLocation(QStandardPaths::PicturesLocation);

    // 3. Creiamo la variabile "StandardPicturesPath" e la rendiamo visibile al QML
    view->rootContext()->setContextProperty("StandardPicturesPath", picturesLocation);

    // 4. Carichiamo il file QML principale e mostriamo la schermata
    view->setSource(SailfishApp::pathToMainQml());
    view->show();

    // 5. Avviamo il "motore" dell'applicazione
    return app->exec();
}
