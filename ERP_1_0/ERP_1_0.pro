QT       += core gui sql

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

CONFIG += c++17

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
    main.cpp \
    models/companymodel.cpp \
    models/managermodel.cpp \
    models/ordermodel.cpp \
    models/references_delivery_statetypemodel.cpp \
    models/references_order_billstatetypemodel.cpp \
    models/references_order_documentstatetype.cpp \
    models/sqlmodel.cpp \
    viewmodels/abstractviewmodel.cpp \
    viewmodels/addorderdialogviewmodel.cpp \
    viewmodels/companywidgetviewmodel.cpp \
    viewmodels/loginwindowviewmodel.cpp \
    viewmodels/mainwindowviewmodel.cpp \
    viewmodels/orderwidgetviewmodel.cpp \
    viewmodels/windowviewmodel.cpp \
    views/addorderdialogview.cpp \
    views/companywidgetview.cpp \
    views/loginwindowview.cpp \
    views/mainwindowview.cpp \
    views/orderwidgetview.cpp

HEADERS += \
    models/companymodel.h \
    models/managermodel.h \
    models/ordermodel.h \
    models/references_delivery_statetypemodel.h \
    models/references_order_billstatetypemodel.h \
    models/references_order_documentstatetype.h \
    models/sqlmodel.h \
    viewmodels/abstractviewmodel.h \
    viewmodels/addorderdialogviewmodel.h \
    viewmodels/companywidgetviewmodel.h \
    viewmodels/loginwindowviewmodel.h \
    viewmodels/mainwindowviewmodel.h \
    viewmodels/orderwidgetviewmodel.h \
    viewmodels/windowviewmodel.h \
    views/addorderdialogview.h \
    views/companywidgetview.h \
    views/loginwindowview.h \
    views/mainwindowview.h \
    views/orderwidgetview.h

FORMS += \
    ui/addorderdialog.ui \
    ui/companywidget.ui \
    ui/loginwindow.ui \
    ui/mainwindow.ui \
    ui/orderwidget.ui

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target
