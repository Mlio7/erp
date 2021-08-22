#include "loginwindowviewmodel.h"

namespace erp {
    namespace viewmodels {
        LoginWindowViewModel::LoginWindowViewModel() :
            WindowViewModel() {
            // Set the default visibility
            SetVisibility(true);
        }

        void LoginWindowViewModel::ConnectSQLModel(
                std::shared_ptr<SQLModel> view) noexcept {
            connect(view.get(),
                    &SQLModel::LoginStateChanged,
                    this,
                    &LoginWindowViewModel::OnLoginStateChanged);
        }

        void LoginWindowViewModel::DisconnectSQLModel(
                std::shared_ptr<SQLModel> view) noexcept {
            // Disconnect previous model
            disconnect(view.get(),
                    &SQLModel::LoginStateChanged,
                    this,
                    &LoginWindowViewModel::OnLoginStateChanged);
        }

        void LoginWindowViewModel::OnLoginStateChanged(bool value) {
            SetVisibility(!value);
        }

        void LoginWindowViewModel::Login(const LoginData& value) const noexcept {
            // Sanity check
            auto sql_model = GetSQLModel();
            if (!sql_model) return;

            // Login to the database
            sql_model->Login(value);
        }

        bool LoginWindowViewModel::IsLoggedIn() const noexcept {
            // Sanity check
            auto sql_model = GetSQLModel();
            if (!sql_model) return false;

            // Check if the user has logged in
            return sql_model->IsLoggedIn();
        }
    } // namespace viewodels
} // namespace erp
