#include "references_delivery_statetypemodel.h"

namespace erp {
    namespace models {


    erp::models::REFERENCES_DELIVERY_StateTypeModel::REFERENCES_DELIVERY_StateTypeModel(std::shared_ptr<SQLModel> sql_model)
        :sql_model_{sql_model} {}

    QVector<REFERENCES_DELIVERY_StateTypeModel::DELIVERY_StateType> REFERENCES_DELIVERY_StateTypeModel::GetDeliveryStateTypes() const noexcept
        {
            // Sanity checks
            if (!sql_model_) return {};
            if (!sql_model_->IsLoggedIn()) return {};
            QVector<DELIVERY_StateType> delivery_StateTypes;
            auto query = sql_model_->Request("SELECT Name FROM tbl_REFERENCES_ORDER_DocumentStateType");
            while (query->next())
            {
                // TODO : store more data about a documentStateTypes
                DELIVERY_StateType delivery_StateType;
                delivery_StateType.name = query->value(0).toString();

                // Push the documentStateType into the vector of documentStateTypes
                delivery_StateTypes.push_back(delivery_StateType);
            }
            return delivery_StateTypes;
        }


    } // namespace models
} // namespace erp
