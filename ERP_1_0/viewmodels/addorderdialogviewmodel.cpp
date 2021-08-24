#include "addorderdialogviewmodel.h"

namespace erp {
    namespace viewmodels {
        AddOrderDialogViewModel::AddOrderDialogViewModel() :
            WindowViewModel() {

        }
        //Запит для виводу замовлень
        QVector<AddOrderDialogViewModel::OrderModel::Order>
        AddOrderDialogViewModel::GetOrders() const noexcept {
            return order_model_->GetOrders();
        }


       bool AddOrderDialogViewModel::AddOrder(
                const OrderModel::Order& value) const noexcept {
            return order_model_->AddOrder(value);
        }
        //Запит для виводу  контрагентів
        QVector<AddOrderDialogViewModel::CompanyModel::Company>
        AddOrderDialogViewModel::GetCompanies() const noexcept {
            return company_model_->getCompanies();
        }

        QVector<AddOrderDialogViewModel::CompanyModel::Company>
        AddOrderDialogViewModel::GetManagerCompanies(const QString& manager) const noexcept {
            return company_model_->getManagerCompanies(manager);
        }

        //Запит для виводу  відповідального менеджера
        QVector<AddOrderDialogViewModel::ManagerModel::Manager>
        AddOrderDialogViewModel::GetManagers() const noexcept {
            return manager_model_->GetManagers();
        }
        //Запит для виводу  стану рахунків
        QVector<AddOrderDialogViewModel::REFERENCES_ORDER_DocumentStateTypeModel::DocumentStateType>
        AddOrderDialogViewModel::GetDocumentStateTypes() const noexcept {
            return documentstatetypemodel_model_->GetDocumentStateTypes();
        }
        //Запит для виводу  стану оплати
        QVector<AddOrderDialogViewModel::REFERENCES_ORDER_BillStateTypeModel::BillStateType>
        AddOrderDialogViewModel::GetBillStateTypes() const noexcept {
            return billstatetypemodel_model_->GetBillStateTypes();
        }
        //Запит для виводу стану доставки
        QVector<AddOrderDialogViewModel::REFERENCES_DELIVERY_StateTypeModel::DELIVERY_StateType>
        AddOrderDialogViewModel::GetDeliveryStateTypes() const noexcept {
            return deliverystatetypemodel_model_->GetDeliveryStateTypes();
        }

        std::shared_ptr<AddOrderDialogViewModel::OrderModel>
        AddOrderDialogViewModel::GetOrderModel() const noexcept {
            return order_model_;
        }

        void AddOrderDialogViewModel::SetSQLModel(std::shared_ptr<SQLModel> model) {
            // Sanity check
            if (!model) return;

            order_model_                  = std::make_shared<OrderModel>(model);
            company_model_                = std::make_shared<CompanyModel>(model);
            manager_model_                = std::make_shared<ManagerModel>(model);
            documentstatetypemodel_model_ = std::make_shared<REFERENCES_ORDER_DocumentStateTypeModel>(model);
            billstatetypemodel_model_     = std::make_shared<REFERENCES_ORDER_BillStateTypeModel>(model);
            deliverystatetypemodel_model_ = std::make_shared<REFERENCES_DELIVERY_StateTypeModel>(model);

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
