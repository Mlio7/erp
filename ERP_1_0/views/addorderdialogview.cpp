#include "addorderdialogview.h"

namespace erp {
    namespace views {
        AddOrderDialogView::AddOrderDialogView(QWidget* parent) :
            QWidget(parent),
            view_model_{std::make_shared<AddOrderDialogViewModel>()},
            ui_{std::make_unique<Ui::AddOrderDialog>()} {
            ui_->setupUi(this);
        }

        std::shared_ptr<AddOrderDialogView::AddOrderDialogViewModel>
        AddOrderDialogView::GetViewModel() const noexcept {
            return view_model_;
        }

        void AddOrderDialogView::SetManagers(QVector<ManagerModel::Manager> value) {
            // Sanity check
            if (value.isEmpty()) return;

            for (const auto& manager : value) {
                ui_->managerComboBox->addItem(manager.name);
            }
        }

        void AddOrderDialogView::SetCompanies(QVector<CompanyModel::Company> value) {
            // Sanity check
            if (value.isEmpty()) return;

            for (const auto& company : value) {
                ui_->companyComboBox->addItem(company.name);
            }
        }

        void AddOrderDialogView::on_addRecordButton_clicked() {
            OrderModel::Order order;
            order.company = ui_->companyComboBox->itemText(company_index_);
            order.manager = ui_->companyComboBox->itemText(manager_index_);

            if (!view_model_->AddOrder(order)) {
                return;
            }

            emit DatabaseUpdated();
        }

        void AddOrderDialogView::on_managerComboBox_currentIndexChanged(
                unsigned int value) {
            manager_index_ = value;
        }

        void AddOrderDialogView::on_companyComboBox_currentIndexChanged(
                unsigned int value) {
            company_index_ = value;
        }
    } // namespace views
} // namespace erp
