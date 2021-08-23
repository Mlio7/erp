#ifndef ERP_VIEWMODELS_ADDORDERWIDGETVIEWMODEL_H
#define ERP_VIEWMODELS_ADDORDERWIDGETVIEWMODEL_H

#include "viewmodels/windowviewmodel.h"

#include "models/ordermodel.h"
#include "models/companymodel.h"
#include "models/managermodel.h"
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

            Q_OBJECT

        public:
            AddOrderDialogViewModel();

        public:
            void SetSQLModel(std::shared_ptr<SQLModel> value);

            QVector<OrderModel::Order> GetOrders() const noexcept;
            bool AddOrder(const OrderModel::Order& value) const noexcept;

            QVector<CompanyModel::Company> GetCompanies() const noexcept;

            QVector<ManagerModel::Manager> GetManagers() const noexcept;

            //std::shared_ptr<OrderModel> GetOrderModel() const noexcept;

        protected:
            void ConnectSQLModel(std::shared_ptr<SQLModel> model) noexcept override;
            void DisconnectSQLModel(std::shared_ptr<SQLModel> model) noexcept override;

        private:
            std::shared_ptr<OrderModel> order_model_;
            std::shared_ptr<CompanyModel> company_model_;
            std::shared_ptr<ManagerModel> manager_model_;
        };
    } // namespace viewmodels
} // namespace erp

#endif // ERP_VIEWMODELS_ADDORDERWIDGETVIEWMODEL_H
