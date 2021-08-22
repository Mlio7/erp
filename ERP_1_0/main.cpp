#include <QApplication>

#include "views/mainwindowview.h"

int main(int argc, char *argv[])
{
    QApplication application(argc, argv);
    erp::views::MainWindowView window;

    return application.exec();
}
