#include "orderwidgetviewmodel.h"

namespace erp {
    namespace viewmodels {
        OrderWidgetViewModel::OrderWidgetViewModel() :
            AbstractViewModel() {
        }

        void OrderWidgetViewModel::ConnectSQLModel(
                std::shared_ptr<SQLModel> model) noexcept {
            Refresh();
        }

        void OrderWidgetViewModel::DisconnectSQLModel(
                std::shared_ptr<SQLModel> model) noexcept {
            Q_UNUSED(model)
        }

        void OrderWidgetViewModel::Refresh() {
            query_model_ = std::make_shared<QSqlQueryModel>();
            //RAW SELECT
            query_model_->setQuery("select [tbl_Order].[CreatedOn],\
                            [tbl_Order].[InvoiceNumber],\
                            [tbl_Users].[Name],\
                            [tbl_Company].[CompanyShortName],\
                            [tbl_REFERENCES_ORDER_DocumentStateType].[Name],\
                            [tbl_Order].[SumNoVAT],\
                            [tbl_Order].[SumVAT],\
                            [tbl_REFERENCES_ORDER_BillStateType].[Name],\
                            [tbl_REFERENCES_DELIVERY_StateType].[Name]\
                            from [ERP].[dbo].[tbl_Order]\
                            full join  [dbo].[tbl_Company] on  [dbo].[tbl_Order].[CompanyID] = [dbo].[tbl_Company].[ID]\
                             join  [dbo].[tbl_Users] on  [dbo].[tbl_Order].[ResponsibleUserID] = [dbo].[tbl_Users].[ID]\
                             join  [dbo].[tbl_REFERENCES_ORDER_DocumentStateType] on  [dbo].[tbl_Order].[OrderDocumentStateTypeID] = [dbo].[tbl_REFERENCES_ORDER_DocumentStateType].[ID]\
                             join  [dbo].[tbl_REFERENCES_ORDER_BillStateType] on  [dbo].[tbl_Order].[OrderBillStateTypeID] = [dbo].[tbl_REFERENCES_ORDER_BillStateType].[ID]\
                            full join  [dbo].[tbl_REFERENCES_DELIVERY_StateType] on  [dbo].[tbl_Order].[DeliveryStateTypeID] = [dbo].[tbl_REFERENCES_DELIVERY_StateType].[ID] ORDER BY [tbl_Order].[CreatedOn]\
");

            query_model_->setHeaderData(0,Qt::Horizontal,"Дата створення");
            query_model_->setHeaderData(1,Qt::Horizontal,"№ Замовлення");
            query_model_->setHeaderData(2,Qt::Horizontal,"Відповідальний");
            query_model_->setHeaderData(3,Qt::Horizontal,"Контрагент");
            query_model_->setHeaderData(4,Qt::Horizontal,"Документ");
            query_model_->setHeaderData(5,Qt::Horizontal,"Сума без ПДВ");
            query_model_->setHeaderData(6,Qt::Horizontal,"Сума з ПДВ");
            query_model_->setHeaderData(7,Qt::Horizontal,"Стан оплати");
            query_model_->setHeaderData(8,Qt::Horizontal,"Стан відгрузки");

            emit DataRefreshed();
        }

        // FIXME : temporary code
        std::shared_ptr<QSqlQueryModel>
        OrderWidgetViewModel::GetTableViewModel() const {
            return query_model_;
        }

        void OrderWidgetViewModel::OnOrdersUpdated() {
            Refresh();
        }
    } // namespace viewodels
} // namespace erp
