#ifndef ERP_MODELS_ORDERMODEL_H
#define ERP_MODELS_ORDERMODEL_H

#include "models/sqlmodel.h"

namespace erp {
    namespace models {
        /**
         * @brief The OrderModel class is used to retrieve data
         * about curent orders from the database
         */
        class OrderModel {
        public:
            /**
             * @brief The Order struct
             */
            // TODO : add more info
            struct Order {
                QString company;
                QString manager;
                QDateTime timestamp;
            };

        public:
            explicit OrderModel(std::shared_ptr<SQLModel> sql_model);

        public:
            QVector<Order> GetOrders() const noexcept;
            bool AddOrder(const Order& value) const noexcept;

        private:
            std::shared_ptr<SQLModel> sql_model_;
        };
    } // namespace models
} // namespace erp

#endif // ERP_MODELS_ORDERMODEL_H
