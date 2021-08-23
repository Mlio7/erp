#include "ordermodel.h"

namespace erp {
    namespace models {
        OrderModel::OrderModel(std::shared_ptr<SQLModel> sql_model) :
            QObject(),
            sql_model_{sql_model} {

        }

        QVector<OrderModel::Order> OrderModel::GetOrders() const noexcept {
            // Sanity checks
            if (!sql_model_) return {};
            if (!sql_model_->IsLoggedIn()) return {};

            QVector<Order> orders;
            auto query = sql_model_->Request("SELECT CompanyName,Manager,CreatedOn FROM [ERP].[dbo].[tbl_Order]");
            while (query->next()) {
                // Fill order info
                // TODO : store more data about an order
                Order order;
                order.company = query->value(2).toString();
                order.manager = query->value(1).toString();
                order.timestamp = query->value(0).toDateTime();
                // Push the order into the vector of orders
                orders.push_back(order);
            }

            return orders;
        }

        bool OrderModel::AddOrder(const Order& value) const noexcept {
            // Sanity checks
            if (!sql_model_) return false;
            if (!sql_model_->IsLoggedIn()) return false;

            auto query = sql_model_->Request("INSERT INTO tbl_Order(Manager,CompanyName) "
                                             "VALUES(\'" + value.manager + "\',\'"
                                             + value.company + "\')");

            //if (query) emit DatabaseUpdated();
            return (query) ? query->isValid() : false;
        }

    } // namespace models
} // namespace erp
