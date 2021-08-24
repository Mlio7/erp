#ifndef REFERENCES_ORDER_BILLSTATETYPEMODEL_H
#define REFERENCES_ORDER_BILLSTATETYPEMODEL_H
#include "models/sqlmodel.h"




namespace erp {
    namespace models {
        /**
         * @brief The REFERENCES_ORDER_DocumentStateTypeModel class is used to retrieve data
         * about REFERENCES_ORDER_DocumentStateTypes from the database
         */
        class REFERENCES_ORDER_BillStateTypeModel {
        public:
            /**
             * @brief The DocumentStateType struct
             */
            // TODO : add more info
            struct BillStateType {
                QString name;


            };

        public:
            explicit REFERENCES_ORDER_BillStateTypeModel(std::shared_ptr<SQLModel> sql_model);

        public:
            QVector<BillStateType> GetBillStateTypes() const noexcept;

        private:
            std::shared_ptr<SQLModel> sql_model_;
        };
    } // namespace models
} // namespace erp
#endif // REFERENCES_ORDER_BILLSTATETYPEMODEL_H
