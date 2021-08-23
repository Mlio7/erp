#include "companywidgetview.h"

namespace erp {
    namespace views {

        CompanyWidgetView::CompanyWidgetView(QWidget *parent) :
            QWidget(parent),
            ui_{std::make_unique<Ui::CompanyWidget>()},
            view_model_{std::make_shared<CompanyWidgetViewModel>()} {
            // Initialize the UI
            Init();
        }

        std::shared_ptr<CompanyWidgetView::CompanyWidgetViewModel>
        CompanyWidgetView::GetViewModel() const noexcept {
            return view_model_;
        }

        void CompanyWidgetView::Init() {
            // Connect the model
            connect(view_model_.get(),
                    &CompanyWidgetViewModel::SQLModelChanged,
                     this,
                    &CompanyWidgetView::OnSQLModelChanged);

            // Setup the UI
            ui_->setupUi(this);

            // Connect the UI elements
            connect(ui_->pushButton_CompanyAddNew,
                    &QPushButton::clicked,
                    this,
                    &CompanyWidgetView::OnAddCompanyButtonClicked);
        }

        void CompanyWidgetView::OnAddCompanyButtonClicked() {

        }

        void CompanyWidgetView::OnSQLModelChanged() {
            // Connect the signals and slots
            /*
            connect(view_model_->GetSQLModel().get(),
                    &erp::models::SQLModel::DatabaseUpdated,
                    view_model_.get(),
                    &CompanyWidgetViewModel::OnDatabaseUpdated);
                    */

            // FIXME : temporary code
            auto model = view_model_->GetTableViewModel();
            if (model) ui_->tableView_CompanyList->setModel(model.get());
        }
} // naespace views
} // namespace erp
