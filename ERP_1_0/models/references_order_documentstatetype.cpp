#include "references_order_documentstatetype.h"



namespace erp {
    namespace models {


    erp::models::REFERENCES_ORDER_DocumentStateTypeModel::REFERENCES_ORDER_DocumentStateTypeModel(std::shared_ptr<SQLModel> sql_model)
        :sql_model_{sql_model} {}

    QVector<REFERENCES_ORDER_DocumentStateTypeModel::DocumentStateType> REFERENCES_ORDER_DocumentStateTypeModel::GetDocumentStateTypes() const noexcept
        {
            // Sanity checks
            if (!sql_model_) return {};
            if (!sql_model_->IsLoggedIn()) return {};
            QVector<DocumentStateType> documentStateTypes;
            auto query = sql_model_->Request("SELECT Name FROM tbl_REFERENCES_DELIVERY_StateType");
            while (query->next())
            {
                // TODO : store more data about a documentStateTypes
                DocumentStateType documentStateType;
                documentStateType.name = query->value(0).toString();

                // Push the documentStateType into the vector of documentStateTypes
                documentStateTypes.push_back(documentStateType);
            }
            return documentStateTypes;
        }


    } // namespace models
} // namespace erp
