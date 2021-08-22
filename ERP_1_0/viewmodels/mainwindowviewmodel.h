#ifndef ERP_VIEWMODELS_MAINWINDOWVIEWMODEL_H
#define ERP_VIEWMODELS_MAINWINDOWVIEWMODEL_H

#include <QObject>

#include "viewmodels/windowviewmodel.h"

#include "models/sqlmodel.h"

namespace erp {
    namespace viewmodels {
        /**
         * @brief The MainWindowViewModel class
         */
        class MainWindowViewModel : public WindowViewModel {

            using SQLModel = erp::models::SQLModel;

            Q_OBJECT

        public:
            MainWindowViewModel();

        public slots:
            void OnLoginStateChanged(bool value);

        protected:
            virtual void ConnectSQLModel(std::shared_ptr<SQLModel> view) noexcept override;
            virtual void DisconnectSQLModel(std::shared_ptr<SQLModel> view) noexcept override;
        };
    } // namespace viewodels
} // namespace erp

#endif // ERP_VIEWMODELS_MAINWINDOWVIEWMODEL_H
