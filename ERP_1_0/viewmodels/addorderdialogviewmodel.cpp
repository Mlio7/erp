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
        AddOrderDialogViewModel::getCompanies() const noexcept {
            return company_model_->getCompanies();
        }

        QVector<AddOrderDialogViewModel::ManagerModel::Manager>
        AddOrderDialogViewModel::getManagers() const noexcept {
            return manager_model_->getManagers();
        }

        void AddOrderDialogViewModel::SetSQLModel(std::shared_ptr<SQLModel> value) {
            // Sanity check
            if (!value) return;

            order_model_ = std::make_shared<OrderModel>(value);
            company_model_ = std::make_shared<CompanyModel>(value);
            manager_model_ =std::make_shared<ManagerModel>(value);

            // Call the method from the superclass
            WindowViewModel::SetSQLModel(value);
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
