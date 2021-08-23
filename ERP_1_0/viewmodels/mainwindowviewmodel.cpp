#include "mainwindowviewmodel.h"

namespace erp {
    namespace viewmodels {
        MainWindowViewModel::MainWindowViewModel() {
            // Create an SQL model
            SetSQLModel(std::make_shared<SQLModel>());

            // Set the default visibility  Вимикаємо головне вікно
            SetVisibility(false);
        }

        void MainWindowViewModel::OnLoginStateChanged(bool value) {
            if (!GetVisibility() || !value) {
                // TODO : create a dialog with info that the login is expired
            }
            // Встановлюємо видемість головного вікна
            SetVisibility(value);
        }

        void MainWindowViewModel::ConnectSQLModel(
                std::shared_ptr<SQLModel> model) noexcept {
            // Sanity check
            if (!model) return;

            connect(model.get(),
                    &SQLModel::LoginStateChanged,
                    this,
                    &MainWindowViewModel::OnLoginStateChanged);
        }

        void MainWindowViewModel::DisconnectSQLModel(
                std::shared_ptr<SQLModel> model) noexcept {
            // Sanity check
            if (!model) return;

            // Disconnect previous model
            disconnect(model.get(),
                    &SQLModel::LoginStateChanged,
                    this,
                    &MainWindowViewModel::OnLoginStateChanged);
        }
    } // namespace viewodels
} // namespace erp
