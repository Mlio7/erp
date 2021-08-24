#include "orderwidgetview.h"

#include "ui_orderwidget.h"

namespace erp {
    namespace views {
        OrderWidgetView::OrderWidgetView(QWidget *parent) :
            QWidget(parent),
            ui_{std::make_unique<Ui::OrderWidget>()},
            view_model_{std::make_shared<OrderWidgetViewModel>()} {
            // Initialize the UI
            Init();

            // Connect the signals and slots
            /*
            connect(view_model_->GetSQLModel().get(),
                    &erp::models::SQLModel::DatabaseUpdated,
                    view_model_.get(),
                    &OrderWidgetViewModel::OnDatabaseUpdated);
                    */
        }

        std::shared_ptr<OrderWidgetView::OrderWidgetViewModel>
        OrderWidgetView::GetViewModel() const noexcept {
            return view_model_;
        }

        void OrderWidgetView::Init() {
            // Connect the model
            connect(view_model_.get(),
                     &OrderWidgetViewModel::SQLModelChanged,
                     this,
                     &OrderWidgetView::OnSQLModelChanged);
            connect(view_model_.get(),
                     &OrderWidgetViewModel::DataRefreshed,
                     this,
                     &OrderWidgetView::OnDataRefreshed);

            // Setup the UI
            ui_->setupUi(this);

            // Connect the UI elements
            connect(ui_->addOrderButton,
                    &QPushButton::clicked,
                    this,
                    &OrderWidgetView::OnAddOrderButtonClicked);
        }

        void OrderWidgetView::OnAddOrderButtonClicked() {
            add_order_dialog_ = std::make_shared<AddOrderDialogView>();
            add_order_dialog_->GetViewModel()->SetSQLModel(
                        view_model_->GetSQLModel());

            // Connect to the database updates
            auto order_model = add_order_dialog_->GetViewModel()->GetOrderModel();
            connect(order_model.get(),
                    &erp::models::OrderModel::OrdersUpdated,
                    view_model_.get(),
                    &OrderWidgetViewModel::OnOrdersUpdated);

            // Show the window
            add_order_dialog_->show();
        }

        void OrderWidgetView::OnDataRefreshed() {
            updateContent();
        }

        void OrderWidgetView::OnSQLModelChanged() {
            updateContent();
        }

        void OrderWidgetView::updateContent() {
            // FIXME : temporary code
            auto model = view_model_->GetTableViewModel();
            if (model) ui_->contentTabView->setModel(model.get());
        }
    } // naespace views
} // namespace erp
