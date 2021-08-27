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
            using REFERENCES_ORDER_DocumentStateTypeModel = erp::models::REFERENCES_ORDER_DocumentStateTypeModel;
            using REFERENCES_ORDER_BillStateTypeModel = erp::models::REFERENCES_ORDER_BillStateTypeModel;
            using REFERENCES_DELIVERY_StateTypeModel = erp::models::REFERENCES_DELIVERY_StateTypeModel;
            Q_OBJECT

        public:
            explicit AddOrderDialogView(QWidget* parent = nullptr);

        public:
            std::shared_ptr<AddOrderDialogViewModel> GetViewModel() const noexcept;

        public slots:
            void OnSQLModelChanged();

        private slots:
            void on_addRecordButton_clicked();
            //combo box
            void OnManagerIndexChanged(unsigned int value);
            void OnCompanyIndexChanged(unsigned int value);
            void OnDocumentStateIndexChanged(unsigned int value);
            void OnBillStateIndexChanged(unsigned int value);
            void OnDeliveryStateIndexChanged(unsigned int value);
        protected:
            void Init() const noexcept;

            void SetManagers(QVector     <ManagerModel::Manager> value);
            void SetCompanies(QVector    <CompanyModel::Company> value);
            void SetDocumentState(QVector<REFERENCES_ORDER_DocumentStateTypeModel::DocumentStateType> value);
            void SetBillState(QVector    <REFERENCES_ORDER_BillStateTypeModel::BillStateType> value);
            void SetDeliveryState(QVector<REFERENCES_DELIVERY_StateTypeModel::DELIVERY_StateType> value);
        private:
            unsigned int manager_index_{0};
            unsigned int company_index_{0};
            unsigned int documentstate_index_{0};
            unsigned int billstate_index_{0};
            unsigned int deliverystate_index_{0};
            std::shared_ptr<AddOrderDialogViewModel> view_model_;
            std::unique_ptr<Ui::AddOrderDialog> ui_;
        };
    } // namespace views
} // namespace erp

#endif // ERP_VIEWS_ADDORDERWIDGETVIEW_H
