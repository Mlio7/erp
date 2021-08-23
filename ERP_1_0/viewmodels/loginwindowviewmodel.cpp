#include "loginwindowviewmodel.h"

namespace erp {
    namespace viewmodels {
        LoginWindowViewModel::LoginWindowViewModel() :
            WindowViewModel() {
            // Set the default visibility
            SetVisibility(true);
        }

        void LoginWindowViewModel::ConnectSQLModel(
                std::shared_ptr<SQLModel> model) noexcept {
            // Sanity check
            if (!model) return;

            connect(model.get(),
                    &SQLModel::LoginStateChanged,
                    this,
                    &LoginWindowViewModel::OnLoginStateChanged);
        }

        void LoginWindowViewModel::DisconnectSQLModel(
                std::shared_ptr<SQLModel> model) noexcept {
            // Sanity check
            if (!model) return;

            // Disconnect previous model
            disconnect(model.get(),
                    &SQLModel::LoginStateChanged,
                    this,
                    &LoginWindowViewModel::OnLoginStateChanged);
        }

        void LoginWindowViewModel::OnLoginStateChanged(bool value) {
            SetVisibility(!value);
        }

        void LoginWindowViewModel::Login(const LoginData& model) const noexcept {
            // Sanity check
            auto sql_model = GetSQLModel();
            if (!sql_model) return;

            // Login to the database
            sql_model->Login(model);
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
