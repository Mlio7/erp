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
            auto query = sql_model_->Request("SELECT CreatedOn,InvoiceNumber,ResponsibleUser,Company,"
                                        "DocumentState,SumNoVAT,SumVAT,"
                                        "BillState,DeliveryState FROM [ERP].[dbo].[vw_Order]");

            while (query->next()) {
                //  store data about an order
                Order order;
                order.timestamp     = query->value(0).toDateTime();
                order.InvoiceNumber = query->value(1).toString();
                order.manager       = query->value(2).toString();
                order.company       = query->value(3).toString();
                order.DocumentState = query->value(4).toString();
                order.SumNoVAT      = query->value(5).toDouble();
                order.SumVAT        = query->value(6).toDouble();
                order.BillState     = query->value(7).toString();
                order.DeliveryState = query->value(8).toString();


                // Push the order into the vector of orders
                orders.push_back(order);
            }

            return orders;
        }

        bool OrderModel::AddOrder(const Order& value) const noexcept {
            // Sanity checks
            if (!sql_model_) return false;
            if (!sql_model_->IsLoggedIn()) return false;

           // auto query = sql_model_->Request("INSERT INTO tbl_Order(Manager,CompanyName) "
           //                                  "VALUES(\'" + value.manager + "\',\'"
           //                                  + value.company + "\')");
            auto query = sql_model_->Request("INSERT INTO [dbo].[tbl_Order]"
           "([ID]"
           ",[CreatedOn]"
           ",[CreatedByID]"
           ",[ModifiedOn]"
           ",[ModifiedByID]"
           ",[InvoiceNumber]"
           ",[ResponsibleUserID]"
           ",[CompanyID]"
           ",[OrderDocumentStateTypeID]"
           ",[SumNoVAT] "
           ",[SumVAT] "
           ",[OrderBillStateTypeID]"
           ",[DeliveryStateTypeID])"
     "VALUES"
           "(default,"
           "default,"
           "default,"
           "default,"
           "default,"
           "\'" + value.InvoiceNumber + "\',"
           "(select [ID] from [dbo].[tbl_Users] where Name = \'"+value.manager+"\'),"
           "(select [ID] from [dbo].[tbl_Company] where [CompanyShortName] = \'"+value.company+"\'),"
           "(select [ID] from [dbo].[tbl_REFERENCES_ORDER_DocumentStateType] where [Name] = \'"+value.DocumentState+"\'),"
           "\' \',"
           "\' \',"
           "(select [ID] from [dbo].[tbl_REFERENCES_ORDER_BillStateType] where [Name] = \'"+value.BillState+"\'),"
           "(select [ID] from [dbo].[tbl_REFERENCES_DELIVERY_StateType] where [Name] = \'Відправлено\'))"
);

            OrderModel::GetOrders();

            if (query) emit OrdersUpdated();
            return (query) ? query->isValid() : false;

        }

    } // namespace models
} // namespace erp
