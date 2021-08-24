#ifndef REFERENCES_ORDER_DOCUMENTSTATETYPE_H
#define REFERENCES_ORDER_DOCUMENTSTATETYPE_H

#include "models/sqlmodel.h"

namespace erp {
    namespace models {
        /**
         * @brief The REFERENCES_ORDER_DocumentStateTypeModel class is used to retrieve data
         * about REFERENCES_ORDER_DocumentStateTypes from the database
         */
        class REFERENCES_ORDER_DocumentStateTypeModel {
        public:
            /**
             * @brief The DocumentStateType struct
             */
            // TODO : add more info
            struct DocumentStateType {
                QString name;


            };

        public:
            explicit REFERENCES_ORDER_DocumentStateTypeModel(std::shared_ptr<SQLModel> sql_model);

        public:
            QVector<DocumentStateType> GetDocumentStateTypes() const noexcept;

        private:
            std::shared_ptr<SQLModel> sql_model_;
        };
    } // namespace models
} // namespace erp

#endif // ERP_MODELS_REFERENCES_ORDER_DocumentStateTypeMODEL_H
