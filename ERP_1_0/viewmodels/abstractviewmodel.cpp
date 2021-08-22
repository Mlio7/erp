#include "abstractviewmodel.h"

namespace erp {
    namespace viewmodels {
        AbstractViewModel::AbstractViewModel() :
            QObject() {

        }

        std::shared_ptr<AbstractViewModel::SQLModel>
        AbstractViewModel::GetSQLModel() const noexcept {
            return sql_model_;
        }

        void AbstractViewModel::SetSQLModel(std::shared_ptr<SQLModel> value) {
            if (value) {
                // Connect the new model
                DisconnectSQLModel(sql_model_);
                ConnectSQLModel(value);

                // Change the SQL model
                sql_model_ = value;
                emit SQLModelChanged();
            }
        }
    } // namespace viewodels
} // namespace erp
