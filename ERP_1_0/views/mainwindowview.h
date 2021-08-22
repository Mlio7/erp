#ifndef ERP_VIEWS_MAINWINDOWVIEW_H
#define ERP_VIEWS_MAINWINDOWVIEW_H

#include "ui_mainwindow.h"

#include "views/loginwindowview.h"
#include "views/addorderdialogview.h"
#include "views/orderwidgetview.h"

#include "viewmodels/mainwindowviewmodel.h"

namespace erp {
    namespace views {
        /**
         * @brief The MainWindowView class
         */
        class MainWindowView : public QMainWindow {

            using MainWindowViewModel = erp::viewmodels::MainWindowViewModel;

            Q_OBJECT

        public:
            MainWindowView(QMainWindow* parent = nullptr);

        public:
            std::shared_ptr<MainWindowViewModel> GetViewModel() const noexcept;

        public slots:
            void OnVisibilityChanged(bool value);

        private slots:
            void on_actionOrders_triggered();
            void on_tabWidget_tabCloseRequested(int index);
            void on_actionCompanies_triggered();

        protected:
            virtual void Init();

        private:
            void CreateLoginPrompt() noexcept;

        private:
            std::unique_ptr<Ui::MainWindow> ui_;
            std::shared_ptr<LoginWindowView> login_dialog_;

            std::shared_ptr<MainWindowViewModel> view_model_;
        };
    } // naespace views
} // namespace erp

#endif // ERP_VIEWS_MAINWINDOWVIEW_H
