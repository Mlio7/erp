#ifndef ERP_VIEWMODELS_ADDORDERWIDGETVIEWMODEL_H
#define ERP_VIEWMODELS_ADDORDERWIDGETVIEWMODEL_H

#include "viewmodels/windowviewmodel.h"

#include "models/ordermodel.h"
#include "models/companymodel.h"
#include "models/managermodel.h"
#include "models/references_order_documentstatetype.h"
#include "models/references_order_billstatetypemodel.h"
#include "models/references_delivery_statetypemodel.h"
#include "models/sqlmodel.h"

namespace erp {
    namespace viewmodels {
        /**
         * @brief The AddOrderDialogViewModel class
         */
        class AddOrderDialogViewModel : public WindowViewModel {

            using OrderModel = erp::models::OrderModel;
            using CompanyModel = erp::models::CompanyModel;
            using ManagerModel = erp::models::ManagerModel;
            using SQLModel = erp::models::SQLModel;
            using REFERENCES_ORDER_DocumentStateTypeModel = erp::models::REFERENCES_ORDER_DocumentStateTypeModel;
            using REFERENCES_ORDER_BillStateTypeModel = erp::models::REFERENCES_ORDER_BillStateTypeModel;
            using REFERENCES_DELIVERY_StateTypeModel = erp::models::REFERENCES_DELIVERY_StateTypeModel;
            Q_OBJECT

        public:
            AddOrderDialogViewModel();

        public:
            void SetSQLModel(std::shared_ptr<SQLModel> value);

            QVector<OrderModel::Order>                                          GetOrders() const noexcept;
            QVector<OrderModel::Order>                                          GetOrderNo() const noexcept;
            QVector<CompanyModel::Company>                                      GetCompanies() const noexcept;
            QVector<CompanyModel::Company>                                      GetManagerCompanies(const QString& manager) const noexcept;
            QVector<ManagerModel::Manager>                                      GetManagers() const noexcept;
            QVector<REFERENCES_ORDER_DocumentStateTypeModel::DocumentStateType> GetDocumentStateTypes() const noexcept;
            QVector<REFERENCES_ORDER_BillStateTypeModel::BillStateType>         GetBillStateTypes() const noexcept;
            QVector<REFERENCES_DELIVERY_StateTypeModel::DELIVERY_StateType>     GetDeliveryStateTypes() const noexcept;
            std::shared_ptr<OrderModel> GetOrderModel() const noexcept;
            bool AddOrder(const OrderModel::Order& value) const noexcept;
        protected:
            void ConnectSQLModel(std::shared_ptr<SQLModel> model) noexcept override;
            void DisconnectSQLModel(std::shared_ptr<SQLModel> model) noexcept override;

        private:
            //Індекси вибору
            std::shared_ptr<OrderModel>                              order_model_;
            std::shared_ptr<CompanyModel>                            company_model_;
            std::shared_ptr<ManagerModel>                            manager_model_;
            std::shared_ptr<REFERENCES_ORDER_DocumentStateTypeModel> documentstatetypemodel_model_;
            std::shared_ptr<REFERENCES_ORDER_BillStateTypeModel>     billstatetypemodel_model_;
            std::shared_ptr<REFERENCES_DELIVERY_StateTypeModel>      deliverystatetypemodel_model_;
        };
    } // namespace viewmodels
} // namespace erp

#endif // ERP_VIEWMODELS_ADDORDERWIDGETVIEWMODEL_H
