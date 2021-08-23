#include "mainwindowview.h"

namespace erp {
    namespace views {
        MainWindowView::MainWindowView(QMainWindow* parent) :
            QMainWindow(parent),
            ui_{std::make_unique<Ui::MainWindow>()},
            view_model_{std::make_shared<MainWindowViewModel>()} {
            // Initialize the UI
            Init();

            // Connect the view model
            connect(view_model_.get(),
                    &MainWindowViewModel::VisibilityChanged,
                    this,
                    &MainWindowView::OnVisibilityChanged);

            // Show the login prompt
            CreateLoginPrompt();
        }

        void MainWindowView::CreateLoginPrompt() noexcept {
            // Create a login window
            login_dialog_ = std::make_shared<LoginWindowView>();
            login_dialog_->GetViewModel()->SetSQLModel(view_model_->GetSQLModel());
            login_dialog_->exec();
        }

        void MainWindowView::Init() {
            // Setup the UI
            ui_->setupUi(this);

            // FIXME : find a better way to remove default tabs
            ui_->tabWidget->clear();
        }

        std::shared_ptr<MainWindowView::MainWindowViewModel>
        MainWindowView::GetViewModel() const noexcept {
            return view_model_;
        }

        void MainWindowView::OnVisibilityChanged(bool value) {
            if (value) show();
            else hide();
        }

        void MainWindowView::on_actionOrders_triggered() {
            // FIXME : this doesn't work with smart pointers
            auto order_widget = new OrderWidgetView();
            order_widget->GetViewModel()->SetSQLModel(view_model_->GetSQLModel());

            // Add a new tab to the window
            ui_->tabWidget->addTab(order_widget, "Orders");
        }

        void MainWindowView::on_tabWidget_tabCloseRequested(int index) {
            ui_->tabWidget->removeTab(index);
        }

        void MainWindowView::on_actionCompanies_triggered() {
            // FIXME : this doesn't work with smart pointers
            auto companies_widget = new CompanyWidgetView();
            companies_widget->GetViewModel()->SetSQLModel(view_model_->GetSQLModel());

            // Add a new tab to the window
            ui_->tabWidget->addTab(companies_widget, "Companies");
        }
    } // naespace views
} // namespace erp
