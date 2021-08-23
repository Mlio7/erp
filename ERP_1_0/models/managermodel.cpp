#include "managermodel.h"

namespace erp {
    namespace models {
        ManagerModel::ManagerModel(std::shared_ptr<SQLModel> sql_model) :
            sql_model_{sql_model} {

        }

        QVector<ManagerModel::Manager> ManagerModel::GetManagers() const noexcept {
            // Sanity checks
            if (!sql_model_) return {};
            if (!sql_model_->IsLoggedIn()) return {};

            QVector<Manager> managers;
            auto query = sql_model_->Request("SELECT Name FROM tbl_Users");
            while (query->next()) {
                // Fill manager info
                // TODO : store more data about a manager
                Manager manager;
                manager.name = query->value(0).toString();

                // Push the manager into the vector of managers
                managers.push_back(manager);
            }

            return managers;
        }
    } // namespace models
} // namespace erp
