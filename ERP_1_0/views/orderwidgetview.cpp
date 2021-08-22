#include "orderwidgetview.h"

namespace erp {
    namespace views {
        OrderWidgetView::OrderWidgetView(QWidget *parent) :
            QWidget(parent),
            ui_{std::make_unique<Ui::OrderWidget>()},
            view_model_{std::make_shared<OrderWidgetViewModel>()} {
            // Initialize the UI
            Init();
        }

        std::shared_ptr<OrderWidgetView::OrderWidgetViewModel>
        OrderWidgetView::GetViewModel() const noexcept {
            return view_model_;
        }

        void OrderWidgetView::Init() {
            // Setup the UI
            ui_->setupUi(this);

            // Connect the UI elements
            connect(ui_->addOrderButton,
                    &QPushButton::clicked,
                    this,
                    &OrderWidgetView::OnAddOrderButtonClicked);

            // Connect the model
            connect(view_model_.get(),
                     &OrderWidgetViewModel::ModelUpdated,
                     this,
                     &OrderWidgetView::OnModelUpdated);
        }

        void OrderWidgetView::OnAddOrderButtonClicked() {
            add_order_dialog_ = std::make_shared<AddOrderDialogView>();
            add_order_dialog_->GetViewModel()->SetSQLModel(
                        view_model_->GetSQLModel());

            // Connect the signals and slots
            connect(add_order_dialog_.get(),
                    &AddOrderDialogView::DatabaseUpdated,
                    view_model_.get(),
                    &OrderWidgetViewModel::OnDatabaseUpdated);

            // Show the window
            add_order_dialog_->show();
        }

        void OrderWidgetView::OnModelUpdated() {
            // FIXME : temporary code
            auto model = view_model_->GetTableViewModel();
            if (model) ui_->contentTabView->setModel(model.get());
        }
    } // naespace views
} // namespace erp
