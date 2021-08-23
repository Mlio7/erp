#ifndef ERP_VIEWS_ADDORDERWIDGETVIEW_H
#define ERP_VIEWS_ADDORDERWIDGETVIEW_H

#include <QWidget>

#include "ui_addorderdialog.h"
#include "viewmodels/addorderdialogviewmodel.h"

namespace erp {
    namespace views {
        /**
         * @brief The AddOrderDialogView class
         */
        class AddOrderDialogView : public QWidget {

            using AddOrderDialogViewModel = erp::viewmodels::AddOrderDialogViewModel;
            using OrderModel = erp::models::OrderModel;
            using CompanyModel = erp::models::CompanyModel;
            using ManagerModel = erp::models::ManagerModel;

            Q_OBJECT

        public:
            explicit AddOrderDialogView(QWidget* parent = nullptr);

        public:
            std::shared_ptr<AddOrderDialogViewModel> GetViewModel() const noexcept;

        public slots:
            void OnSQLModelChanged();

        private slots:
            void on_addRecordButton_clicked();
            void OnManagerIndexChanged(unsigned int value);
            void OnCompanyIndexChanged(unsigned int value);

        protected:
            void Init() const noexcept;

            void SetManagers(QVector<ManagerModel::Manager> value);
            void SetCompanies(QVector<CompanyModel::Company> value);

        private:
            unsigned int manager_index_{0};
            unsigned int company_index_{0};

            std::shared_ptr<AddOrderDialogViewModel> view_model_;
            std::unique_ptr<Ui::AddOrderDialog> ui_;
        };
    } // namespace views
} // namespace erp

#endif // ERP_VIEWS_ADDORDERWIDGETVIEW_H
