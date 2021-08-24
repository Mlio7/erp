#include "references_order_billstatetypemodel.h"


namespace erp {
    namespace models {


    erp::models::REFERENCES_ORDER_BillStateTypeModel::REFERENCES_ORDER_BillStateTypeModel(std::shared_ptr<SQLModel> sql_model)
        :sql_model_{sql_model} {}

    QVector<REFERENCES_ORDER_BillStateTypeModel::BillStateType> REFERENCES_ORDER_BillStateTypeModel::GetBillStateTypes() const noexcept
        {
            // Sanity checks
            if (!sql_model_) return {};
            if (!sql_model_->IsLoggedIn()) return {};
            QVector<BillStateType> billStateTypes;
            auto query = sql_model_->Request("SELECT Name FROM tbl_REFERENCES_ORDER_BillStateType");
            while (query->next())
            {
                // TODO : store more data about a documentStateTypes
                BillStateType billStateType;
                billStateType.name = query->value(0).toString();

                // Push the documentStateType into the vector of documentStateTypes
                billStateTypes.push_back(billStateType);
            }
            return billStateTypes;
        }


    } // namespace models
} // namespace erp
