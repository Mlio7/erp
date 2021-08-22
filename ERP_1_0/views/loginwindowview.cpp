#include "loginwindowview.h"

namespace erp {
    namespace views {
        LoginWindowView::LoginWindowView(QDialog* parent) :
            QDialog(parent),
            ui_{std::make_unique<Ui::LoginWindow>()},
            view_model_{std::make_shared<LoginWindowViewModel>()} {
            // Connect the view model
            connect(view_model_.get(),
                    &LoginWindowViewModel::VisibilityChanged,
                    this,
                    &LoginWindowView::OnVisibilityChanged);
            // Initialize the UI
            Init();
        }

        void LoginWindowView::Init() {
            // Setup the UI
            ui_->setupUi(this);
            ui_->passwordField->setEchoMode(QLineEdit::Password);

            // Connect UI to the backend
            connect(ui_->connectButton,
                    &QPushButton::clicked,
                    this,
                    &LoginWindowView::OnConnectButtonClicked);
        }

        std::shared_ptr<LoginWindowView::LoginWindowViewModel>
        LoginWindowView::GetViewModel() const noexcept {
            return view_model_;
        }

        void LoginWindowView::OnConnectButtonClicked() {
            LoginWindowViewModel::LoginData data;
            data.database = ui_->dbField->text();
            data.password = ui_->passwordField->text();
            data.server =   ui_->serverField->text();
            data.user =     ui_->usernameField->text();
            //data.database =  "H-PC"; //ui_->dbField->text();
            //data.password =  "ERP";  //ui_->passwordField->text();
            //data.server =    "test"; //ui_->serverField->text();
            //data.user =      "1";    //ui_->usernameField->text();

            // Try to log in
            view_model_->Login(data);

            // Proceed to the main window
            if (view_model_->IsLoggedIn()) {
                ui_->statusbar->showMessage("Connection successful",1000);
                return;
            }

            // Show the message of failure
            messageBox->setText("Connection failed. Please, try again.");
            messageBox->show();
        }

        void LoginWindowView::OnVisibilityChanged(bool value) {
            if (value) show();
            else hide();
        }

        void LoginWindowView::reject() {
            // Call the method from the superclass
            QDialog::reject();

            // Exit the app
            exit(0);
        }
    } // namespace views
} // namespace erp
