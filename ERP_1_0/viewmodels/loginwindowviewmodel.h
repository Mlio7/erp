#ifndef ERP_VIEWMODELS_LOGINWINDOWVIEWMODEL_H
#define ERP_VIEWMODELS_LOGINWINDOWVIEWMODEL_H

#include <QObject>

#include "viewmodels/windowviewmodel.h"

#include "models/sqlmodel.h"

namespace erp {
    namespace viewmodels {
        /**
         * @brief The LoginWindowViewModel class
         */
        class LoginWindowViewModel : public WindowViewModel {

            using SQLModel = erp::models::SQLModel;

            Q_OBJECT

        public:
            using LoginData = SQLModel::LoginData;

        public:
            LoginWindowViewModel();

        public:
            void Login(const LoginData& value) const noexcept;
            bool IsLoggedIn() const noexcept;

        public slots:
            void OnLoginStateChanged(bool value);

        protected:
            virtual void ConnectSQLModel(std::shared_ptr<SQLModel> view) noexcept override;
            virtual void DisconnectSQLModel(std::shared_ptr<SQLModel> view) noexcept override;
        };
    } // namespace viewodels
} // namespace erp

#endif // ERP_VIEWMODELS_LOGINWINDOWVIEWMODEL_H
