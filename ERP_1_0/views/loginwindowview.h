#ifndef ERP_VIEWS_LOGINWINDOWVIEW_H
#define ERP_VIEWS_LOGINWINDOWVIEW_H

#include <QDialog>
#include <QMessageBox>

#include "viewmodels/loginwindowviewmodel.h"

#include "ui_loginwindow.h"

namespace erp {
    namespace views {
         /**
         * @brief The LoginWindowView class
         */
        class LoginWindowView : public QDialog {

            using LoginWindowViewModel = erp::viewmodels::LoginWindowViewModel;

            Q_OBJECT

        public:
            LoginWindowView(QDialog* parent = nullptr);

        public:
            std::shared_ptr<LoginWindowViewModel> GetViewModel() const noexcept;

        public slots:
            void OnVisibilityChanged(bool value);

        private slots:
            void OnConnectButtonClicked();

        protected:
            virtual void Init();
            void reject() override;

        private:
            std::unique_ptr<Ui::LoginWindow> ui_;
            std::shared_ptr<LoginWindowViewModel> view_model_;

            std::shared_ptr<QMessageBox> messageBox{std::make_shared<QMessageBox>()};
        };
    } // namespace views
} // namespace erp

#endif // ERP_VIEWS_LOGINWINDOWVIEW_H
