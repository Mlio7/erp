#include "addorderdialogview.h"

namespace erp {
    namespace views {
        AddOrderDialogView::AddOrderDialogView(QWidget* parent) :
            QWidget(parent),
            view_model_{std::make_shared<AddOrderDialogViewModel>()},
            ui_{std::make_unique<Ui::AddOrderDialog>()} {
            ui_->setupUi(this);

            // Connect the view components
            connect(ui_->managerComboBox,
                    &QComboBox::currentIndexChanged,
                    this,
                    &AddOrderDialogView::OnManagerIndexChanged);

            connect(ui_->companyComboBox,
                    &QComboBox::currentIndexChanged,
                    this,
                    &AddOrderDialogView::OnCompanyIndexChanged);

            connect(ui_->DocumentStateComboBox,
                    &QComboBox::currentIndexChanged,
                    this,
                    &AddOrderDialogView::OnDocumentStateIndexChanged);
            connect(ui_->BillStateComboBox,
                    &QComboBox::currentIndexChanged,
                    this,
                    &AddOrderDialogView::OnBillStateIndexChanged);
            //connect(ui_->DocumentStateComboBox,
            //        &QComboBox::currentIndexChanged,
            //         this,
            //        &AddOrderDialogView::OnDocumentStateIndexChanged);
            // Connect the viewmodel
            connect(view_model_.get(),
                    &AddOrderDialogViewModel::SQLModelChanged,
                    this,
                    &AddOrderDialogView::OnSQLModelChanged);
        }
        //ПІДКЛЮЧИТИ кінцевий вивід
        void AddOrderDialogView::OnSQLModelChanged() {
            SetDocumentState(view_model_->GetDocumentStateTypes());
            SetBillState(view_model_->GetBillStateTypes());

            auto managers = view_model_->GetManagers();
            SetManagers(managers);

            if (!managers.empty()) {
                auto manager = managers.at(manager_index_);
                SetCompanies(view_model_->GetManagerCompanies(manager.name));
            }

     //!!!SetDocumentState(view_model_->GetDocumentStateTypes());
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

            // Clear the previous combo box data
            ui_->companyComboBox->clear();

            // Add values to the combobox
            for (const auto& company : value) {
                ui_->companyComboBox->addItem(company.CompanyShortName);
            }
        }

        void AddOrderDialogView::SetDocumentState(QVector<models::REFERENCES_ORDER_DocumentStateTypeModel::DocumentStateType> value){
            // Sanity check
            if (value.isEmpty()) return;

            for (const auto& documentstate : value) {
                ui_->DocumentStateComboBox->addItem(documentstate.name);
            }
        }

        void AddOrderDialogView::SetBillState(QVector<models::REFERENCES_ORDER_BillStateTypeModel::BillStateType> value){
            // Sanity check
            if (value.isEmpty()) return;

            for (const auto& billstate : value) {
                ui_->BillStateComboBox->addItem(billstate.name);
            }
        }
        //Забір даних з інтерфейсу  для збереження
        void AddOrderDialogView::on_addRecordButton_clicked() {
            OrderModel::Order order;
            order.InvoiceNumber = ui_->lineEdit_OrderNo->text();
            order.company       = ui_->companyComboBox->itemText(company_index_);
            order.manager       = ui_->managerComboBox->itemText(manager_index_);
            order.DocumentState = ui_->DocumentStateComboBox->itemText(documentstate_index_);
            order.BillState     = ui_->BillStateComboBox->itemText(billstate_index_);

            if (!view_model_->AddOrder(order)) {
                // TODO : crate a dialog with failure data
            }

            //Close AddOrderWidget
            close();
        }

        void AddOrderDialogView::OnManagerIndexChanged(
                unsigned int value) {
            manager_index_ = value;

            auto managers = view_model_->GetManagers();
            if (!managers.empty()) {
                auto manager = managers.at(manager_index_);
                SetCompanies(view_model_->GetManagerCompanies(manager.name));

                // Reset the index
                company_index_ = 0;
            }
        }

        void AddOrderDialogView::OnCompanyIndexChanged(
                unsigned int value) {
            company_index_ = value;
        }

        void AddOrderDialogView::OnDocumentStateIndexChanged(unsigned int value){
            documentstate_index_ = value;
        }
        void AddOrderDialogView::OnBillStateIndexChanged(unsigned int value){
            billstate_index_ = value;
        }
    } // namespace views
} // namespace erp
