#include "addorderdialogviewmodel.h"

namespace erp {
    namespace viewmodels {
        AddOrderDialogViewModel::AddOrderDialogViewModel() :
            WindowViewModel() {

        }

        QVector<AddOrderDialogViewModel::OrderModel::Order>
        AddOrderDialogViewModel::GetOrders() const noexcept {
            return order_model_->GetOrders();
        }

        bool AddOrderDialogViewModel::AddOrder(
                const OrderModel::Order& value) const noexcept {
            return order_model_->AddOrder(value);
        }

        QVector<AddOrderDialogViewModel::CompanyModel::Company>
        AddOrderDialogViewModel::GetCompanies() const noexcept {
            return company_model_->getCompanies();
        }

        QVector<AddOrderDialogViewModel::ManagerModel::Manager>
        AddOrderDialogViewModel::GetManagers() const noexcept {
            return manager_model_->GetManagers();
        }

        /*
        std::shared_ptr<AddOrderDialogViewModel::OrderModel>
        AddOrderDialogViewModel::GetOrderModel() const noexcept() {

        }
        */

        void AddOrderDialogViewModel::SetSQLModel(std::shared_ptr<SQLModel> model) {
            // Sanity check
            if (!model) return;

            order_model_ = std::make_shared<OrderModel>(model);
            company_model_ = std::make_shared<CompanyModel>(model);
            manager_model_ =std::make_shared<ManagerModel>(model);

            // Call the method from the superclass
            WindowViewModel::SetSQLModel(model);
        }

        void AddOrderDialogViewModel::ConnectSQLModel(
                std::shared_ptr<SQLModel> view) noexcept {
            Q_UNUSED(view)
        }

        void AddOrderDialogViewModel::DisconnectSQLModel(
                std::shared_ptr<SQLModel> view) noexcept {
            Q_UNUSED(view)
        }
    } // namespace viewmodels
} // namespace erp
