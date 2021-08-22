#include "mainwindowviewmodel.h"

namespace erp {
    namespace viewmodels {
        MainWindowViewModel::MainWindowViewModel() {
            // Create an SQL model
            SetSQLModel(std::make_shared<SQLModel>());

            // Set the default visibility
            SetVisibility(false);
        }

        void MainWindowViewModel::OnLoginStateChanged(bool value) {
            if (!GetVisibility() || !value) {
                // TODO : create a dialog with info that the login is expired
            }

            SetVisibility(value);
        }

        void MainWindowViewModel::ConnectSQLModel(
                std::shared_ptr<SQLModel> view) noexcept {
            connect(view.get(),
                    &SQLModel::LoginStateChanged,
                    this,
                    &MainWindowViewModel::OnLoginStateChanged);
        }

        void MainWindowViewModel::DisconnectSQLModel(
                std::shared_ptr<SQLModel> view) noexcept {
            // Disconnect previous model
            disconnect(view.get(),
                    &SQLModel::LoginStateChanged,
                    this,
                    &MainWindowViewModel::OnLoginStateChanged);
        }
    } // namespace viewodels
} // namespace erp
