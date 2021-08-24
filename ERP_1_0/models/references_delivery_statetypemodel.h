#ifndef REFERENCES_DELIVERY_STATETYPEMODEL_H
#define REFERENCES_DELIVERY_STATETYPEMODEL_H




#include "models/sqlmodel.h"

namespace erp {
    namespace models {
        /**
         * @brief The REFERENCES_ORDER_DocumentStateTypeModel class is used to retrieve data
         * about REFERENCES_ORDER_DocumentStateTypes from the database
         */
        class REFERENCES_DELIVERY_StateTypeModel {
        public:
            /**
             * @brief The DocumentStateType struct
             */
            // TODO : add more info
            struct DELIVERY_StateType {
                QString name;


            };

        public:
            explicit REFERENCES_DELIVERY_StateTypeModel(std::shared_ptr<SQLModel> sql_model);

        public:
            QVector<DELIVERY_StateType> GetDeliveryStateTypes() const noexcept;

        private:
            std::shared_ptr<SQLModel> sql_model_;
        };
    } // namespace models
} // namespace erp


#endif // REFERENCES_DELIVERY_STATETYPEMODEL_H
